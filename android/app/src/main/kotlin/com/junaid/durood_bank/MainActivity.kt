package com.junaid.durood_bank

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.junaid.durood_bank.services.DuroodService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.jetbrains.annotations.NotNull

class MainActivity : FlutterActivity() {

    private val channel = "com.junaid.durood_bank/NATIVE_SERVICE"
    private var serviceAction: String? = ""

    private lateinit var notificationManager: NotificationManager
    private lateinit var builder: Notification.Builder
    private val channelId = "durood_channel"
    private val description = "Durood Notifications"

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(@NotNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "DUROOD_LOCK_SERVICE" -> {
                    serviceAction = call.argument("service_action")
                    when (serviceAction) {
                        "START" -> startDuroodService()
                        "STOP" -> stopDuroodService()
                    }
                }
                "NOTIFICATION_SERVICE" -> {
                    var channel = NotificationChannel(
                        channelId,
                        description, NotificationManager.IMPORTANCE_DEFAULT
                    )

                    (getSystemService(NOTIFICATION_SERVICE) as NotificationManager).createNotificationChannel(
                        channel
                    )

                    notificationManager =
                        getSystemService(NOTIFICATION_SERVICE) as NotificationManager

                    NotificationCompat.Builder(this, "durood_channel")
                        .setContentTitle("")
                        .setContentText("").build()

                    val pendingIntent = PendingIntent.getActivity(
                        this,
                        0,
                        intent,
                        PendingIntent.FLAG_UPDATE_CURRENT
                    )

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        channel = NotificationChannel(
                            "durood_channel",
                            "Duroood Notifications",
                            NotificationManager.IMPORTANCE_HIGH
                        )
                        channel.enableLights(true)
                        channel.enableVibration(false)
                        notificationManager.createNotificationChannel(channel)

                        builder = Notification.Builder(this, channelId)
                            .setContentTitle(call.argument("title"))
                            .setContentText(call.argument("body"))
                            .setSmallIcon(R.drawable.app_icon)
                            .setLargeIcon(
                                BitmapFactory.decodeResource(
                                    this.resources,
                                    R.drawable.app_icon
                                )
                            )
                            .setContentIntent(pendingIntent)
                    } else {
                        builder = Notification.Builder(this)
                            .setContentTitle(call.argument("title"))
                            .setContentText(call.argument("body"))
                            .setSmallIcon(R.drawable.app_icon)
                            .setLargeIcon(
                                BitmapFactory.decodeResource(
                                    this.resources,
                                    R.drawable.app_icon
                                )
                            )
                            .setContentIntent(pendingIntent)
                    }
                    notificationManager.notify(System.currentTimeMillis().toInt(), builder.build())

                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onStart() {
        super.onStart()
        firstTimeAppRunDuroodSere()
    }

    private fun firstTimeAppRunDuroodSere() {
        val sharedPreference = getSharedPreferences("DUROOD_BANK_PREFERENCE", Context.MODE_PRIVATE)
        if (sharedPreference.getString("first_time", "") != "") {
            startDuroodService()
            val editor = sharedPreference.edit()
            editor.putString("first_time", "DONE")
            editor.apply()
        }
    }

    private fun startDuroodService() {
        Intent(this, DuroodService::class.java).also {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(it)
            } else {
                context.startService(it)
            }
        }
    }

    private fun stopDuroodService() {
        Intent(this, DuroodService::class.java).also {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.stopService(it)
            } else {
                context.stopService(it)
            }
        }
    }
}
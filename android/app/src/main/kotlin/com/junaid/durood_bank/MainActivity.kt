package com.junaid.durood_bank

import android.content.Context
import android.content.Intent
import android.os.Build
import com.junaid.durood_bank.services.DuroodService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.jetbrains.annotations.NotNull

class MainActivity : FlutterActivity() {

    private val channel = "com.junaid.durood_bank/NATIVE_SERVICE"
    var serviceAction: String? = ""

    override fun configureFlutterEngine(@NotNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "DUROOD_LOCK_SERVICE") {
                serviceAction = call.argument("service_action")
                when (serviceAction) {
                    "START" -> startDuroodService()
                    "STOP" -> stopDuroodService()
                }
            } else {
                result.notImplemented()
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
package com.junaid.durood_bank

import android.content.Intent
import android.os.Build
import android.speech.tts.TextToSpeech.STOPPED
import android.telephony.ServiceState
import com.junaid.durood_bank.services.DuroodService
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    override fun onStart() {
        super.onStart()
//        val receiver: PhoneLockUnlockReceiver = PhoneLockUnlockReceiver()
//        receiver.registerBroadcastReceiver()
        actionOnService()
    }

    private fun actionOnService() {
        Intent(this, DuroodService::class.java).also {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.startForegroundService(it)
                return
            }else {
                context.startService(it)
            }
        }
    }
}

package com.junaid.durood_bank.receiver;

import static io.flutter.plugins.firebase.messaging.ContextHolder.getApplicationContext;

import android.app.KeyguardManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.MediaPlayer;
import android.util.Log;

import com.junaid.durood_bank.R;

public class PhoneLockUnlockReceiver {

    BroadcastReceiver screenOnOffReceiver;
    final IntentFilter theFilter = new IntentFilter();

    public PhoneLockUnlockReceiver() {
        theFilter.addAction(Intent.ACTION_SCREEN_ON);
        theFilter.addAction(Intent.ACTION_SCREEN_OFF);
        theFilter.addAction(Intent.ACTION_USER_PRESENT);

        screenOnOffReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                String strAction = intent.getAction();

                KeyguardManager myKM = (KeyguardManager) context.getSystemService(Context.KEYGUARD_SERVICE);
                if (strAction.matches(Intent.ACTION_USER_PRESENT))
                    if (myKM.inKeyguardRestrictedInputMode()) {
                        Log.d("BroadReceiver", "phone is LOCKED");
                    } else {
                        MediaPlayer mp;
                        mp = MediaPlayer.create(getApplicationContext(), R.raw.s1);
                        mp.start();
                    }
            }
        };
    }

    public void registerBroadcastReceiver() {
        getApplicationContext().registerReceiver(screenOnOffReceiver, theFilter);
    }

    public void unRegisterBroadcastReceiver() {
        getApplicationContext().unregisterReceiver(screenOnOffReceiver);
    }
}

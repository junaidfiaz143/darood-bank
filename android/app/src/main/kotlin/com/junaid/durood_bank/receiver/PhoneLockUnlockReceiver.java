package com.junaid.durood_bank.receiver;

import static io.flutter.plugins.firebase.messaging.ContextHolder.getApplicationContext;

import android.app.KeyguardManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.MediaPlayer;
import android.util.Log;
import android.widget.Toast;

import com.junaid.durood_bank.R;

//public class PhoneLockUnlockReceiver extends BroadcastReceiver {
//    @Override
//    public void onReceive(Context context, Intent intent) {
//        if (intent.getAction().equals(Intent.ACTION_USER_PRESENT)){
//            Toast.makeText(context, "phone unlocked", Toast.LENGTH_SHORT).show();
//        }else if (intent.getAction().equals(Intent.ACTION_SCREEN_OFF)){
//            Toast.makeText(context, "phone locked", Toast.LENGTH_SHORT).show();
//        }
//    }
//}

public class PhoneLockUnlockReceiver {

    public void registerBroadcastReceiver() {

        final IntentFilter theFilter = new IntentFilter();
        theFilter.addAction(Intent.ACTION_SCREEN_ON);
        theFilter.addAction(Intent.ACTION_SCREEN_OFF);
        theFilter.addAction(Intent.ACTION_USER_PRESENT);

        BroadcastReceiver screenOnOffReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                String strAction = intent.getAction();

                KeyguardManager myKM = (KeyguardManager) context.getSystemService(Context.KEYGUARD_SERVICE);
                if (strAction.matches(Intent.ACTION_USER_PRESENT))
                    if (myKM.inKeyguardRestrictedInputMode()) {
                        Log.d("BroadReceiver","phone is LOCKED");
                    } else {
                        MediaPlayer mp;
                        mp = MediaPlayer.create(getApplicationContext(), R.raw.s1);
                        mp.start();
                    }
            }
        };

        getApplicationContext().registerReceiver(screenOnOffReceiver, theFilter);
    }
}

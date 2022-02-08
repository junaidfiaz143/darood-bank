package com.junaid.durood_bank.services;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.core.app.NotificationCompat;

import com.junaid.durood_bank.R;
import com.junaid.durood_bank.receiver.PhoneLockUnlockReceiver;

public class DuroodService extends Service {
    int mStartMode;       // indicates how to behave if the service is killed
    IBinder mBinder;      // interface for clients that bind
    boolean mAllowRebind; // indicates whether onRebind should be used

    final int NOTIFICATION_ID = 555;

    @Override
    public void onCreate() {
        // The service is being created

        PhoneLockUnlockReceiver receiver = new PhoneLockUnlockReceiver();
        receiver.registerBroadcastReceiver();

        if (Build.VERSION.SDK_INT >= 26) {
            String CHANNEL_ID = "my_channel_01";
            NotificationChannel channel = new NotificationChannel(CHANNEL_ID,
                    "Channel human readable title",
                    NotificationManager.IMPORTANCE_DEFAULT);

            ((NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE)).createNotificationChannel(channel);

            Notification notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                    .setContentTitle("")
                    .setContentText("").build();

            startForeground(1, notification);
        }
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // The service is starting, due to a call to startService()
//        PhoneLockUnlockReceiver receiver = new PhoneLockUnlockReceiver();
//        receiver.registerBroadcastReceiver();

//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            Notification.Builder builder = new Notification.Builder(this, "com.junaid.durood_bank.Channel")
//                    .setContentTitle("Durood Bank")
//                    .setContentText("SmartTracker Running")
//                    .setAutoCancel(true);
//            Notification notification = builder.build();
//            startForeground(NOTIFICATION_ID, notification);
//        } else {
//            NotificationCompat.Builder builder = new NotificationCompat.Builder(this, "com.junaid.durood_bank.Channel")
//                    .setContentTitle("Durood Bank")
//                    .setContentText("SmartTracker is Running...")
//                    .setPriority(NotificationCompat.PRIORITY_DEFAULT)
//                    .setAutoCancel(true);
//            Notification notification = builder.build();
//            startForeground(NOTIFICATION_ID, notification);
//        }

        return mStartMode;
    }

    @Override
    public IBinder onBind(Intent intent) {
        // A client is binding to the service with bindService()
        return mBinder;
    }

    @Override
    public boolean onUnbind(Intent intent) {
        // All clients have unbound with unbindService()
        return mAllowRebind;
    }

    @Override
    public void onRebind(Intent intent) {
        // A client is binding to the service with bindService(),
        // after onUnbind() has already been called
    }

    @Override
    public void onDestroy() {
        // The service is no longer used and is being destroyed
    }
}
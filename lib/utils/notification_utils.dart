import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {
  static Future showNotification(String title, String body) async {
    var androidInit = const AndroidInitializationSettings("app_icon");
    var iOSInit = const IOSInitializationSettings();

    var initializationSettings =
        InitializationSettings(android: androidInit, iOS: iOSInit);

    FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
        FlutterLocalNotificationsPlugin();

    flutterLocalNotificationPlugin.initialize(initializationSettings,
        onSelectNotification: (dynamic payload) async {});

    var androidDetails = const AndroidNotificationDetails(
        "durood_channel", 'DuroodBank',
        playSound: true);

    var iOSDetails = const IOSNotificationDetails();

    var notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationPlugin
        .show(2, title, body, notificationDetails, payload: "knock_brush");
  }

  static Future<void> sendPushNotification(
      {required String? title, required String? message}) async {
    try {
      dynamic userData = {
        "to": "/topics/all",
        "data": {
          "via": "FlutterFire Cloud Messaging!!!",
          "count": "0",
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
        },
        "notification": {
          "title": "$title",
          "body": "$message",
          "sound": "knock_brush.mp3"
        }
      };

      await Dio().post(
        "https://fcm.googleapis.com/fcm/send",
        data: userData,
        options: Options(
          headers: {
            "content-type": "application/json",
            "authorization":
                "key=AAAAI-7aEck:APA91bGRZoetLpTo1Q2Wmlt_FFkjxJFl_SVDBjuVM2ECEHlmI0Sp61z1dbkPpfX1XOX0b-456zBSUhsCtoq_tMU7xEPR17iGYxe5oi1kj7riQM04gth_3iUTr-NZKzadjs75KMKuAG9I",
          },
        ),
      );
      debugPrint('FCM request for device sent!');
    } catch (e) {
      debugPrint("$e");
    }
  }
}

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

    var androidDetails =
        const AndroidNotificationDetails("007", 'DaroodBank', playSound: true);

    var iOSDetails = const IOSNotificationDetails();

    var notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await flutterLocalNotificationPlugin
        .show(2, title, body, notificationDetails, payload: "knock_brush");
  }

  static Future<void> sendPushNotification(
      {required String? token,
      required String? title,
      required String? message}) async {
    if (token == null) {
      debugPrint('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      dynamic userData = {
        "to": token,
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
                "key=AAAAfI2o1Jo:APA91bEksyzNyRtt5WOSGgUETzN3dCR4KR1b2AWa1nXoOoxCFJLp3OqmhC6n133TFozyD2SMxjG71EgXAvIWunnM_ON8L7-h8mQhGYI1VMXQX6TgDMPb6KZviQR0zZa5zN5bszIH9wRq"
          },
        ),
      );
      debugPrint('FCM request for device sent!');
    } catch (e) {
      debugPrint("$e");
    }
  }
}

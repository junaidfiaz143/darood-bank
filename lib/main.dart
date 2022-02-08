import 'package:durood_bank/models/slider_model.dart';
import 'package:durood_bank/screens/logging_in_screen/logging_in_screen.dart';
import 'package:durood_bank/utils/globals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/login_state_model.dart';

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  bool kIsWeb = false;
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // await FirebaseMessaging.instance.subscribeToTopic('all');
    // FirebaseMessaging.instance.
  }

  FirebaseMessaging.instance
      .getToken(
          // vapidKey:
          //     'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA'
          )
      .then((token) {
    fcmId = token!;
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Map<int, Color> color = {
    50: const Color.fromRGBO(70, 161, 134, .1),
    100: const Color.fromRGBO(70, 161, 134, .2),
    200: const Color.fromRGBO(70, 161, 134, .3),
    300: const Color.fromRGBO(70, 161, 134, .4),
    400: const Color.fromRGBO(70, 161, 134, .5),
    500: const Color.fromRGBO(70, 161, 134, .6),
    600: const Color.fromRGBO(70, 161, 134, .7),
    700: const Color.fromRGBO(70, 161, 134, .8),
    800: const Color.fromRGBO(70, 161, 134, .9),
    900: const Color.fromRGBO(70, 161, 134, 1),
  };
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginStateModel>(
            create: (context) => LoginStateModel(isLoading: false)),
        ChangeNotifierProvider<SliderModel>(create: (context) => SliderModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Durood Bank',
        theme: ThemeData(
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: MaterialColor(0XFF46A186, color),
        ),
        home: const LoggingInScreen(),
      ),
    );
  }
}

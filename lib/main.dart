import 'dart:io';

import 'package:durood_bank/models/current_user_model.dart';
import 'package:durood_bank/models/otp_callback_model.dart';
import 'package:durood_bank/models/slider_model.dart';
import 'package:durood_bank/screens/about_us_screen/about_us_screen.dart';
import 'package:durood_bank/screens/community_screen/community_screen.dart';
import 'package:durood_bank/screens/contact_us_screen/contact_us_screen.dart';
import 'package:durood_bank/screens/contribute_screen/contribute_screen.dart';
import 'package:durood_bank/screens/feedback_screen/feedback_screen.dart';
import 'package:durood_bank/screens/filter_screen/filter_screen.dart';
import 'package:durood_bank/screens/home_screen/home_screen.dart';
import 'package:durood_bank/screens/logging_in_screen/logging_in_screen.dart';
import 'package:durood_bank/screens/login_screen/login_screen.dart';
import 'package:durood_bank/screens/notifications_screen/notifications_screen.dart';
import 'package:durood_bank/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:durood_bank/screens/profile_screen/profile_screen.dart';
import 'package:durood_bank/screens/settings_screen/settings_screen.dart';
import 'package:durood_bank/screens/sign_up_screen/sign_up_screen.dart';
import 'package:durood_bank/screens/stats_screen/stats_screen.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/globals.dart';
import 'package:durood_bank/utils/utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'models/login_state_model.dart';
import 'models/total_durood_model.dart';

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDZyb3O5yDwLmzKni2YHAvwoSAaOpkp308",
            appId: "1:154331124169:ios:ca11eb285355ee42f95818",
            messagingSenderId: "154331124169",
            projectId: "duroodbank-aa710"));
  } else {
    await Firebase.initializeApp();
  }

  bool kIsWeb = false;
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'durood_channel', // id
      'Duroood Notifications', // title // description
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
  }

  FirebaseMessaging.instance.getToken().then((token) {
    fcmId = token!;
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<MyAppState>()!.restartApp();
  }
}

class MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !false) {
        Utilities.notificationService(
            title: notification.title!, body: notification.body!);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginStateModel>(
            create: (context) => LoginStateModel(isLoading: false)),
        ChangeNotifierProvider<SliderModel>(create: (context) => SliderModel()),
        ChangeNotifierProvider<TotalDurooodModel>(
            create: (context) => TotalDurooodModel()),
        ChangeNotifierProvider<OTPCallback>(create: (context) => OTPCallback()),
        ChangeNotifierProvider<CurrentUserModel>(
            create: (context) => CurrentUserModel()),
      ],
      child: KeyedSubtree(
        key: key,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Durood Bank",
          theme: ThemeData(
            // textTheme: GoogleFonts.quicksandTextTheme(
            //   Theme.of(context).textTheme,
            // ),
            fontFamily: "NeoSans",
            primarySwatch: MaterialColor(MyColors.primaryColor, color),
          ),
          // home: const LoggingInScreen(),
          initialRoute: "/",
          routes: {
            "/": (context) => const LoggingInScreen(),
            "/logInScreen": (context) => const LoginScreen(),
            "/signUpScreen": (context) => const SignUpScreen(),
            "/homeScreen": (context) => const HomeScreen(),
            "/profileScreen": (context) => const ProfileScreen(),
            "/contributeScreen": (context) => const ContributeScreen(),
            "/aboutScreen": (context) => const AboutUsScreen(),
            "/feedbackScreen": (context) => const FeedbackScreen(),
            "/privacyPolicyScreen": (context) => const PrivacyPolicyScreen(),
            "/contactScreen": (context) => const ContactUsScreen(),
            "/settingsScreen": (context) => const SettingsScreen(),
            "/notificationsScreen": (context) => const NotificationsScreen(),
            "/filterScreen": (context) => const FilterScreen(),
            "/statsScreen": (context) => const StatsScreen(),
            "/communityScreen": (context) => const CommunityScreen(),
          },
        ),
      ),
    );
  }
}

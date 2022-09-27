import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/models/current_user_model.dart';
import 'package:durood_bank/screens/home_screen/home_screen.dart';
import 'package:durood_bank/screens/login_screen/login_screen.dart';
import 'package:durood_bank/services/login_service.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/durood_utils.dart';
import 'package:durood_bank/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/utilities.dart';

class LoggingInScreen extends StatefulWidget {
  const LoggingInScreen({Key? key}) : super(key: key);

  @override
  _LoggingInScreenState createState() => _LoggingInScreenState();
}

class _LoggingInScreenState extends State<LoggingInScreen>
    with TickerProviderStateMixin {
  late final Animation<double> _animation;

  late final AnimationController _controller;

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  checkInternetConnection() async {
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Utilities.setFirstTimePrefrences();
        loadDetails().then((value) async {
          if (value != null) {
            final QuerySnapshot loginQuery = await FirebaseFirestore.instance
                .collection('users')
                .where("phone_number", isEqualTo: value[3])
                .where("password", isEqualTo: value[5])
                .get()
                .then((value) {
              for (var doc in value.docs) {
                doc.reference.update({"fcm_id": fcmId});
              }
              return value;
            });

            if (loginQuery.docs.isNotEmpty) {
              savePreferences(loginQuery.docs.first.data());
              loadDetails().then((value) {
                if (value != null) {
                  Provider.of<CurrentUserModel>(context, listen: false)
                      .fullName = value[0];
                  Provider.of<CurrentUserModel>(context, listen: false)
                      .userName = value[1];
                  Provider.of<CurrentUserModel>(context, listen: false)
                      .isOfficial = value[2];
                  Provider.of<CurrentUserModel>(context, listen: false)
                      .phoneNumber = value[3];
                  Provider.of<CurrentUserModel>(context, listen: false).city =
                      value[4];
                  Provider.of<CurrentUserModel>(context, listen: false)
                      .password = value[5];
                  Provider.of<CurrentUserModel>(context, listen: false).gender =
                      value[6];

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              });
            } else {
              deleteSharedPreference();

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          } else {
            deleteSharedPreference();

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
        });
      }
    });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('no internet'),
      // ));
      _controller.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // if (prefs.getBool("isOnline") != null) {
          //   if (prefs.getBool("isOnline") == true) {
          //     online = true;
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(
          //         builder: (context) => const HomeScreen(
          //           isDialogOpen: true,
          //         ),
          //       ),
          //     );
          //   } else {
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(
          //         builder: (context) => const LoginScreen(),
          //       ),
          //     );
          //   }
          // } else {
          //   Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(
          //       builder: (context) => const LoginScreen(),
          //     ),
          //   );
          // }
        }
      });
    }
  }

  @override
  void initState() {
    DuroodUtils.getCurrentContributionId(context: context);
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    checkInternetConnection();

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('$result'),
      // ));

      if (result.toString().split(".")[1] == "wifi" ||
          result.toString().split(".")[1] == "mobile") {
        // tryLogin(context);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => const LoginScreen(),
        //   ),
        // );
      } else {
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (context) => HomeScreen(),
        //   ),
        // );
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return Utilities.showAlertDialog(context,
        //           message: "No internet connection");
        //     });

      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward(from: 0);

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Text(
                "درودبينك",
                style: GoogleFonts.elMessiri(
                    color: const Color(MyColors.primaryColor),
                    fontWeight: FontWeight.bold,
                    fontSize: 66,
                    letterSpacing: 2),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

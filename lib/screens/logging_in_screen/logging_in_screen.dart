import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/models/login_state_model.dart';
import 'package:durood_bank/screens/login_screen/login_screen.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

  void tryLogin(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    updateLoadingState(bool loginState) {
      Provider.of<LoginStateModel>(context, listen: false).updateLoadingState =
          loginState;
    }

    updateLoadingState(true);

    // var response = await apiCall.postDataWithoutHeader(data);
    // if (response != null && response[Constants.keySuccess] == 1) {
    //   token = response[Constants.keyToken];
    //   riderId = response[Constants.keyRiderId];

    //   dynamic res = await Utilities.loadRiderProfile(
    //       context, prefs.getString("contact")!, prefs.getString("password")!);
    //   print(res);
    //   if (res == 1) {
    //     updateLoadingState(false);
    //   }
    // } else {
    //   if (response != null)
    //     showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return Utilities.showAlertDialog(context,
    //               message: response['message']);
    //         });
    //   updateLoadingState(false);
    //   prefs.setString("contact", "");
    //   prefs.setString("password", "");
    //   prefs.setString("username", "");
    //   prefs.setString("user_id", "");
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => LoginScreen(),
    //     ),
    //   );
    // }
  }

  checkInternetConnection() async {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durood_bank/screens/login_screen/login_screen.dart';
import 'package:durood_bank/screens/sign_up_screen/count_down.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/notification_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import '../../models/otp_callback_model.dart';

class OTPVerifyScreen extends StatefulWidget {
  final bool online;
  final dynamic user;
  const OTPVerifyScreen({Key? key, this.user, required this.online})
      : super(key: key);
  @override
  OTPVerifyScreenState createState() => OTPVerifyScreenState();
}

class RoundedButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;

  const RoundedButton({Key? key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(25, 21, 99, 1),
        ),
        alignment: Alignment.center,
        child: Text(
          '$title',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  // final _pageController = PageController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final RegExp reg = RegExp(r'^0+(?=.)');

  bool isOTPVerified = false;
  bool isOTPSent = false;

  String verificationCode = "";

  String _phoneNumber = "";
  String _origPhoneNumber = "";

  String? otpButtonText = "Send OTP";

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(color: Colors.red)),
        backgroundColor: Colors.white,
      ),
    );
  }

  sendOTP() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: _phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            print("logged in");
            // FirebaseAuth.instance.signOut();
            NotificationUtils.sendPushNotification(
                title: "Durood Bank",
                message:
                    "${widget.user["full_name"].toString().toUpperCase()} is on Durood Bank from ${widget.user["city"]}");
            FirebaseFirestore.instance
                .collection("users")
                .doc()
                .set(widget.user)
                .whenComplete(() {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => LoginScreen(
                          phoneNumber: widget.user["phone_number"]!,
                          password: widget.user["password"]!)),
                  (Route<dynamic> route) => false);
            });
          }
        });

        print("otp verified ${credential.smsCode}");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("otp timeout $verificationId");
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        print("otp code sent");

        setState(() {
          verificationCode = verificationId;
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        print("otp failed $error");
      },
    );
  }

  checkOTP(String otpCode) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              smsCode: otpCode, verificationId: verificationCode))
          .then((value) {
        if (value.user != null) {
          print("logged in");
          // FirebaseAuth.instance.signOut();
          NotificationUtils.sendPushNotification(
              title: "Durood Bank",
              message:
                  "${widget.user["full_name"].toString().toUpperCase()} is on Durood Bank from ${widget.user["city"]}");
          FirebaseFirestore.instance
              .collection("users")
              .doc()
              .set(widget.user)
              .whenComplete(() {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => LoginScreen(
                        phoneNumber: widget.user["phone_number"]!,
                        password: widget.user["password"]!)),
                (Route<dynamic> route) => false);
          });

          setState(() {
            isOTPVerified = true;
          });
        } else {
          print("invalid pin");
        }
      });
    } catch (e) {
      print(e);
      print("invalid pin");
    }
  }

  Widget otpWidget() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(5.0),
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(35.0),
                      child: Text(
                        "Verification Code",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(MyColors.primaryColor)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 0.0),
                      child: Text("Please type the verification code sent to",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(MyColors.primaryColor),
                              fontSize: 12)),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 35),
                        child: Text(_origPhoneNumber,
                            style: const TextStyle(
                                color: Color(MyColors.primaryColor),
                                fontWeight: FontWeight.bold))),
                    GestureDetector(
                      onLongPress: () {
                        // print(_formKey.currentState!.validate());
                      },
                      child: PinPut(
                        validator: (s) {
                          return "";
                        },
                        useNativeKeyboard: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        withCursor: true,
                        fieldsCount: 6,
                        fieldsAlignment: MainAxisAlignment.spaceAround,
                        textStyle: const TextStyle(
                            fontSize: 25.0, color: Colors.black),
                        eachFieldMargin: const EdgeInsets.all(0),
                        eachFieldWidth: 45.0,
                        eachFieldHeight: 55.0,
                        onSubmit: (String pin) => checkOTP(pin),
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: pinPutDecoration,
                        selectedFieldDecoration: pinPutDecoration.copyWith(
                          color: Colors.white,
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(160, 215, 220, 1),
                          ),
                        ),
                        followingFieldDecoration: pinPutDecoration,
                        pinAnimationType: PinAnimationType.scale,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CountDownTimer(
                              goHomeScreen: widget.user["phone_number"] != null
                                  ? true
                                  : false,
                              online: widget.online,
                              onCountDownComplete: (v) {
                                // Navigator.of(context).pop();
                              },
                            ))),
                    Consumer<OTPCallback>(
                      builder: (context, otpDone, child) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) {
                          // print(otpDone);
                          if (otpDone.otpTimeComplete == true) {
                            Provider.of<OTPCallback>(context, listen: false)
                                .setOTPDone(false);

                            Navigator.of(context).maybePop();
                          }
                        });
                        return Container();
                      },
                    ),
                    // SizedBox( width: 100, height: 100,child: CountDownTimer())
                  ],
                ),
                // GestureDetector(
                //   onLongPress: () {
                //     print(_formKey.currentState!.validate());
                //   },
                //   child: PinPut(
                //     validator: (s) {
                //       return "";
                //     },
                //     useNativeKeyboard: true,
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     withCursor: true,
                //     fieldsCount: 6,
                //     fieldsAlignment: MainAxisAlignment.spaceAround,
                //     textStyle:
                //         const TextStyle(fontSize: 25.0, color: Colors.black),
                //     eachFieldMargin: EdgeInsets.all(0),
                //     eachFieldWidth: 45.0,
                //     eachFieldHeight: 55.0,
                //     onSubmit: (String pin) => checkOTP(pin),
                //     focusNode: _pinPutFocusNode,
                //     controller: _pinPutController,
                //     submittedFieldDecoration: pinPutDecoration,
                //     selectedFieldDecoration: pinPutDecoration.copyWith(
                //       color: Colors.white,
                //       border: Border.all(
                //         width: 2,
                //         color: const Color.fromRGBO(160, 215, 220, 1),
                //       ),
                //     ),
                //     followingFieldDecoration: pinPutDecoration,
                //     pinAnimationType: PinAnimationType.scale,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.user["phone_number"] != null) {
      setState(() {
        isOTPSent = true;
        _origPhoneNumber = widget.user["phone_number"]!;
        _phoneNumberController.text = widget.user["phone_number"]!;
        _phoneNumber = "+92" + _origPhoneNumber.replaceAll(reg, '');

        Future<void> v = sendOTP();
        v.then((value) => null);
      });
    }

    FirebaseAuth.instance.authStateChanges().listen((event) {
      print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Image.asset(
          //   'assets/images/full white-01.png',
          //   scale: 18,
          // ),
          Container(child: otpWidget())
        ]),
      ),
    ));
  }
}

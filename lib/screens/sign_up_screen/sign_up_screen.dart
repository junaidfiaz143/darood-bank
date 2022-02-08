import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/screens/login_screen/login_screen.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:durood_bank/components/text_field_component.dart';
import 'package:durood_bank/models/login_state_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _phonelogin = GlobalKey<FormState>();

  late String _phoneNumber = "";
  late String _password = "";

  final String countryCode = '+92';

  Future savePrefs(String contact, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("contact", contact);
    prefs.setString("password", password);
  }

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String name = "";
  @override
  void initState() {
    super.initState();

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        name = result.toString().split(".")[1];
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  updateLoadingState(bool loginState) {
    Provider.of<LoginStateModel>(context, listen: false).updateLoadingState =
        loginState;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<LoginStateModel>(builder: (_, model, child) {
        return SizedBox(
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Spacer(),
                  Text(
                    "درودبينك",
                    style: GoogleFonts.elMessiri(
                        color: const Color(MyColors.primaryColor),
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        letterSpacing: 2),
                  ),
                  SizedBox(
                    height: size.height * 0.10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: Form(
                      key: _phonelogin,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "SIGNUP",
                              style: TextStyle(
                                color: Color(MyColors.primaryColor),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          TextFormField(
                            enabled: !model.isLoading,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      1, 1, 1, 1), // add padding to adjust icon
                                  child: Icon(
                                    LineIcons.user,
                                  ),
                                ),
                                fillColor: Color(MyColors.grey),
                                filled: true,
                                hintText: 'Full Name*',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(MyColors.primaryColor)))),
                            onChanged: (value) {
                              // _phoneNumber = value;
                            },
                            validator: (value) {
                              // print(value);
                              if (value!.length == 11) {
                                return null;
                              }
                              return 'Please Enter Valid Phone Number';
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            enabled: !model.isLoading,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      1, 1, 1, 1), // add padding to adjust icon
                                  child: Icon(
                                    LineIcons.phone,
                                  ),
                                ),
                                fillColor: Color(MyColors.grey),
                                filled: true,
                                hintText: 'Phone Number*',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(MyColors.primaryColor)))),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              _phoneNumber = value;
                            },
                            validator: (value) {
                              // print(value);
                              if (value!.length == 11) {
                                return null;
                              }
                              return 'Please Enter Valid Phone Number';
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            enabled: !model.isLoading,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      1, 1, 1, 1), // add padding to adjust icon
                                  child: Icon(
                                    LineIcons.city,
                                  ),
                                ),
                                fillColor: Color(MyColors.grey),
                                filled: true,
                                hintText: 'City*',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(MyColors.primaryColor)))),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              _phoneNumber = value;
                            },
                            validator: (value) {
                              // print(value);
                              if (value!.length == 11) {
                                return null;
                              }
                              return 'Please Enter Valid Phone Number';
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            obscureText: true,
                            enabled: !model.isLoading,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      1, 1, 1, 1), // add padding to adjust icon
                                  child: Icon(
                                    LineIcons.lock,
                                  ),
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      1, 1, 1, 1), // add padding to adjust icon
                                  child: Icon(
                                    LineIcons.eye,
                                  ),
                                ),
                                fillColor: Color(MyColors.grey),
                                filled: true,
                                hintText: 'Password*',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(MyColors.primaryColor)))),
                            onChanged: (value) {
                              // _phoneNumber = value;
                            },
                            validator: (value) {
                              // print(value);
                              if (value!.length == 11) {
                                return null;
                              }
                              return 'Please Enter Valid Phone Number';
                            },
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            enabled: !model.isLoading,
                            textInputAction: TextInputAction.go,
                            decoration: const InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    1, 1, 1, 1), // add padding to adjust icon
                                child: Icon(LineIcons.lock),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    1, 1, 1, 1), // add padding to adjust icon
                                child: Icon(
                                  LineIcons.eyeSlash,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color(MyColors.primaryColor))),
                              fillColor: Color(MyColors.grey),
                              filled: true,
                              hintText: 'Confirm Password*',
                            ),
                            obscureText: true,
                            onChanged: (value) {
                              _password = value;
                              // print(_password);
                            },
                            validator: (value) {
                              // print(value);
                              if (value!.length == 8) {
                                return null;
                              }
                              return 'Password Length Should be Greater Than or Equal to 8';
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                        height: 45,
                        width: 200,
                        child: ButtonComponent(
                          function: () async {
                            debugPrint(_phoneNumber);
                            debugPrint(_password);
                            // ApiCall apiCall = ApiCall(url: Constants.urlLogin!);

                            // dynamic data = {
                            //   "password": _password,
                            //   "contact": _phoneNumber,
                            //   "longitude": "$globalLongitude",
                            //   "latitude": "$globalLatitude",
                            //   "fcm_id": "$fcmId"
                            // };

                            // print(data);

                            updateLoadingState(true);

                            // var response =
                            //     await apiCall.postDataWithoutHeader(data);
                            // if (response != null &&
                            //     response[Constants.keySuccess] == 1) {
                            //   token = response[Constants.keyToken];
                            //   riderId = response[Constants.keyRiderId];

                            //   // savePrefs(_phoneNumber, _password);

                            //   dynamic res = await Utilities.loadRiderProfile(
                            //       context, _phoneNumber, _password);

                            //   if (res == 1) {
                            //     updateLoadingState(false);
                            //   } else {
                            //     updateLoadingState(false);
                            //   }
                            // } else {
                            //   if (response != null) {
                            //     showDialog(
                            //         context: context,
                            //         builder: (BuildContext context) {
                            //           return Utilities.showAlertDialog(context,
                            //               message: response['message']);
                            //         });
                            //   }
                            //   updateLoadingState(false);
                            // }
                          },
                          title: 'SIGNUP',
                          icon: LineIcons.arrowCircleRight,
                          check: model.isLoading,
                        )),
                  ),
                  SizedBox(height: size.height * 0.05),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        IgnorePointer(
                          ignoring: false,
                          child: InkResponse(
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                ' LogIn',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: Color(MyColors.primaryColor)),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

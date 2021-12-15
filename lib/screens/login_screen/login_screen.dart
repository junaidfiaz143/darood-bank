import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:darood_bank/components/text_field_component.dart';
import 'package:darood_bank/models/login_state_model.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                  SizedBox(
                    height: size.height * 0.16,
                  ),
                  // Image.asset(
                  //   'assets/images/virtual lab1-01.png',
                  //   scale: 18,
                  // ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: Form(
                      key: _phonelogin,
                      child: Column(
                        children: [
                          TextFormField(
                            enabled: !model.isLoading,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      1, 1, 1, 1), // add padding to adjust icon
                                  child: Icon(LineIcons.phone),
                                ),
                                fillColor: Color(0xFFe9e9e9),
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
                                    borderSide:
                                        BorderSide(color: Color(0xFF2196f3)))),
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
                            textInputAction: TextInputAction.go,
                            decoration: const InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    1, 1, 1, 1), // add padding to adjust icon
                                child: Icon(LineIcons.lock),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Color(0xFF2196f3))),
                              fillColor: Color(0xFFe9e9e9),
                              filled: true,
                              hintText: 'Password*',
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
                          Align(
                              child: InkResponse(
                                onTap: () {
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         ResetPasswordScreen(online: false),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "forgot password?",
                                      style: TextStyle(
                                          color: Color(0xFFA1A5B3),
                                          fontSize: 12),
                                    )),
                              ),
                              alignment: Alignment.centerRight)
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
                          title: 'Login',
                          check: model.isLoading,
                        )),
                  ),
                  SizedBox(height: size.height * 0.05),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

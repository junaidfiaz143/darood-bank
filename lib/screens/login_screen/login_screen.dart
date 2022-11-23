import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/screens/home_screen/home_screen.dart';
import 'package:durood_bank/screens/sign_up_screen/sign_up_screen.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:durood_bank/components/text_field_component.dart';
import 'package:durood_bank/models/login_state_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../models/current_user_model.dart';
import '../../services/login_service.dart';
import '../../utils/globals.dart';
import '../../utils/utilities.dart';

class LoginScreen extends StatefulWidget {
  final String? phoneNumber;
  final String? password;
  const LoginScreen({Key? key, this.phoneNumber, this.password})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _phonelogin = GlobalKey<FormState>();

  late String _phoneNumber = "";
  late String _password = "";

  final String countryCode = '+92';

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String name = "";

  @override
  void initState() {
    super.initState();
    if (widget.phoneNumber != null && widget.password != null) {
      updateLoadingState(true);
      _phoneNumber = widget.phoneNumber!;
      _password = widget.password!;
      doLogin();
    }
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        name = result.toString().split(".")[1];
      });
    });
  }

  doLogin() async {
    updateLoadingState(true);

    final QuerySnapshot loginQuery = await FirebaseFirestore.instance
        .collection('users')
        .where("phone_number", isEqualTo: _phoneNumber)
        .where("password", isEqualTo: _password)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        doc.reference.update({"fcm_id": fcmId});
      }
      return value;
    });
    if (loginQuery.docs.isNotEmpty) {
      updateLoadingState(false);
      LoginService.saveUserData(loginQuery.docs.first.data());
      LoginService.loadUserData().then((value) {
        if (value != null) {
          Provider.of<CurrentUserModel>(context, listen: false).fullName =
              value[0];
          Provider.of<CurrentUserModel>(context, listen: false).userName =
              value[1];
          Provider.of<CurrentUserModel>(context, listen: false).isOfficial =
              value[2];
          Provider.of<CurrentUserModel>(context, listen: false).phoneNumber =
              value[3];
          Provider.of<CurrentUserModel>(context, listen: false).city = value[4];
          Provider.of<CurrentUserModel>(context, listen: false).password =
              value[5];
          Provider.of<CurrentUserModel>(context, listen: false).gender =
              value[6];
        }
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Utilities.showCustomDialogNew(
                context: context,
                icon: const Icon(
                  LineIcons.exclamation,
                  size: 64,
                  color: Colors.red,
                ),
                iconBaseColor: Colors.red.shade100,
                title: 'Wrong login credentials.',
                message: '');
          });
      updateLoadingState(false);
    }
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
    // timeDilation = 2;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Consumer<LoginStateModel>(builder: (_, model, child) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                            "LOGIN",
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
                                LineIcons.eye,
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
                                // Navigator.of(context).pushReplacement(
                                //   MaterialPageRoute(
                                //     builder: (context) => const HomeScreen(
                                //       isDialogOpen: false,
                                //     ),
                                //   ),
                                // );
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
                                        color: Color(MyColors.greyText),
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
                          doLogin();
                        },
                        title: 'LOGIN',
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
                        "Don't have an account? ",
                        style: TextStyle(
                            fontSize: 12, color: Colors.black.withOpacity(0.5)),
                      ),
                      IgnorePointer(
                        ignoring: false,
                        child: InkResponse(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              ' Sign up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w900,
                                  color: Color(MyColors.primaryColor)),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

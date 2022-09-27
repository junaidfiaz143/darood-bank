import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/screens/login_screen/login_screen.dart';
import 'package:durood_bank/screens/sign_up_screen/otp_verify_screen.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:durood_bank/components/text_field_component.dart';
import 'package:durood_bank/models/login_state_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _phonelogin = GlobalKey<FormState>();

  int _genderRadioValue = 1;

  late String _fullName = "";
  late String _phoneNumber = "";
  late String _gender = "Male";
  late String _password = "";
  late String _rePassword = "";

  final TextEditingController _cityController = TextEditingController();

  final String countryCode = '+92';

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

  void _handleRadioValueChange(value) {
    setState(
      () {
        _genderRadioValue = value;
        switch (_genderRadioValue) {
          case 0:
            _gender = 'Male';
            break;
          case 1:
            _gender = 'Female';
            break;
        }
      },
    );
  }

  generateUsername() async {
    updateLoadingState(true);
    String username = _fullName.toLowerCase().replaceAll(" ", "") +
        Random().nextInt(1000).toString();
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(u),
    // ));
    final QuerySnapshot usernameQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    final QuerySnapshot phoneNumberQuery = await FirebaseFirestore.instance
        .collection('users')
        .where("phone_number", isEqualTo: _phoneNumber)
        .get();

    if (usernameQuery.docs.isNotEmpty) {
      await generateUsername();
    } else {
      updateLoadingState(false);
    }

    if (phoneNumberQuery.docs.isEmpty) {
      debugPrint("now $username");

      updateLoadingState(false);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OTPVerifyScreen(
            user: {
              "full_name": _fullName,
              "username": username,
              "gender": _gender,
              "is_official": false,
              "phone_number": _phoneNumber,
              "city": _cityController.text,
              "password": _password,
              "created_at": FieldValue.serverTimestamp()
            },
            online: true,
          ),
        ),
      );
      // createUser(username);
    } else {
      debugPrint("already registered $username");
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
                title: 'Already found user with this phone number.',
                message: '');
          });
    }
  }

  // createUser(String username) {
  //   updateLoadingState(true);

  //   dynamic user = {
  //     "full_name": _fullName,
  //     "username": username,
  //     "is_official": false,
  //     "phone_number": _phoneNumber,
  //     "city": _cityController.text,
  //     "password": _password,
  //     "created_at": FieldValue.serverTimestamp()
  //   };

  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc()
  //       .set(user)
  //       .whenComplete(() {
  //     updateLoadingState(false);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 2;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Consumer<LoginStateModel>(builder: (_, model, child) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 70.0, bottom: 0),
            child: IntrinsicHeight(
              // width: double.infinity,
              // height: size.height,
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
                              _fullName = value;
                            },
                            validator: (value) {
                              // print(value);
                              if (value!.length == 11) {
                                return null;
                              }
                              return 'Please Enter Valid Full Name';
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Male",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Radio(
                                  value: 1,
                                  groupValue: _genderRadioValue,
                                  onChanged: _handleRadioValueChange),
                              Text(
                                "Female",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Radio(
                                  value: 0,
                                  groupValue: _genderRadioValue,
                                  onChanged: _handleRadioValueChange),
                            ],
                          ),

                          SizedBox(height: size.height * 0.01),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Utilities.cityDialog(context);
                                  }).then((value) {
                                if (value != null) {
                                  _cityController.text = value;
                                }
                              });
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextFormField(
                                controller: _cityController,
                                readOnly: true,
                                enabled: false,
                                textInputAction: TextInputAction.go,
                                decoration: const InputDecoration(
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.fromLTRB(1, 1, 1,
                                          1), // add padding to adjust icon
                                      child: Icon(
                                        LineIcons.city,
                                      ),
                                    ),
                                    fillColor: Color(0xFFe9e9e9),
                                    filled: true,
                                    hintText: 'City*',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color:
                                                Color(MyColors.primaryColor)))),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          // TextFormField(
                          //   enabled: !model.isLoading,
                          //   textInputAction: TextInputAction.next,
                          //   decoration: const InputDecoration(
                          //       prefixIcon: Padding(
                          //         padding: EdgeInsets.fromLTRB(
                          //             1, 1, 1, 1), // add padding to adjust icon
                          //         child: Icon(
                          //           LineIcons.city,
                          //         ),
                          //       ),
                          //       fillColor: Color(MyColors.grey),
                          //       filled: true,
                          //       hintText: 'City*',
                          //       border: OutlineInputBorder(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(10)),
                          //         borderSide: BorderSide.none,
                          //       ),
                          //       focusedBorder: OutlineInputBorder(
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(10)),
                          //           borderSide: BorderSide(
                          //               color: Color(MyColors.primaryColor)))),
                          //   onChanged: (value) {
                          //     _city = value;
                          //   },
                          //   validator: (value) {
                          //     // print(value);
                          //     if (value!.length == 11) {
                          //       return null;
                          //     }
                          //     return 'Please Enter Valid Phone Number';
                          //   },
                          // ),
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
                              _password = value;
                            },
                            validator: (value) {
                              // print(value);
                              if (value!.length == 11) {
                                return null;
                              }
                              return 'Please Enter Valid Password';
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
                              _rePassword = value;
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

                            if (_fullName != "" &&
                                _phoneNumber != "" &&
                                _cityController.text != "" &&
                                _password != "" &&
                                _rePassword != "") {
                              if (_password == _rePassword) {
                                await generateUsername();
                              } else {
                                debugPrint("Password not matched");
                              }
                            } else {
                              debugPrint("empty fields");
                            }
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
                                ' Log in',
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

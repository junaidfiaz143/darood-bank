import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/models/current_user_model.dart';
import 'package:durood_bank/screens/login_screen/login_screen.dart';
import 'package:durood_bank/services/login_service.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  DrawerScreenState createState() => DrawerScreenState();
}

class DrawerScreenState extends State<DrawerScreen> {
  SharedPreferences? prefs;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool? isInternetOn;

  Widget listTileItem(IconData icon, String text, Function() fun,
      {String? count}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        leading: Icon(
          icon,
          color: text == "Logout"
              ? Colors.red
              : const Color(MyColors.primaryColor),
        ),
        title: count == null
            ? Text(
                text,
                style: TextStyle(
                    fontSize: 15,
                    color: text == "Logout" ? Colors.red : Colors.black38),
              )
            : Row(
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 15,
                        color: text == "Logout" ? Colors.red : Colors.black38),
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        count,
                        style: const TextStyle(color: Colors.white),
                      )))
                ],
              ),
      ),
      onTap: fun,
    );
  }

  File? profileImage;
  void getImage() async {
    // PickedFile pickedfile = await ImagePicker().getImage(source: ImageSource.camera);
    //rofileImage = File(pickedfile.path);
  }

  getNoInternetUsername() async {
    prefs = await SharedPreferences.getInstance();
  }

  checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      isInternetOn = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      isInternetOn = true;
    } else {
      isInternetOn = false;
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    getNoInternetUsername().whenComplete(() {
      setState(() {});
    });

    checkInternetConnection();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result.toString().split(".")[1] == "wifi" ||
          result.toString().split(".")[1] == "mobile") {
        isInternetOn = true;
      } else {
        isInternetOn = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: media.height * 0.2,
              width: media.width,
              padding: const EdgeInsets.all(15.0),
              // color: const Color(MyColors.primaryColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    child: CircleAvatar(
                      child: profileImage == null
                          ? Container(
                              width: media.width * 0.15,
                              height: media.height * 0.20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(MyColors.primaryColor),
                              ),
                              child: const Icon(
                                LineIcons.user,
                                color: Colors.white,
                              ))
                          : Image.file(profileImage!),
                    ),
                    onTap: () => getImage(),
                  ),
                  SizedBox(width: media.width * 0.04),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${Provider.of<CurrentUserModel>(context, listen: false).fullName}",
                            style: const TextStyle(
                                color: Color(MyColors.primaryColor),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Visibility(
                            visible: Provider.of<CurrentUserModel>(context,
                                            listen: false)
                                        .isOfficial ==
                                    "true"
                                ? true
                                : false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Image.asset(
                                  'assets/images/official_check_icon.png',
                                  scale: 3),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "@${Provider.of<CurrentUserModel>(context, listen: false).userName}",
                        style: const TextStyle(
                            color: Color(MyColors.primaryColor), fontSize: 12),
                      ),
                      // Text(
                      //   Provider.of<ProfileModel>(context, listen: false)
                      //               .firstname ==
                      //           null
                      //       ? "ID: ${this.prefs?.getString("user_id") ?? ""}"
                      //       : "ID: ${Provider.of<ProfileModel>(context, listen: false).uniqueId!}",
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 12,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                children: [
                  listTileItem(LineIcons.user, 'Profile', () async {
                    if (isInternetOn != true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'Please ensure your device is connected to the internet and try again.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                    } else {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const LoginScreen()));
                    }
                  }),
                  const Divider(
                      // color: Color(0xff0674BD),
                      ),

                  // Consumer<ResampleBookingCountModel>(
                  //     builder: (context, counter, child) {
                  //   return listTileItem(
                  //     LineIcons.vials,
                  //     'Resample requests ',
                  //     () {
                  //       if (isInternetOn != true) {
                  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //           backgroundColor: Colors.red,
                  //           content: const Text(
                  //             'Please ensure your device is connected to the internet and try again.',
                  //             style: TextStyle(color: Colors.white),
                  //           ),
                  //         ));
                  //       } else
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     ResmapleBookingScreen()));
                  //     },
                  //     count: "${counter.count}",
                  //   );
                  // }),
                  listTileItem(LineIcons.info, 'About Us', () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoginScreen()));
                  }),
                  listTileItem(LineIcons.clipboardList, 'Terms & Conditions',
                      () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoginScreen()));
                  }),
                  listTileItem(LineIcons.alternateShield, 'Privacy Policy', () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoginScreen()));
                  }),
                  listTileItem(LineIcons.question, 'Contact Us', () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoginScreen()));
                  }),
                  listTileItem(LineIcons.cog, 'Settings', () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LoginScreen()));
                  }),
                  const Divider(),
                  listTileItem(LineIcons.alternateSignOut, 'Logout', () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          Future.delayed(const Duration(seconds: 2), () async {
                            deleteSharedPreference();
                            await FirebaseMessaging.instance
                                .unsubscribeFromTopic('all');

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()),
                                (route) => false);
                          });
                          return AlertDialog(
                            title: const Text('Alert'),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                CircularProgressIndicator(),
                                Text(
                                  "Logging Out",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        });
                  }),
                  Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: const Text(
                        "version: v1.0",
                        style: TextStyle(
                            color: Color(MyColors.greyText), fontSize: 12),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

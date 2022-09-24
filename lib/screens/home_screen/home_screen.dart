import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/components/contribution_item.dart';
import 'package:durood_bank/components/text_field_component.dart';
import 'package:durood_bank/models/slider_model.dart';
import 'package:durood_bank/models/total_durood_model.dart';
import 'package:durood_bank/screens/counter_screen/counter_screen.dart';
import 'package:durood_bank/screens/drawer_screen/drawer_screen.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/globals.dart';
import 'package:durood_bank/utils/text_utils.dart';
import 'package:durood_bank/utils/tts_utils.dart';
import 'package:durood_bank/utils/utilities.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  final bool? isDialogOpen;
  const HomeScreen({Key? key, this.isDialogOpen}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool? isInternetOn = false;

  bool? isDialogOpen;

  bool? isDuroodLockServiceON;

  int totalDurood = 0;

  List<Widget>? pages = [];

  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  // Timer? pageTimer;

  SharedPreferences? prefs;

  List<int> colors = [
    0xFFE0F7FF,
    0xFFBFEFC5,
    0xFFD9E4F8,
    0xFFFEF8D4,
    0xFFFFE9D4,
    0xFFE8F8ED
  ];

  List<Color> iconColors = [
    Colors.blue.shade800,
    Colors.green.shade800,
    Colors.indigo.shade800,
    Colors.yellow.shade800,
    Colors.orange.shade800,
    Colors.teal.shade800
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // startSlider() {
  //   pageTimer = Timer.periodic(const Duration(seconds: 3), (pageTimer) {
  //     if (_currentPage < 2) {
  //       _currentPage++;
  //       Provider.of<SliderModel>(context, listen: false)
  //           .updatePosition(_currentPage);
  //     } else {
  //       _currentPage = 0;
  //       Provider.of<SliderModel>(context, listen: false)
  //           .updatePosition(_currentPage);
  //     }

  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: const Duration(milliseconds: 1000),
  //       curve: Curves.easeIn,
  //     );
  //   });
  // }

  getNoInternetUsername() async {
    prefs = await SharedPreferences.getInstance();
  }

  initAllPushNotifications() async {
    await FirebaseMessaging.instance.subscribeToTopic('all');
  }

  @override
  void initState() {
    super.initState();

    initAllPushNotifications();
    getDuroodPref();

    TTSUtils.welcome(context: context);

    // getNoInternetUsername().whenComplete(() {
    //   setState(() {});
    // });

    isDialogOpen = widget.isDialogOpen ?? false;

    isInternetOn = !isDialogOpen!;

    if (widget.isDialogOpen != null && widget.isDialogOpen == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showDialog(
            context: context,
            builder: (BuildContext _context) {
              return Utilities.showCustomDialogNew(
                context: context,
                title: "Info",
                message:
                    "Please ensure your device is connected to the internet and try again.",
                icon: Icon(
                  LineIcons.exclamationTriangle,
                  size: 64,
                  color: Colors.orange.shade800,
                ),
                iconBaseColor: const Color(0xFFFFE9D4),
              );
            }).then((value) => isDialogOpen = false);
      });
    }

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result.toString().split(".")[1] == "wifi" ||
          result.toString().split(".")[1] == "mobile") {
        isInternetOn = true;

        if (isDialogOpen == true) {
          Navigator.pop(context);
        }
        isDialogOpen = false;
      } else {
        isInternetOn = false;
        if (isDialogOpen == false) {
          showDialog(
              context: context,
              builder: (BuildContext _context) {
                return Utilities.showCustomDialogNew(
                  context: context,
                  title: "Info",
                  message:
                      "Please ensure your device is connected to the internet and try again.",
                  icon: Icon(
                    LineIcons.exclamationTriangle,
                    size: 64,
                    color: Colors.orange.shade800,
                  ),
                  iconBaseColor: const Color(0xFFFFE9D4),
                );
              }).then((value) => isDialogOpen = false);
        }
        isDialogOpen = true;
      }
    });

    // startSlider();
  }

  @override
  dispose() {
    _connectivitySubscription.cancel();
    // pageTimer!.cancel();
    super.dispose();
  }

  getDuroodPref() async {
    await Utilities.getPrefrences("DUROOD_PREFERENCE").then((value) {
      if (value != null) {
        isDuroodLockServiceON = value;
      }
    });
  }

  initSlider(BuildContext context) {
    pages!.add(SizedBox.expand(
        child: Container(
            margin: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("ٱلْحَمْدُ لِلّٰهِ",
                    style: GoogleFonts.elMessiri(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(MyColors.primaryColor))),
                Consumer<TotalDurooodModel>(
                  builder: (context, durood, child) {
                    return Text(
                      '${durood.countTotalDurood}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: const TextUtils()
                              .getadaptiveTextSize(context, 50),
                          fontWeight: FontWeight.bold),
                    );
                  },
                ),
                Text("اللَّهُمَّ صل عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ",
                    style: GoogleFonts.elMessiri(
                        // fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(MyColors.primaryColor))),
              ],
            )))));

    pages!.add(SizedBox.expand(
        child: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: MediaQuery.of(context).size.width,
            child: Center(child: Image.asset("assets/images/p2.png")))));

    pages!.add(SizedBox.expand(
        child: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            width: MediaQuery.of(context).size.width,
            child: Center(child: Image.asset("assets/images/p3.png")))));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        Provider.of<SliderModel>(context, listen: false).updatePosition(0);
        _currentPage = 0;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  // bool isDialogOpen = false;

  // void checkUpdateOld() async {
  //   final DatabaseReference databaseRef =
  //       FirebaseDatabase.instance.reference().child('messages');

  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   databaseRef.onValue.listen((Event event) {
  //     if (packageInfo.buildNumber.toString() !=
  //         event.snapshot.value["buildVersion"]) {
  //       isDialogOpen = true;
  //       showDialog(
  //         barrierDismissible: false,
  //         context: context,
  //         builder: (BuildContext context) {
  //           return WillPopScope(
  //             onWillPop: () => Future.value(false),
  //             child: AlertDialog(
  //               title: new Text("Update Alert"),
  //               content: new SingleChildScrollView(
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                         "Kindly update to the latest version available on play store.")
  //                   ],
  //                 ),
  //               ),
  //               actions: <Widget>[
  //                 new TextButton(
  //                   child: new Text("Update"),
  //                   onPressed: () async {
  //                     String url =
  //                         "https://play.google.com/store/apps/details?id=com.virtuallab.phlebotomist";
  //                     if (await canLaunch(url)) {
  //                       await launch(url, forceWebView: false);
  //                     } else {
  //                       throw 'Could not launch $url';
  //                     }
  //                   },
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     } else {
  //       if (isDialogOpen == true) {
  //         Navigator.pop(context);
  //       }
  //     }
  //   }, onError: (Object o) {});
  // }

  @override
  Widget build(BuildContext context) {
    // timeDilation = 0;

    initSlider(context);

    return Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerScreen(),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkResponse(
                          onTap: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: const Color(MyColors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                LineIcons.bars,
                                color: Color(MyColors.primaryColor),
                              )),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "درودبينك",
                              style: GoogleFonts.elMessiri(
                                  color: const Color(MyColors.primaryColor),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                  letterSpacing: 2),
                            ),
                            // const Text("Junaid Fiaz"),
                          ],
                        ),
                        InkResponse(
                          onTap: () {
                            // pageTimer!.cancel();
                            if (isInternetOn != true) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext _context) {
                                    return Utilities.showCustomDialogNew(
                                      context: context,
                                      title: "Info",
                                      message:
                                          "Please ensure your device is connected to the internet and try again.",
                                      icon: Icon(
                                        LineIcons.exclamationTriangle,
                                        size: 64,
                                        color: Colors.orange.shade800,
                                      ),
                                      iconBaseColor: const Color(0xFFFFE9D4),
                                    );
                                  }).then((value) => isDialogOpen = false);
                              isDialogOpen = true;
                            } else {
                              // Navigator.of(context)
                              //     .push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const CounterScreen(),
                              //   ),
                              // )
                              //     .then((value) {
                              //   // if (pageTimer!.isActive == false) {
                              //   //   startSlider();
                              //   // }
                              // });
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: const Color(MyColors.grey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Icon(
                                LineIcons.bellAlt,
                                color: Color(MyColors.primaryColor),
                              )),
                        )
                      ]),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      color:
                          const Color(MyColors.primaryColor).withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: PageView.builder(
                        controller: _pageController,
                        itemBuilder: (_, int index) => pages![index % 3],
                      )),
                ),
                // Consumer<SliderModel>(builder: (context, sliderModel, child) {
                //   return Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Container(
                //         decoration: BoxDecoration(
                //           color: sliderModel.currentPage == 0
                //               ? const Color(MyColors.primaryColor)
                //                   .withOpacity(0.5)
                //               : const Color(MyColors.grey),
                //           borderRadius:
                //               const BorderRadius.all(Radius.circular(20)),
                //         ),
                //         margin: const EdgeInsets.symmetric(horizontal: 2),
                //         width: 5,
                //         height: 5,
                //       ),
                //       Container(
                //         margin: const EdgeInsets.symmetric(horizontal: 2),
                //         width: 5,
                //         height: 5,
                //         decoration: BoxDecoration(
                //           color: sliderModel.currentPage == 1
                //               ? const Color(MyColors.primaryColor)
                //               : const Color(MyColors.grey),
                //           borderRadius:
                //               const BorderRadius.all(Radius.circular(20)),
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.symmetric(horizontal: 2),
                //         width: 5,
                //         height: 5,
                //         decoration: BoxDecoration(
                //           color: sliderModel.currentPage == 2
                //               ? const Color(MyColors.primaryColor)
                //                   .withOpacity(0.5)
                //               : const Color(MyColors.grey),
                //           borderRadius:
                //               const BorderRadius.all(Radius.circular(20)),
                //         ),
                //       )
                //     ],
                //   );
                // }),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 20, right: 20),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color(MyColors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            "DUROOD Lock Service",
                            style: TextStyle(
                                color: Color(MyColors.primaryColor),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              // DuroodUtils.updateCurrentContributionId(
                              //     context: context);
                              // DuroodUtils.updateTotalDurood();
                            },
                            child: const Text("Reset try")),
                        const Spacer(),
                        FutureBuilder<bool?>(
                            future:
                                Utilities.getPrefrences("DUROOD_PREFERENCE"),
                            initialData: false,
                            builder: (context, AsyncSnapshot<bool?> snapshot) {
                              return Switch(
                                value: snapshot.data!,
                                onChanged: (value) async {
                                  value == true
                                      ? Utilities.duroodLockService(
                                          serviceAction: Constants.keyStart)
                                      : Utilities.duroodLockService(
                                          serviceAction: Constants.keyStop);

                                  Utilities.setPrefrences(
                                      "DUROOD_PREFERENCE", value);
                                  setState(() {
                                    isDuroodLockServiceON = value;
                                  });
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 40,
                        child: ButtonComponent(
                          icon: LineIcons.arrowCircleRight,
                          title: "Contribute",
                          check: false,
                          function: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => const CounterScreen(),
                              ),
                            )
                                .then((value) {
                              if (value != null) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Utilities.showCustomDialogNew(
                                          context: context,
                                          icon: const Icon(
                                            LineIcons.doubleCheck,
                                            size: 64,
                                          ),
                                          iconBaseColor: Colors.green.shade100,
                                          title:
                                              'You have contributed to the bank',
                                          message: 'شکریہ');
                                    });
                              }
                            });
                          },
                        ),
                      ),
                      Text("دیئے گئے بٹن کو دبائیں",
                          style: GoogleFonts.elMessiri(
                              fontWeight: FontWeight.bold,
                              color: const Color(MyColors.primaryColor))),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 35.0, top: 15),
                  child: Text(
                    "Contributions",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black38),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('durood')
                      .where("contribution_id", isEqualTo: contributionId)
                      // .orderBy('time_stamp', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((document) {
                              return getContributionItem(context, document);
                            }).toList()),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

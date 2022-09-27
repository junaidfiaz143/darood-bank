import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/components/contribution_item.dart';
import 'package:durood_bank/components/text_field_component.dart';
import 'package:durood_bank/models/slider_model.dart';
import 'package:durood_bank/models/total_durood_model.dart';
import 'package:durood_bank/screens/drawer_screen/drawer_screen.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/durood_utils.dart';
import 'package:durood_bank/utils/globals.dart';
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

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static AnimationController? controller;
  Animation<Offset>? offset;

  bool? dockVisible = false;

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

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, 1.0))
        .animate(controller!);

    controller!.forward().whenComplete(() {
      setState(() {
        dockVisible = true;
      });
    });

    initAllPushNotifications();
    getDuroodPref();

    // TTSUtils.welcome(context: context);

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
    _connectivitySubscription!.cancel();
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
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${durood.countTotalDurood}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
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

  @override
  Widget build(BuildContext context) {
    // timeDilation = 0;

    Future.delayed(const Duration(seconds: 1), () {
      controller!.reverse();
    });

    initSlider(context);

    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerScreen(
          scaffoldKey: _scaffoldKey,
          function: (String screenRoute) {
            controller!.forward().whenComplete(() {
              Navigator.pushNamed(context, screenRoute).then((value) {
                HomeScreenState.controller!.reverse();
              });
            });
          },
        ),
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
                                  color: const Color(MyColors.primaryColor)
                                      .withOpacity(0.1),
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
                            controller!.reverse();
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
                            } else {}
                          },
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: const Color(MyColors.primaryColor)
                                      .withOpacity(0.1),
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
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: PageView.builder(
                        controller: _pageController,
                        itemBuilder: (_, int index) => pages![index % 3],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color:
                            const Color(MyColors.primaryColor).withOpacity(0.1),
                        // borderRadius: const BorderRadius.all(Radius.circular(15)),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            "DUROOD Lock Service",
                            style: TextStyle(
                                color: Color(MyColors.primaryColor),
                                fontWeight: FontWeight.w500,
                                fontFamily: "NeoSans",
                                fontSize: 15),
                          ),
                        ),
                        const Spacer(),
                        FutureBuilder<bool?>(
                            future:
                                Utilities.getPrefrences("DUROOD_PREFERENCE"),
                            initialData: false,
                            builder: (context, AsyncSnapshot<bool?> snapshot) {
                              return Switch(
                                inactiveTrackColor:
                                    const Color(MyColors.primaryColor)
                                        .withOpacity(0.3),
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
                        // width: MediaQuery.of(context).size.width / 3,
                        height: 40,
                        child: ButtonComponent(
                          icon: LineIcons.arrowCircleRight,
                          title: "Contribute",
                          check: false,
                          function: () {
                            controller!.forward().whenComplete(() {
                              Navigator.pushNamed(
                                context,
                                "/counterScreen",
                              ).then((value) {
                                controller!.reverse();
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
                                            iconBaseColor:
                                                Colors.green.shade100,
                                            title:
                                                'You have contributed to the bank',
                                            message: 'شکریہ');
                                      });
                                  DuroodUtils.updateTotalDurood(
                                      context: context);
                                }
                              });
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
                      .orderBy('time_stamp', descending: true)
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
                    // return Container();
                    // print(snapshot.data!.docs);
                    return Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0.0),
                            child: ListView(
                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((document) {
                                  try {
                                    return getContributionItem(
                                        context, document);
                                  } catch (e) {
                                    return Container();
                                  }
                                }).toList()),
                          ),
                          Visibility(
                            visible: dockVisible!,
                            child: Positioned.fill(
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SlideTransition(
                                    position: offset!,
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: const Color(MyColors.grey)
                                                  .withOpacity(0.2))),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 20, sigmaY: 20),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.7)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    // color: Colors.red,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: const Icon(
                                                      LineIcons.filter,
                                                      color: Color(MyColors
                                                          .primaryColor),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    debugPrint("filter");
                                                  },
                                                ),
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    // color: Colors.red,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: const Icon(
                                                      LineIcons.barChart,
                                                      color: Color(MyColors
                                                          .primaryColor),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    debugPrint("stats");
                                                  },
                                                ),
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    // color: Colors.red,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: const Icon(
                                                      LineIcons.users,
                                                      color: Color(MyColors
                                                          .primaryColor),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    debugPrint("community");
                                                  },
                                                ),
                                                InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    // color: Colors.red,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: const Icon(
                                                      LineIcons.bars,
                                                      color: Color(MyColors
                                                          .primaryColor),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    _scaffoldKey.currentState!
                                                        .openDrawer();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
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

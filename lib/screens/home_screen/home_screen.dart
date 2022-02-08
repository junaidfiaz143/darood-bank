import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:durood_bank/models/slider_model.dart';
import 'package:durood_bank/screens/counter_screen/counter_screen.dart';
import 'package:durood_bank/screens/drawer_screen/drawer_screen.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/globals.dart';
import 'package:durood_bank/utils/utilities.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // List<String> gridItemsTitle = [
  //   "New Bookings",
  //   "Accepted Bookings",
  //   "History Bookings",
  //   "Patient Bookings",
  //   "Add Patient",
  //   "Book Test for Patient",
  // ];

  // List<IconData> iconList = [
  //   LineIcons.list,
  //   LineIcons.alternateListAlt,
  //   LineIcons.history,
  //   LineIcons.edit,
  //   LineIcons.userPlus,
  //   LineIcons.vials
  // ];

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

  initFirebaseNotifications() async {
    await FirebaseMessaging.instance.subscribeToTopic('all');
  }

  @override
  void initState() {
    super.initState();

    getNoInternetUsername().whenComplete(() {
      setState(() {});
    });

    isDialogOpen = widget.isDialogOpen ?? false;

    isInternetOn = !isDialogOpen!;

    if (widget.isDialogOpen != null && widget.isDialogOpen == true) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
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
                  buttons: ["", ""]);
            }).then((value) => isDialogOpen = false);
      });
    }

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result.toString().split(".")[1] == "wifi" ||
          result.toString().split(".")[1] == "mobile") {
        initFirebaseNotifications();
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
                    buttons: ["", ""]);
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

  initSlider(BuildContext context) {
    pages!.add(SizedBox.expand(
        child: Container(
            margin: const EdgeInsets.all(10),
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
                const Text(
                  "12900",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                      fontWeight: FontWeight.bold),
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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
    timeDilation = 2;

    globalContext = context;
    initSlider(context);

    return Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerScreen(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
                                          buttons: ["", ""]);
                                    }).then((value) => isDialogOpen = false);
                                isDialogOpen = true;
                              } else {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => const CounterScreen(),
                                  ),
                                )
                                    .then((value) {
                                  // if (pageTimer!.isActive == false) {
                                  //   startSlider();
                                  // }
                                });
                              }
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: const Color(MyColors.grey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  LineIcons.user,
                                  color: Color(MyColors.primaryColor),
                                )),
                          )
                        ]),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
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
                  Consumer<SliderModel>(builder: (context, sliderModel, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: sliderModel.currentPage == 0
                                ? const Color(MyColors.primaryColor)
                                    .withOpacity(0.5)
                                : const Color(MyColors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 5,
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: sliderModel.currentPage == 1
                                ? const Color(MyColors.primaryColor)
                                : const Color(MyColors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: sliderModel.currentPage == 2
                                ? const Color(MyColors.primaryColor)
                                    .withOpacity(0.5)
                                : const Color(MyColors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                        )
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'globals.dart';

class Utilities {
  static SharedPreferences? prefs;

  static const platform =
      MethodChannel("com.junaid.durood_bank/NATIVE_SERVICE");

  static Future<void> duroodLockService({required String serviceAction}) async {
    try {
      await platform.invokeMethod("DUROOD_LOCK_SERVICE", {
        "service_action": serviceAction,
      });
    } on Exception catch (e) {
      debugPrint("$e");
    }
  }

  static Future<void> notificationService(
      {required String title, required String body}) async {
    try {
      await platform
          .invokeMethod("NOTIFICATION_SERVICE", {"title": title, "body": body});
    } on Exception catch (e) {
      debugPrint("$e");
    }
  }

  static String _dateMakerHelper(String year, String dash, String monthZero,
      String month, String dash2, String dayZero, String day) {
    return year + dash + monthZero + month + dash2 + dayZero + day;
  }

  static setFirstTimePrefrences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getBool("DUROOD_PREFERENCE") == null) {
      prefs!.setBool("DUROOD_PREFERENCE", false);
      Utilities.duroodLockService(serviceAction: Constants.keyStop);
    }
  }

  static Future<bool?> getPrefrences(String preferenceVal) async {
    prefs = await SharedPreferences.getInstance();
    return prefs!.getBool(preferenceVal);
  }

  static Future setPrefrences(String preferenceKey, bool preferenceVal) async {
    prefs = await SharedPreferences.getInstance();
    prefs!.setBool(preferenceKey, preferenceVal);
  }

  static showSnackBar({required String txt, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      // margin: const EdgeInsets.only(bottom: 220, left: 20, right: 20),
      content: Text(
        txt,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }

  static void showInfoDialog(BuildContext context, String info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Details"),
          content: Text(
            info,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          // actions: <Widget>[
          //   new TextButton(
          //     child: new Text("OK"),
          //     onPressed: () {
          //       Navigator.of(context).pop();
          //     },
          //   ),
          // ],
        );
      },
    );
  }

  static String dateMaker(DateTime _date) {
    if (_date.day < 10 && _date.month < 10) {
      return _dateMakerHelper(_date.year.toString(), '-', '0',
          _date.month.toString(), '-', '0', _date.day.toString());
    } else if (_date.day < 10) {
      return _dateMakerHelper(_date.year.toString(), '-', '',
          _date.month.toString(), '-', '0', _date.day.toString());
    } else if (_date.month < 10) {
      return _dateMakerHelper(_date.year.toString(), '-', '0',
          _date.month.toString(), '-', '', _date.day.toString());
    }
    return _dateMakerHelper(_date.year.toString(), '-', '',
        _date.month.toString(), '-', '', _date.day.toString());
  }

  static Future<DateTime> selectDate(
      BuildContext context, DateTime _date) async {
    DateTime? _datePicker = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1776),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(primarySwatch: Colors.blue),
            child: child!,
          );
        });
    if (_datePicker != null) {
      _date = _datePicker;
      return _date;
    } else {
      return _date;
    }
  }

  static Widget showCustomDialogNew({
    required BuildContext? context,
    required Icon? icon,
    required String? title,
    required String? message,
    required Color? iconBaseColor,
  }) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: 1000,
              padding: const EdgeInsets.only(
                top: 66 + 16,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              margin: const EdgeInsets.only(top: 66),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  Text(
                    "$title",
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    "$message",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.elMessiri(
                        fontSize: 16.0, color: Colors.black38),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              child: CircleAvatar(
                backgroundColor: iconBaseColor ?? Colors.blueAccent,
                radius: 66,
                child: icon,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget showCustomDialog(
      {BuildContext? context,
      Icon? icon,
      String? title,
      String? message,
      List<String>? buttons,
      String? bookingNo}) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 66 + 16,
              bottom: 16,
              left: 16,
              right: 16,
            ),
            margin: const EdgeInsets.only(top: 66),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  "$title",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "$message",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context!).pop(); // To close the dialog
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: Text(buttons![0]),
                          onPressed: () async {},
                        ),
                        TextButton(
                          child: Text(buttons[1]),
                          onPressed: () {
                            Navigator.of(context!).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 66,
              child: icon,
            ),
          ),
        ],
      ),
    );
  }

  static Widget showLoadingDialog({required BuildContext? context}) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  static Widget showAlertDialog(BuildContext context,
      {String title = "Error",
      String message = "Message",
      bool okCancelButton = false,
      List<String>? buttons,
      List<MaterialColor>? colors}) {
    Widget okButton = TextButton(
      child: Text(
        buttons != null ? buttons[0] : "OK",
        style: TextStyle(color: colors != null ? colors[0] : Colors.red),
      ),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );

    Widget cancelButton = TextButton(
      child: Text(
        buttons != null ? buttons[1] : "CANCEL",
        style: TextStyle(color: colors != null ? colors[1] : Colors.blue),
      ),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );

    List<Widget>? actions = [];

    actions.add(okButton);

    okCancelButton ? actions.add(cancelButton) : debugPrint("");

    AlertDialog alert = AlertDialog(
      title: Text(
        title,
      ),
      content: Text(
        message,
      ),
      actions: actions,
    );
    return alert;
  }

  static StatefulWidget cityDialog(BuildContext _context) {
    List _cities = cities;

    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        )),
        child: Container(
          height: MediaQuery.of(_context).size.height / 2,
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              onChanged: (val) {
                List filterCities = cities
                    .where((x) => x.toLowerCase().contains(val.toLowerCase()))
                    .toList();

                setState(() {
                  _cities = filterCities;
                });
              },
              decoration: const InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
                    child: Icon(Icons.search),
                  ),
                  fillColor: Color(0xFFe9e9e9),
                  filled: true,
                  hintText: 'Search city',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF2196f3)))),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _cities.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(_context, _cities[index]);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("${_cities[index]}"))),
                    );
                  }),
            )
          ]),
        ),
      );
    });
  }
}

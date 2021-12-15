import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'globals.dart';

class Utilities {
  static String _dateMakerHelper(String year, String dash, String monthZero,
      String month, String dash2, String dayZero, String day) {
    return year + dash + monthZero + month + dash2 + dayZero + day;
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
    BuildContext? context,
    Icon? icon,
    String? title,
    String? message,
    List<String>? buttons,
    Color? iconBaseColor,
  }) {
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
                SizedBox(
                    height: buttons![0] == "" && buttons[1] == "" ? 0 : 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context!).pop(); // To close the dialog
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Visibility(
                          visible: buttons[0] == "" ? false : true,
                          child: TextButton(
                            child: Text(buttons[0]),
                            onPressed: () async {
                              Navigator.pop(context!);
                            },
                          ),
                        ),
                        Visibility(
                          visible: buttons[1] == "" ? false : true,
                          child: TextButton(
                            child: Text(buttons[1]),
                            onPressed: () {
                              Navigator.pop(context!);
                            },
                          ),
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
              backgroundColor: iconBaseColor ?? Colors.blueAccent,
              radius: 66,
              child: icon,
            ),
          ),
        ],
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

  static Widget showPatientDialog({
    required BuildContext? context,
    required String bookingNo,
    required String firstname,
    required String lastname,
    required String age,
    required String address,
    required String contact,
  }) {
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
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          LineIcons.vial,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Case No.",
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              bookingNo,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          LineIcons.user,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "$firstname $lastname",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          LineIcons.calendarCheck,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "$age years old",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          LineIcons.mapMarker,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(address,
                              // overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      await launch("tel:$contact");
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            LineIcons.phone,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(contact,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 66,
              child: Icon(LineIcons.user, size: 64),
            ),
          ),
        ],
      ),
    );
  }

  static Widget showTestsDialog(
      {required BuildContext? context,
      required String bookingNo,
      required List<Widget> expansionList}) {
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
            child: SizedBox(
              // margin: EdgeInsets.all(16),
              width: MediaQuery.of(context!).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(" Case No."),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(bookingNo,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: expansionList,
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 66,
              child: Icon(LineIcons.vials, size: 64),
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
          Radius.circular(10.0),
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
                  hintText: 'City',
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

  static StatefulWidget laboratoryDialog(BuildContext _context) {
    List<String> _laboratories = laboratories;

    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        )),
        child: Container(
          height: MediaQuery.of(_context).size.height / 2,
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              onChanged: (val) {
                List<String> filterLaboratories = laboratories
                    .where((x) => x.toLowerCase().contains(val.toLowerCase()))
                    .toList();

                setState(() {
                  _laboratories = filterLaboratories;
                });
              },
              decoration: const InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(
                        1, 1, 1, 1), // add padding to adjust icon
                    child: Icon(Icons.search),
                  ),
                  fillColor: Color(0xFFe9e9e9),
                  filled: true,
                  hintText: 'Laboraties',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFF2196f3)))),
            ),
            Expanded(
              // height: 300,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _laboratories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(_context, _laboratories[index]);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(_laboratories[index]))),
                    );
                  }),
            )
          ]),
        ),
      );
    });
  }
}

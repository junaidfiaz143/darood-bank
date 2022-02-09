import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durood_bank/components/text_field_component.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/no_scroll_glow_behavior.dart';
import 'package:durood_bank/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:line_icons/line_icons.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  CounterScreenState createState() => CounterScreenState();
}

class CounterScreenState extends State<CounterScreen> {
  double _daroodCounter = 0;

  makeContribution() {
    if (_daroodCounter >= 100) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Utilities.showLoadingDialog(context: context);
          });
      FirebaseFirestore.instance.collection("durood").doc().set({
        "full_name": "_fullName",
        "username": "username",
        "is_official": false,
        "date": "_password",
        "time": "_password",
        "contribution": "${_daroodCounter.round()}",
      }).whenComplete(() {
        Navigator.pop(context);
        Navigator.pop(context, "asas");
      });
    } else {
      Utilities.showSnackBar(
          txt: "Recite درود atleast 100 times", context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(MyColors.primaryColor),
        elevation: 0,
        title: const Text("Counter"),
      ),
      body: Column(
        children: [
          const Spacer(),
          Text("درودکاؤنٹر",
              style: GoogleFonts.elMessiri(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(MyColors.primaryColor))),
          Container(
            width: Size.infinite.width,
            margin: const EdgeInsets.symmetric(horizontal: 26),
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              color: const Color(MyColors.primaryColor).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${_daroodCounter.toInt()}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(MyColors.primaryColor),
                  fontSize: 56,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 200,
            height: 45,
            child: ButtonComponent(
              title: "Contribute",
              check: false,
              icon: LineIcons.arrowCircleUp,
              function: () {
                makeContribution();
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(MyColors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ScrollConfiguration(
              behavior: NoScrollGlowBehavior(),
              child: HorizontalPicker(
                  minValue: 0,
                  maxValue: 100000,
                  divisions: 1000,
                  height: 100,
                  showCursor: false,
                  backgroundColor: Colors.transparent,
                  activeItemTextColor: const Color(MyColors.primaryColor),
                  initialPosition: InitialPosition.start,
                  onChanged: (value) {
                    setState(() {
                      _daroodCounter = value;
                    });
                  }),
            ),
          )
        ],
      ),
    ));
  }
}

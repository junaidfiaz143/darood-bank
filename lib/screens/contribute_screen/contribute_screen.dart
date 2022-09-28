import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durood_bank/components/slider_component.dart';
import 'package:durood_bank/components/text_field_component.dart';
import 'package:durood_bank/utils/colors.dart';
import 'package:durood_bank/utils/globals.dart';
import 'package:durood_bank/utils/no_scroll_glow_behavior.dart';
import 'package:durood_bank/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../models/current_user_model.dart';

class ContributeScreen extends StatefulWidget {
  const ContributeScreen({Key? key}) : super(key: key);

  @override
  ContributeScreenState createState() => ContributeScreenState();
}

class ContributeScreenState extends State<ContributeScreen> {
  double _daroodCounter = 0;

  makeContribution() {
    if (_daroodCounter >= 100) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Utilities.showLoadingDialog(context: context);
          });
      FirebaseFirestore.instance.collection("durood").doc().set({
        "full_name":
            Provider.of<CurrentUserModel>(context, listen: false).fullName,
        "username":
            Provider.of<CurrentUserModel>(context, listen: false).userName,
        "is_official":
            Provider.of<CurrentUserModel>(context, listen: false).isOfficial ==
                    "true"
                ? true
                : false,
        "contribution": "${_daroodCounter.round()}",
        "time_stamp": FieldValue.serverTimestamp(),
        "contribution_id": contributionId
      }).whenComplete(() {
        Navigator.pop(context);
        Navigator.pop(context, "contributed");
      });
    } else {
      Utilities.showSnackBar(
          txt: "Recite درود atleast 100 times", context: context);
    }
  }

  late FixedExtentScrollController fixedExtentScrollController;
  int sliderLength = 101;
  late int selectedFatValue;
  @override
  void initState() {
    selectedFatValue = 0;
    fixedExtentScrollController = FixedExtentScrollController(initialItem: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: const Color(MyColors.primaryColor),
      //   elevation: 0,
      //   title: const Text("Counter"),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkResponse(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: const Color(MyColors.primaryColor)
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            LineIcons.arrowLeft,
                            color: Color(MyColors.primaryColor),
                          )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "CONTRIBUTION",
                          style: TextStyle(
                            color: Color(MyColors.primaryColor),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        // const Text("Junaid Fiaz"),
                      ],
                    ),
                    Visibility(
                      visible: true,
                      child: InkResponse(
                        onTap: () {},
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              LineIcons.edit,
                              color: Colors.transparent,
                            )),
                      ),
                    )
                  ]),
            ),
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
      ),
    ));
  }
}

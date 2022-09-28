import 'package:durood_bank/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
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
                          "NOTIFICATIONS",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("درود بینک کے بانی",
                  style: GoogleFonts.elMessiri(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: const Color(MyColors.primaryColor))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.all(1),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(MyColors.primaryColor)
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/haji_m_fiaz.jpeg",
                            fit: BoxFit.fill,
                          ),
                        )),
                    Text(
                      "حاجی محمد فیاض",
                      style: GoogleFonts.elMessiri(
                          color: const Color(MyColors.primaryColor)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.all(1),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(MyColors.primaryColor)
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            "assets/images/haji_m_muneer.png",
                            fit: BoxFit.fill,
                          ),
                        )),
                    Text(
                      "حاجی منیر احمد",
                      style: GoogleFonts.elMessiri(
                          color: const Color(MyColors.primaryColor)),
                    )
                  ],
                )
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    ));
  }
}

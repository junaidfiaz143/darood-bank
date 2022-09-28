import 'package:durood_bank/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  ContactUsScreenState createState() => ContactUsScreenState();
}

class ContactUsScreenState extends State<ContactUsScreen> {
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
                          "CONTACT US",
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
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(MyColors.grey).withOpacity(0.9)),
              child: Column(
                children: [
                  const Text(
                    "A product of",
                    style: TextStyle(
                        fontSize: 10, color: Color(MyColors.primaryColor)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "JD",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(MyColors.primaryColor)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(LineIcons.globe,
                            color: Color(MyColors.primaryColor)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(LineIcons.facebook,
                            color: Color(MyColors.primaryColor)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(LineIcons.whatSApp,
                            color: Color(MyColors.primaryColor)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(MyColors.grey).withOpacity(0.9)),
              child: Column(
                children: [
                  const Text(
                    "Designed & Developed by",
                    style: TextStyle(
                        fontSize: 10, color: Color(MyColors.primaryColor)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "iNventor's Inc.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(MyColors.primaryColor)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(LineIcons.globe,
                            color: Color(MyColors.primaryColor)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(LineIcons.facebook,
                            color: Color(MyColors.primaryColor)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(LineIcons.whatSApp,
                            color: Color(MyColors.primaryColor)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    ));
  }
}

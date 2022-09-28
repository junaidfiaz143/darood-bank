import 'package:durood_bank/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> {
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
                          "FILTER",
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("we are working on it for you...",
                  style: TextStyle(color: Color(MyColors.greyText))),
            ),
            const Spacer()
          ],
        ),
      ),
    ));
  }
}

import 'package:durood_bank/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../components/text_field_component.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  FeedbackScreenState createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                          "FEEDBACK",
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
            SizedBox(
              width: size.width * 0.8,
              child: Form(
                // key: _phonelogin,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "GUIDE US",
                        style: TextStyle(
                          color: Color(MyColors.primaryColor),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    TextFormField(
                      // enabled: !model.isLoading,
                      maxLines: 5,
                      // textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                      // expands: true,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(
                              1, 1, 1, 70), // add padding to adjust icon
                          child: Icon(LineIcons.comment),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color(MyColors.primaryColor))),
                        fillColor: Color(MyColors.grey),
                        filled: true,
                        hintText: 'write your feedback/suggestion here...',
                      ),
                      onChanged: (value) {
                        // _password = value;
                        // print(_password);
                      },
                      validator: (value) {
                        // print(value);
                        if (value!.length == 8) {
                          return null;
                        }
                        return 'Password Length Should be Greater Than or Equal to 8';
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                  height: 45,
                  width: 200,
                  child: ButtonComponent(
                    function: () async {},
                    title: 'SUBMIT',
                    icon: LineIcons.arrowCircleRight,
                    check: false,
                  )),
            ),
            const Spacer()
          ],
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../models/current_user_model.dart';
import '../../utils/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                Row(
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
                            "Profile",
                            style: TextStyle(
                                color: Color(MyColors.primaryColor),
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                letterSpacing: 2),
                          ),
                          // const Text("Junaid Fiaz"),
                        ],
                      ),
                      InkResponse(
                        onTap: () {},
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: const Color(MyColors.primaryColor)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              LineIcons.edit,
                              color: Color(MyColors.primaryColor),
                            )),
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
                // const Text(
                //   'My\nProfile',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 34,
                //   ),
                // ),
                // const SizedBox(
                //   height: 22,
                // ),
                SizedBox(
                  height: height * 0.43,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: innerHeight * 0.72,
                              width: innerWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(MyColors.primaryColor)
                                    .withOpacity(0.3),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  Text(
                                    "${Provider.of<CurrentUserModel>(context, listen: false).fullName}",
                                    style: const TextStyle(
                                      color: Color(MyColors.primaryColor),
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: const [
                                          Text(
                                            'Current Year',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                          Text(
                                            '100',
                                            style: TextStyle(
                                              color:
                                                  Color(MyColors.primaryColor),
                                              fontSize: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 8,
                                        ),
                                        child: Container(
                                          height: 50,
                                          width: 2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: const [
                                          Text(
                                            'Previous',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                          Text(
                                            '1090',
                                            style: TextStyle(
                                              color:
                                                  Color(MyColors.primaryColor),
                                              fontSize: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Positioned(
                          //   top: 110,
                          //   right: 20,
                          //   child: Icon(
                          //     LineIcons.user,
                          //     color: Colors.white,
                          //     size: 30,
                          //   ),
                          // ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: const Color(MyColors.primaryColor)
                                          .withOpacity(1),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Icon(
                                    LineIcons.user,
                                    size: 32,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                profileInfoWidget(
                    label:
                        "${Provider.of<CurrentUserModel>(context, listen: false).phoneNumber}",
                    icon: LineIcons.phone),
                profileInfoWidget(
                    label:
                        "${Provider.of<CurrentUserModel>(context, listen: false).gender}",
                    icon: Provider.of<CurrentUserModel>(context, listen: false)
                                .gender ==
                            "Male"
                        ? LineIcons.male
                        : LineIcons.female),
                profileInfoWidget(
                    label:
                        "${Provider.of<CurrentUserModel>(context, listen: false).city}",
                    icon: LineIcons.city),
              ],
            ),
          ),
        ),
      ),
    );
  }

  profileInfoWidget({required String label, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        enabled: false,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(
                  1, 1, 1, 1), // add padding to adjust icon
              child: Icon(
                icon,
                color: const Color(MyColors.primaryColor),
              ),
            ),
            fillColor: const Color(MyColors.primaryColor).withOpacity(0.3),
            filled: true,
            label: Text(
              label,
              style: const TextStyle(color: Color(MyColors.primaryColor)),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Color(MyColors.primaryColor)))),
        keyboardType: TextInputType.phone,
        onChanged: (value) {
          // _phoneNumber = value;
        },
        validator: (value) {
          // print(value);
          if (value!.length == 11) {
            return null;
          }
          return 'Please Enter Valid Phone Number';
        },
      ),
    );
  }
}

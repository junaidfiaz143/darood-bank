import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durood_bank/models/current_user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

Widget getContributionItem(
    BuildContext context, QueryDocumentSnapshot<Object?> contribution) {
  return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
      child: Container(
          // height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: contribution["username"] ==
                    Provider.of<CurrentUserModel>(context, listen: false)
                        .userName
                ? const Color(MyColors.primaryColor)
                : const Color(MyColors.accentColor),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 5,
                      decoration: BoxDecoration(
                        color: contribution["username"] ==
                                Provider.of<CurrentUserModel>(context,
                                        listen: false)
                                    .userName
                            ? const Color(MyColors.grey).withOpacity(0.5)
                            : const Color(MyColors.accentColorLight),
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5),
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: contribution["username"] ==
                                  Provider.of<CurrentUserModel>(context,
                                          listen: false)
                                      .userName
                              ? const Color(MyColors.grey).withOpacity(0.5)
                              : const Color(MyColors.accentColorLight),
                        ),
                        child: Icon(
                          LineIcons.user,
                          color: contribution["username"] ==
                                  Provider.of<CurrentUserModel>(context,
                                          listen: false)
                                      .userName
                              ? const Color(MyColors.primaryColor)
                              : const Color(MyColors.accentColor),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  contribution["full_name"]
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                Visibility(
                                  visible: contribution["is_official"] == true
                                      ? true
                                      : false,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Image.asset(
                                        'assets/images/official_check_icon.png',
                                        scale: 4),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "@${contribution["username"]}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                  color: Colors.white),
                            )
                          ]),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(MyColors.grey),
                            ),
                            child: Text(
                              "${contribution["contribution"]}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: contribution["username"] ==
                                        Provider.of<CurrentUserModel>(context,
                                                listen: false)
                                            .userName
                                    ? const Color(MyColors.primaryColor)
                                    : const Color(MyColors.accentColor),
                              ),
                            ),
                          ),
                          // Text(
                          //   DateFormat('dd-MM-yyyy • hh:mm a')
                          //       .format(contribution['time_stamp'].toDate()),
                          //   style: const TextStyle(
                          //       fontWeight: FontWeight.w300,
                          //       fontSize: 10,
                          //       color: Colors.white),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 3, 40, 3),
                decoration: BoxDecoration(
                    color: contribution["username"] ==
                            Provider.of<CurrentUserModel>(context,
                                    listen: false)
                                .userName!
                        ? const Color(MyColors.grey).withOpacity(0.5)
                        : const Color(MyColors.accentColorLight),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Text(
                    DateFormat('dd-MM-yyyy • hh:mm a')
                        .format(contribution['time_stamp'].toDate()),
                    style: const TextStyle(fontSize: 10, color: Colors.white)),
              )
            ],
          )));
}

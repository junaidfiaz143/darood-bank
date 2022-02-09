import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../utils/colors.dart';

Widget getContributionItem(
    BuildContext context, QueryDocumentSnapshot<Object?> contribution) {
  return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
      child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color(MyColors.accentColor),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 5,
                decoration: const BoxDecoration(
                  color: Color(MyColors.accentColorLight),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 5),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(MyColors.accentColorLight),
                  ),
                  child: const Icon(
                    LineIcons.user,
                    color: Color(MyColors.accentColor),
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
                            contribution["full_name"].toString().toUpperCase(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Visibility(
                            visible: contribution["is_official"] == true,
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
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(MyColors.grey),
                      ),
                      child: Text(
                        "${contribution["contribution"]}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(MyColors.accentColor)),
                      ),
                    ),
                    Text(
                      "${contribution["date"]} • ${contribution["time"]}",
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          )));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:durood_bank/models/total_durood_model.dart';
import 'package:durood_bank/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class DuroodUtils {
  static getCurrentContributionId({required BuildContext context}) async {
    final QuerySnapshot contributionQuery =
        await FirebaseFirestore.instance.collection("contribution_id").get();
    dynamic data = contributionQuery.docs.first.data();
    contributionId = data["current_durood_cycle"];

    updateTotalDurood(context: context);
  }

  static updateCurrentContributionId({required BuildContext context}) async {
    int id = int.parse(contributionId);
    FirebaseFirestore.instance
        .collection("contribution_id")
        .doc("LifDNWDq7gI19jIyOiDq")
        .update({
      "old_durood_cycle": FieldValue.arrayUnion(["000$id"])
    });
    id++;
    FirebaseFirestore.instance
        .collection("contribution_id")
        .doc("LifDNWDq7gI19jIyOiDq")
        .update({"current_durood_cycle": "000$id"});
    contributionId = "000" + id.toString();

    updateTotalDurood(context: context);

    MyApp.restartApp(context);
  }

  static updateTotalDurood({required BuildContext context}) async {
    int totalDurood = 0;

    var documents = FirebaseFirestore.instance
        .collection('durood')
        .where("contribution_id", isEqualTo: contributionId)
        .get();

    documents.then((value) {
      if (value.docs.isNotEmpty) {
        for (int i = 0; i < value.docs.length; i++) {
          totalDurood = totalDurood + int.parse(value.docs[i]["contribution"]);
        }
        Provider.of<TotalDurooodModel>(context, listen: false)
            .updateTotalDuroodCounter(totalDurood);
      } else {
        Provider.of<TotalDurooodModel>(context, listen: false)
            .updateTotalDuroodCounter(totalDurood);
      }
    });
  }
}

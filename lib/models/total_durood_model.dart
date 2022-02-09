import 'package:flutter/material.dart';

class TotalDurooodModel extends ChangeNotifier {
  int countTotalDurood = 0;

  updateTotalDuroodCounter(int countTotalDurood) {
    this.countTotalDurood = countTotalDurood;
    notifyListeners();
  }
}

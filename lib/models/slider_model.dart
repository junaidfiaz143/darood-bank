import 'package:flutter/cupertino.dart';

class SliderModel extends ChangeNotifier {
  int? currentPage = 0;

  SliderModel({this.currentPage});

  void updatePosition(int page) {
    currentPage = page;
    notifyListeners();
  }
}

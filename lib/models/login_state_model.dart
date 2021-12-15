import 'package:flutter/material.dart';

class LoginStateModel extends ChangeNotifier {
  bool isLoading;

  LoginStateModel({required this.isLoading});

  set updateLoadingState(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }
}

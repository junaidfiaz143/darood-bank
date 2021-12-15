import 'package:flutter/cupertino.dart';

class OTPCallback extends ChangeNotifier {
  bool otpTimeComplete = false;

  setOTPDone(bool otpTimeComplete) {
    this.otpTimeComplete = otpTimeComplete;
    notifyListeners();
  }
}

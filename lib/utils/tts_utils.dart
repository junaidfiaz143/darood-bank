import 'package:durood_bank/models/current_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class TTSUtils {
  static FlutterTts flutterTts = FlutterTts();

  static welcome({required BuildContext context}) async {
    // List<dynamic> languages = await flutterTts.getLanguages;

    // debugPrint("$languages");

    // var installed = await flutterTts.isLanguageInstalled("ur-PK");

    // debugPrint("$installed");

    await flutterTts.setLanguage("ur-PK");
    var result = await flutterTts.speak(
        "${Provider.of<CurrentUserModel>(context, listen: false).fullName}. درود بینک میں آپ کاخوش آمدید ");

    if (result == 1) {}
  }
}

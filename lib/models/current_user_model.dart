import 'package:flutter/foundation.dart';

class CurrentUserModel extends ChangeNotifier {
  String? fullName;
  String? userName;
  String? isOfficial;
  String? phoneNumber;
  String? city;
  String? password;
  CurrentUserModel(
      {required this.fullName,
      required this.userName,
      required this.isOfficial,
      required this.phoneNumber,
      required this.city,
      required this.password});

  get getFullName => fullName;
}

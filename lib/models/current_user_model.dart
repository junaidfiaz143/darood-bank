import 'package:flutter/foundation.dart';

class CurrentUserModel extends ChangeNotifier {
  String? fullName;
  String? userName;
  String? isOfficial;
  String? phoneNumber;
  String? city;
  String? gender;
  String? password;
  CurrentUserModel(
      {this.fullName,
      this.userName,
      this.isOfficial,
      this.phoneNumber,
      this.city,
      this.gender,
      this.password});

  get getFullName => fullName;
}

import 'package:flutter/foundation.dart';

class CurrentUserModel extends ChangeNotifier {
  String? fullName;
  String? userName;
  String? isOfficial;
  String? phoneNumber;
  String? city;
  String? password;
  CurrentUserModel(
      {this.fullName,
      this.userName,
      this.isOfficial,
      this.phoneNumber,
      this.city,
      this.password});

  get getFullName => fullName;
}

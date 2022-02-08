import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

sendOTP(String _phoneNumber) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  await auth.verifyPhoneNumber(
    phoneNumber: _phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      // ANDROID ONLY!

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (value.user != null) {}
      });

      log("otp verified ${credential.smsCode}");
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      log("otp timeout $verificationId");
    },
    codeSent: (String verificationId, int? forceResendingToken) {
      log("otp code sent");

      // setState(() {
      //   verificationCode = verificationId;
      // });
    },
    verificationFailed: (FirebaseAuthException error) {
      log("otp failed $error");
    },
    timeout: const Duration(seconds: 60),
  );
}

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:phlebotomist_app/constants/constants.dart';

// import 'globals.dart';

// class ApiCall {
//   ApiCall({required this.url});

//   String url;
//   Dio dio = new Dio();

//   Future<dynamic> postData(dynamic userData) async {
//     try {
//       Response response;
//       response = await dio.post(
//         url,
//         data: userData,
//         options: Options(
//           headers: {
//             "content-type": "application/json",
//             "accept": "application/json",
//             'token': 'Bearer ' + token
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         print('ERROR:' + response.statusCode.toString());
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<dynamic> postDataWithoutHeader(dynamic userData) async {
//     try {
//       Response response;
//       response = await dio.post(
//         url,
//         data: userData,
//       );
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         print('ERROR:' + response.statusCode.toString());
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<dynamic> getData({required BuildContext? context}) async {
//     try {
//       Response response;
//       response = await dio.get(
//         url,
//         options: Options(
//           headers: {Constants.keyToken: 'Bearer' + ' ' + token},
//         ),
//       );
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         // Utilities.showInfoDialog(context!, 'Error');
//         print('ERROR:' + response.statusCode.toString());
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   Future<dynamic> getDataWithToken(String _token) async {
//     try {
//       Response response;
//       response = await dio.get(
//         url,
//         options: Options(
//           headers: {Constants.keyToken: 'Bearer' + ' ' + _token},
//         ),
//       );
//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         print('ERROR:' + response.statusCode.toString());
//         return null;
//       }
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
// }

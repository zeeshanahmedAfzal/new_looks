import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_looks/screens/sign_up/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/UserModel.dart';

class Constant {
  static const EMAIL_REGEX =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const PASS_REGEX1 = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{7,}$';
}

showSnackbar({required String message}) {
  if (message.isNotEmpty)
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
}



storedObject({
  Map<String, dynamic>? jsonObject,
  required String key,
  required String docId,
  required String docIdKey,
}) async {
  try {
    if (jsonObject == null) return print("Data not store object null");
    SharedPreferences pref = await SharedPreferences.getInstance();
    String storedJson = jsonEncode(jsonObject);
    print("storedJson $storedJson");
    await pref.setString(docIdKey, docId);
    await pref.setString(key, storedJson);
  } catch (e) {
    print('Error storing object: $e');
  }
}


showUserDetails({bool? fromSplash}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? userJson = pref.getString('userData');
  print("userJson : $userJson");
  if(userJson == null && fromSplash == true){
    Get.offAll(() => RegistrationScreen());
  }
  if (userJson != null) {
    String? userDocId = await pref.getString("userDocId");
    Map<String, dynamic> userMap = jsonDecode(userJson);
    var user = UserModel.fromMap(userMap,userDocId??'');
    print("userDetails : ${user.email}");
    return user;
  }
}


showSellerDetails() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? sellerJson = pref.getString('sellerData');
  if (sellerJson != null) {
    String? sellerDocId = await pref.getString("sellerDocId");
    Map<String, dynamic> userMap = jsonDecode(sellerJson);
    var user = SellerModel.fromMap(userMap,sellerDocId??'');
    // print("userDetails : ${user.email}");
    return user;
  }else{
    return "User was not a seller";
  }
}


Color getColorFromHex(String hexColor) {
  if (hexColor == null || hexColor.trim().isEmpty) {
    print("Invalid color value: Input is null or empty.");
  }

  hexColor = hexColor.toUpperCase().replaceAll('#', '').trim();

  if (RegExp(r'^[0-9A-F]{6}$').hasMatch(hexColor)) {
    hexColor = 'FF$hexColor'; // Add full opacity if not specified
  } else if (!RegExp(r'^[0-9A-F]{8}$').hasMatch(hexColor)) {
    print("Invalid color format: '$hexColor'. Expected a 6- or 8-digit hex code.");
  }

  return Color(int.parse('0xff$hexColor'));
}
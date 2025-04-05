import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/utiles.dart';
import '../login/login_scrren.dart';

class ForgotPasswordController extends GetxController {
  RxString newPassErrorMsg = "".obs;
  RxString confirmPassErrorMsg = "".obs;

  var newPassword = "".obs;
  var confirmPassword = "".obs;

  validate() {
    RegExp regPass = new RegExp(Constant.PASS_REGEX1);
    if (newPassword.value.length == 0) {
      newPassErrorMsg('Please enter new password');
    } else if (!regPass.hasMatch(newPassword.value)) {
      newPassErrorMsg('Please enter valid password');
    } else {
      newPassErrorMsg('');
    }

    if (confirmPassword.value.length == 0) {
      confirmPassErrorMsg("Please enter new password");
    } else if (confirmPassword.value != newPassword.value) {
      confirmPassErrorMsg('Password Does not match');
    } else {
      confirmPassErrorMsg('');
      print("Success");
      Get.offUntil(MaterialPageRoute(builder: (context) => LoginScreen()),
          ModalRoute.withName('/'));
      showSnackbar(message: "Password Change Successfully");
    }
  }
}

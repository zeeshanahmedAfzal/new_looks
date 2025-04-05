import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../mainScreen.dart';

class SignUpOtpVerificationScreen extends StatelessWidget {
  const SignUpOtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Icon(
                    Icons.arrow_back,
                    color: CustomColor.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 34.0),
                child: Text(
                  "Verification code",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      color: CustomColor.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  "Please enter the verification code we sent to your email address",
                  style: TextStyle(
                      color: CustomColor.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OtpTextField(
                  numberOfFields: 4,
                  borderRadius: BorderRadius.circular(100),
                  borderColor: CustomColor.startSecondBgColor,
                  focusedBorderColor: CustomColor.black,
                  cursorColor: CustomColor.black,
                  fieldHeight: 60,
                  fieldWidth: 60,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    print(verificationCode);
                    Get.to(() => MainScreen());
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text("Verification Code"),
                    //         content: Text('Code entered is $verificationCode'),
                    //       );
                    //     });
                  }, // end onSubmit
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/custom_text_form_field.dart';
import 'verification_code_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
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
                    "Forgot Password?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                        color: CustomColor.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    "Enter email associated with your account and we’ll send and email with intructions to reset your password",
                    style: TextStyle(
                        color: CustomColor.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                ),
                Sign_Up_TextField(
                  errorMessage: "",
                  labelText: "Enter your email here",
                  enableBorderColor: Color(0xffD6D6D6),
                  focusedBorderColor: CustomColor.black,
                  labelTextColor: CustomColor.black,
                  cursorColor: CustomColor.black,
                  prefixIcon: Icon(
                    Icons.email,
                    color: CustomColor.startSecondBgColor,
                  ),
                  onChanged: (txt) {
                    // controller.firstName(txt);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: ATButtonV3(
                      title: "SEND OTP",
                      containerWidth: 147,
                      height: 50,
                      color: Color(0xff2D201C),
                      textColor: CustomColor.white,
                      radius: 25,
                      onTap: () {
                        Get.to(() => VerificationOtp());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

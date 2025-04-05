import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controller.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Create new password",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 32,
                        color: CustomColor.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Text(
                    "Your new password must be different from previously used password",
                    style: TextStyle(
                        color: CustomColor.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Obx(
                    () => Sign_Up_TextField(
                      errorMessage: controller.newPassErrorMsg.value,
                      labelText: "New Password",
                      suffixIcon: true,
                      enableBorderColor: Color(0xffD6D6D6),
                      focusedBorderColor: CustomColor.black,
                      labelTextColor: CustomColor.black,
                      cursorColor: CustomColor.black,
                      onChanged: (txt) {
                        controller.newPassword(txt);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(
                    () => Sign_Up_TextField(
                      errorMessage: controller.confirmPassErrorMsg.value,
                      suffixIcon: true,
                      labelText: "Confirm Password",
                      enableBorderColor: Color(0xffD6D6D6),
                      focusedBorderColor: CustomColor.black,
                      labelTextColor: CustomColor.black,
                      cursorColor: CustomColor.black,
                      onChanged: (txt) => controller.confirmPassword(txt),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: ATButtonV3(
                      title: "Confirm",
                      containerWidth: 147,
                      height: 50,
                      color: Color(0xff2D201C),
                      textColor: CustomColor.white,
                      radius: 25,
                      onTap: () {
                        controller.validate();
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

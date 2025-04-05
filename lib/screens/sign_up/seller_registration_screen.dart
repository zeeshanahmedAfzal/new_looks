import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/screens/login/login_scrren.dart';

import '../../constants/colors.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/custom_text_form_field.dart';
import 'registration_controller.dart';

class SellerSignUpScreen extends StatelessWidget {
  const SellerSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationController());
    final loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Text(
                  "Create\nYour Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      color: CustomColor.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Obx(
                      () => Sign_Up_TextField(
                    errorMessage: controller.businessNameError.value,
                    labelText: "Business Name",
                    enableBorderColor: Color(0xffD6D6D6),
                    focusedBorderColor: CustomColor.black,
                    labelTextColor: CustomColor.black,
                    cursorColor: CustomColor.black,
                    onChanged: (txt) {
                      controller.businessName(txt);
                    },
                  ),
                ),
              ),
              Obx(()=>
                  Padding(
                    padding: EdgeInsets.only(top:controller.firstNameError.value.isEmpty ? 0 : 10),
                    child: Obx(
                          () => Sign_Up_TextField(
                        errorMessage: controller.firstNameError.value,
                        labelText: "First Name",
                        enableBorderColor: Color(0xffD6D6D6),
                        focusedBorderColor: CustomColor.black,
                        labelTextColor: CustomColor.black,
                        cursorColor: CustomColor.black,
                        onChanged: (txt) => controller.firstName(txt),
                      ),
                    ),
                  ),
              ),
              Obx(()=>
                  Padding(
                    padding: EdgeInsets.only(top:controller.lastNameError.value.isEmpty ? 0 : 10),
                    child: Obx(
                          () => Sign_Up_TextField(
                        errorMessage: controller.lastNameError.value,
                        labelText: "Last Name",
                        enableBorderColor: Color(0xffD6D6D6),
                        focusedBorderColor: CustomColor.black,
                        labelTextColor: CustomColor.black,
                        cursorColor: CustomColor.black,
                        onChanged: (txt) => controller.lastName(txt),
                      ),
                    ),
                  ),
              ),
              Obx(()=>
                  Padding(
                    padding: EdgeInsets.only(top:controller.contactNumberError.value.isEmpty ? 0 : 10),
                    child: Obx(
                          () => Sign_Up_TextField(
                        errorMessage: controller.contactNumberError.value,
                        labelText: "Contact Number",
                        keyBoardType: TextInputType.number,
                        enableBorderColor: Color(0xffD6D6D6),
                        focusedBorderColor: CustomColor.black,
                        labelTextColor: CustomColor.black,
                        cursorColor: CustomColor.black,
                        onChanged: (txt) => controller.contactNumber(txt),
                      ),
                    ),
                  ),
              ),
              Obx(()=>
                  Padding(
                    padding: EdgeInsets.only(top:controller.emailError.value.isEmpty ? 0 : 10),
                    child: Obx(
                          () => Sign_Up_TextField(
                        errorMessage: controller.emailError.value,
                        labelText: "Business Email",
                        enableBorderColor: Color(0xffD6D6D6),
                        focusedBorderColor: CustomColor.black,
                        labelTextColor: CustomColor.black,
                        cursorColor: CustomColor.black,
                        onChanged: (txt) => controller.email(txt),
                      ),
                    ),
                  ),
              ),
              Obx(()=>
                  Padding(
                    padding: EdgeInsets.only(top:controller.passwordError.value.isEmpty ? 0 : 10),
                    child: Obx(
                          () => Sign_Up_TextField(
                        errorMessage: controller.passwordError.value,
                        suffixIcon: true,
                        labelText: "Password",
                        enableBorderColor: Color(0xffD6D6D6),
                        focusedBorderColor: CustomColor.black,
                        labelTextColor: CustomColor.black,
                        cursorColor: CustomColor.black,
                        onChanged: (txt) => controller.password(txt),
                      ),
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: ATButtonV3(
                    title: "Sign Up",
                    isLoading: controller.isLoading.value,
                    containerWidth: 147,
                    height: 50,
                    color: Color(0xff2D201C),
                    textColor: CustomColor.white,
                    radius: 25,
                    onTap: () async {
                      controller.validateEmail(isBusiness: true);
                      if (controller.enableButton.value == true) {
                        var values = {
                          "email": (controller.email.value),
                          "firstname": (controller.firstName.value),
                          "lastname": (controller.lastName.value),
                          "firstname_err":
                          (controller.firstNameError.value ?? ""),
                          "lastname_err":
                          (controller.lastNameError.value ?? ""),
                          "password_err":
                          (controller.passwordError.value ?? ""),
                        };
                        controller.registeringAsSeller(email: controller.email.value.trim(),
                            password: controller.password.value.trim(),
                            firstName: controller.firstName.value.trim(),
                            lastName: controller.lastName.value.trim(),
                          businessName: controller.businessName.value.trim(),
                          contactNumber: controller.contactNumber.value.trim(),
                          controller: loginController,
                          isSeller: true
                        );
                        print(values);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Center(
                  //   child: Text(
                  //     "or sign up with",
                  //     style: TextStyle(
                  //       color: CustomColor.black,
                  //       fontWeight: FontWeight.w200,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SvgPicture.asset(AssetUtils.AppleLogo),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20),
                  //       child: SvgPicture.asset(AssetUtils.GoogleLogo),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 20),
                  //       child: SvgPicture.asset(AssetUtils.FacebookLogo),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Already have account? ",
                  //       style: TextStyle(
                  //           color: CustomColor.black,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Get.to(() => LoginScreen());
                  //       },
                  //       child: Text(
                  //         "Login",
                  //         style: TextStyle(
                  //             decoration: TextDecoration.underline,
                  //             decorationColor: CustomColor.black,
                  //             color: CustomColor.black,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      )
    );
  }
}



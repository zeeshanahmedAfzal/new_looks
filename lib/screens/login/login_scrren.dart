import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_looks/screens/DashBoard/dashborad.dart';
import '../../constants/colors.dart';
import '../../constants/utiles.dart';
import '../../mainScreen.dart';
import '../../model/UserModel.dart';
import '../../widgets/AssetImages.dart';
import '../../widgets/CustomButton.dart';
import '../../widgets/custom_text_form_field.dart';
import '../forget_password/forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: Text(
                  "Login into\nyour Account",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 32,
                      color: CustomColor.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Sign_Up_TextField(
                  errorMessage: controller.emailError.value,
                  labelText: "Email",
                  enableBorderColor: Color(0xffD6D6D6),
                  focusedBorderColor: CustomColor.black,
                  labelTextColor: CustomColor.black,
                  cursorColor: CustomColor.black,
                  onChanged: (txt) {
                    controller.email(txt);
                  },
                ),
              ),
              Sign_Up_TextField(
                errorMessage: controller.passwordError.value,
                suffixIcon: true,
                labelText: "Password",
                enableBorderColor: Color(0xffD6D6D6),
                focusedBorderColor: CustomColor.black,
                labelTextColor: CustomColor.black,
                cursorColor: CustomColor.black,
                onChanged: (txt) => controller.password(txt),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ForgetPasswordScreen());
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: CustomColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: ATButtonV3(
                    title: "LOGIN",
                    containerWidth: 147,
                    height: 50,
                    color: Color(0xff2D201C),
                    textColor: CustomColor.white,
                    radius: 25,
                    onTap: () async {
                      controller.verify();
                      var val = {
                        "email": controller.email.value,
                        "password": controller.password.value
                      };
                      print(val);
                      await controller.login(email: controller.email.value, password: controller.password.value);
                      // Get.to(() => MainScreen());
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: CustomColor.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)
                ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                              AssetUtils.GoogleLogo,
                              height: 30,
                              width: 30,
                          ),
                          SizedBox(width: 10,),
                          Text("Login via Google",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
              )
              // Padding(
              //   padding: const EdgeInsets.only(top: 20.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // SvgPicture.asset(AssetUtils.AppleLogo),
              //
              //       // Padding(
              //       //   padding: const EdgeInsets.only(left: 20),
              //       //   child: SvgPicture.asset(AssetUtils.FacebookLogo),
              //       // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginController extends GetxController{
  RxString email = "".obs;
  RxString password = "".obs;
  RxString emailError = "".obs;
  RxString passwordError = "".obs;
  RxBool enableButton = false.obs;
  final db = FirebaseFirestore.instance;


  verify(){
    bool isValid = true;
    RegExp regExp = RegExp(Constant.EMAIL_REGEX);
    RegExp regExp1 = RegExp(Constant.PASS_REGEX1);

    if (email.value.length == 0) {
      emailError('Please enter email');
      isValid = false;
    } else if (!regExp.hasMatch(email.value)) {
      emailError('Please enter valid email');
      isValid = false;
    } else {
      emailError('');
    }

    if (password.value.length == 0) {
      passwordError('Please enter password');
      isValid = false;
    } else if (!regExp1.hasMatch(password.value)) {
      passwordError('Please enter valid password');
      isValid = false;
    } else {
      passwordError('');
    }

    enableButton(isValid);
    print("button val : ${enableButton.value}");
  }


  login({required String email, required String password}) async {
    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);

      print(userCredential.toString());
      print(userCredential.toString());
      var uid = userCredential.user?.uid;

      await fetchUserData(uid??'');

      Get.offAll(() => MainScreen());

    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuthException errors
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else{
        print(e.code);
      }
    }
  }

  fetchUserData(String uid) async {
    // try {
      // Fetch user document by UID
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .where('id', isEqualTo: uid)
          .get();

      print("user doc ${userDoc.docs.first.data()}");

      if (userDoc.docs.isNotEmpty) {
        // User data exists
        var userData = userDoc.docs.first.data();
        print("User Data: $userData");

        // Map to your user model if needed
        UserModel user = UserModel.fromMap(userData, userDoc.docs.first.id);

        // Save user detail
        if(user.isSeller == true){
          var savedSellerData = await saveSellerDetails(user);
          print("savedSellerData: $savedSellerData");
        }
        var savedUserData = await storedObject(
          jsonObject: userData,
          key: "userData",
          docId: userDoc.docs.first.id,
          docIdKey: 'userDocId',
        );
        print("savedUserData: $savedUserData");
        print("Mapped User: ${user.firstName}, ${user.lastName}, ${user.documentId}");
      } else {
        // Document does not exist
        print("User with UID $uid does not exist.");
      }
    // } catch (e) {
    //   print("Error fetching user data: $e");
    // }
  }

  saveSellerDetails(UserModel user) async {
    print(user.sellerId);
    if(user.isSeller == true){
      var sellerDoc = await FirebaseFirestore.instance
          .collection('Sellers').where('seller_id',isEqualTo: user.sellerId)
          .get();

      print("Seller Data: ${sellerDoc.docs.length}");

      var sellerData = sellerDoc.docs.first.data();

      print("Seller Data: $sellerData");


      // SellerModel sellerModel = SellerModel.fromMap(sellerData, sellerDoc.docs.first.id);
      await storedObject(jsonObject: sellerData,
          key: "sellerData",docId: sellerDoc.docs.first.id,
          docIdKey: "sellerDocId");
    }
  }

}
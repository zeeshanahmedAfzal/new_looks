import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/constants/utiles.dart';
import 'package:new_looks/model/UserModel.dart';
import 'package:new_looks/screens/DashBoard/dashborad.dart';
import 'package:new_looks/screens/sign_up/registration_controller.dart';
import 'package:new_looks/screens/sign_up/registration_screen.dart';
import 'package:new_looks/screens/start_screens/start_screen.dart';
import 'package:new_looks/screens/start_screens/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  navigate() async {
    UserModel userModel = await showUserDetails(fromSplash: true);
    print("userModel $userModel");
    if(userModel.email.isNotEmpty){
      Get.offAll(() => MainScreen());
    }else if(userModel == null){
      Get.offAll(() => StartScreen());
    }else{
      Get.offAll(() => StartScreen());
    }
  }

  clearShared() async {
    var pref = await SharedPreferences.getInstance();
    await pref.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Center(),
    );
  }

  @override
  void initState() {
    // clearShared();
    navigate();
    super.initState();
  }
}

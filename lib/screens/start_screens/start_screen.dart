import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';
import '../../widgets/AssetImages.dart';
import '../../widgets/reusable_button.dart';
import 'start_screen_2.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a1e21),
      body: Stack(
        children: [
          Image.asset(
              height: double.infinity,
              width: double.infinity,
              AssetUtils.StartImage),
          Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Welcome to GemStore",
                  style: TextStyle(
                      color: CustomColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 13,
                ),
                Text(
                  "The Home for a fashion",
                  style: TextStyle(
                      color: CustomColor.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 60,
                ),
                ConstantButton(
                  title: "Get Started",
                  color: Color(0xff6a7073),
                  textColor: CustomColor.white,
                  radius: 30,
                  borderColor: CustomColor.white,
                  height: 53,
                  containerWidth: 190,
                  onTap: () {
                    Get.to(() => StartScreen2());
                  },
                ),
                SizedBox(
                  height: 115,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

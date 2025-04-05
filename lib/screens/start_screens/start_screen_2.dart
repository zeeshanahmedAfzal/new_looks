import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import '../../constants/colors.dart';
import '../../widgets/AssetImages.dart';
import '../../widgets/reusable_button.dart';
import '../sign_up/registration_screen.dart';
import 'start_screen_controller.dart';

class StartScreen2 extends StatelessWidget {
  const StartScreen2({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StartScreenController());

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                color: CustomColor.white,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                color: CustomColor.startSecondBgColor,
              ),
            ],
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Discover Something New",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: CustomColor.black),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Special new arrivals just for you",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CustomColor.black),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * .55,
                    width: 260,
                    decoration: BoxDecoration(
                        color: Color(0xffE7E8E9),
                        borderRadius: BorderRadius.circular(10)),
                    child: ScrollPageView(
                      checkedIndicatorColor: CustomColor.white,
                      controller: controller.scrollController,
                      pageSnapping: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) {
                        controller.currentIndex.value = index;
                      },
                      duration: Duration(),
                      // indicatorWidgetBuilder: null,
                      children: [
                        Center(
                          child: Image.asset(AssetUtils.StartImage,
                              fit: BoxFit.fitHeight,
                              height: MediaQuery.of(context).size.height * .55
                          ),
                        ),
                        Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * .55,
                              child: Image.asset(AssetUtils.StartImage,
                                  height: MediaQuery.of(context).size.height * .55
                              )),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 60,
                ),
                // ConstantButton(
                //   title: "Sign up via Google",
                //   color: Color(0xff6a7073),
                //   textColor: CustomColor.white,
                //   radius: 30,
                //   borderColor: CustomColor.white,
                //   height: 50,
                //   containerWidth: 250,
                //   onTap: () {
                //     // Get.to(() => Sign_Up_Screen());
                //   },
                //   icon: Padding(
                //     padding: const EdgeInsets.only(left: 30.0),
                //     child: Icon(
                //       Icons.arrow_forward,
                //       color: CustomColor.white,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // ConstantButton(
                //   title: "Sign up via Email",
                //   color: Color(0xff6a7073),
                //   textColor: CustomColor.white,
                //   radius: 30,
                //   borderColor: CustomColor.white,
                //   height: 50,
                //   containerWidth: 250,
                //   onTap: () {
                //     Get.to(() => Sign_Up_Screen());
                //   },
                //   icon: Padding(
                //     padding: const EdgeInsets.only(left: 30.0),
                //     child: Icon(
                //       Icons.arrow_forward,
                //       color: CustomColor.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

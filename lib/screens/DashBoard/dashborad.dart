import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_looks/screens/DashBoard/dashboard_controller.dart';
import '../../constants/colors.dart';
import '../../widgets/AssetImages.dart';
import '../../widgets/custom_header.dart';
import '../../profile/profile_screen.dart';
import 'widget/featured_product.dart';
import 'widget/recommendation.dart';
import 'widget/title_widget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DashBoardController());
    controller.getFeaturedProducts();
    return Scaffold(
      backgroundColor: Color(0xffffffff),
        appBar: AppHeader(
            customTitle: Center(child: Text("New Looks")),
            canBack: false,
            customLeading: GestureDetector(
              onTap: (){
                Get.to(() => ProfileScreen());
              },
              child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Image.asset(
                    AssetUtils.Menu,
                    height: 18,
                  )),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.notifications),
              )
            ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CustomColor.black)),
                  child: SvgPicture.asset(AssetUtils.DashBoardImage),
                ),
                SizedBox(
                  height: 35,
                ),
                TitleWidget(
                  title: "Feature Product",
                  viewTitle: "Show all",
                  widget: FeaturedProduct(featuredProducts: controller.featuredProducts),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            NoPaddingContainer(
              containerColor: Color(0xffF8F8FA),
              image: AssetUtils.HangOutPartyImage,
              assetImage: true,
              title: "| NEW COLLECTION",
              subTitile: "HANG OUT\n& PARTY",
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: [
                TitleWidget(
                    title: "Recommended",
                    viewTitle: "Show all",
                    widget: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Recommended(recommendedProducts: controller.featuredProducts),
                        SizedBox(
                          height: 34,
                        )
                      ],
                    )),
                TitleWidget(
                    title: "Top Collection",
                    viewTitle: "Show all",
                    widget: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        NoPaddingContainer(
                          containerColor: Color(0xffF8F8FA),
                          image: AssetUtils.TopCollection,
                          title: "| Sale up to 40%",
                          subTitile: "FOR SLIM\n& BEAUTY",
                          borderRadius: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        NoPaddingContainer(
                          containerColor: Color(0xffF8F8FA),
                          image: AssetUtils.TopCollection,
                          title: "| Sale up to 40%",
                          subTitile: "FOR SLIM\n& BEAUTY",
                          borderRadius: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        NoPaddingContainer(
                          containerColor: Color(0xffF8F8FA),
                          image: AssetUtils.TopCollection,
                          title: "| Summer Collection 2021",
                          subTitile: "Most sexy\n& fabulous\ndesign ",
                          borderRadius: true,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ))
              ],
            ),
          ]),
        ));
  }
}

class NoPaddingContainer extends StatelessWidget {
  const NoPaddingContainer(
      {key,
      this.title,
      this.subTitile,
      this.image,
      this.buttonText,
      this.buttonColor,
      this.containerColor,
      this.assetImage,
      this.onTap,
      this.showButton,
      this.borderRadius});

  final Function? onTap;
  final String? title;
  final String? subTitile;
  final String? image;
  final String? buttonText;
  final Color? buttonColor;
  final Color? containerColor;
  final bool? assetImage;
  final bool? showButton;
  final bool? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: containerColor,
          borderRadius: borderRadius == true
              ? BorderRadius.circular(10)
              : BorderRadius.circular(0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff777E90)),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        subTitile ?? "",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Color(0xff353945)),
                      ),
                    ),
                  ],
                ),
                Visibility(
                    visible: assetImage ?? true,
                    child: Image.asset(
                      image ?? "",
                      width: 100,
                    )),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                onTap!();
              },
              child: Visibility(
                visible: showButton ?? false,
                child: Container(
                  decoration: BoxDecoration(
                      color: buttonColor ?? Color(0xff316A56),
                      borderRadius: BorderRadius.circular(4)),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    buttonText ?? "",
                    style: TextStyle(
                        color: Color(0xffFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

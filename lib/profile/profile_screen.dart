import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/constants/utiles.dart';
import 'package:new_looks/model/UserModel.dart';
import 'package:new_looks/screens/sign_up/registration_screen.dart';
import 'package:new_looks/widgets/custom_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../screens/admin/admin_screen.dart';
import '../screens/admin/users_uploaded_products.dart';
import '../screens/drawer/widget/drawer_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppHeader(
        customTitle: Center(child: Text("Profile")),
        canBack: false,
      ),
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                          // color: Color(0xff000000),
                          //   border: Border(
                          //     bottom: BorderSide(
                          //         color: Color(0xff000000), width:))),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.showUpload.value,
                        child: DrawerContainer(
                          text: 'Upload Clothes',
                          isEdgeInsetPadding: true,
                          iconData: Icon(Icons.upload),
                          onTap: () {
                            Get.to(() => AdminScreen());
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.showUpload.value,
                        child: DrawerContainer(
                          text: 'My Uploads',
                          isEdgeInsetPadding: true,
                          iconData: Icon(Icons.upload),
                          onTap: () {
                            Get.to(() => UsersUploadedProducts());
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => DrawerContainer(
                        text:
                            "${controller.userModel.value?.firstName ?? ''} ${controller.userModel.value?.lastName ?? ''}",
                        iconData: Icon(Icons.account_circle),
                        isEdgeInsetPadding: true,
                      ),
                    ),
                    DrawerContainer(
                      text: "Logout",
                      iconData:
                          Icon(Icons.login_outlined,),
                      isEdgeInsetPadding: true,
                      onTap: () async {
                        var pref = await SharedPreferences.getInstance();
                        await pref.clear();
                        Get.offAll(RegistrationScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   color: Color(0xff000000),
            //   child: Row(
            //     children: [
            //       DrawerContainer(
            //         text: "Logout",
            //         textStyle: TextStyle(color: Color(0xffffffff)),
            //         onTap: () async {
            //         var pref = await SharedPreferences.getInstance();
            //         await pref.clear();
            //         Get.offAll(RegistrationScreen());
            //         },
            //         isEdgeInsetPadding: true,)
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class ProfileController extends GetxController {
  RxBool showUpload = false.obs;
  Rx<UserModel?> userModel = Rx(null);

  @override
  void onInit() {
    checkUserIsSeller();
    super.onInit();
  }

  checkUserIsSeller() async {
    UserModel _userModel = await showUserDetails();
    userModel(_userModel);
    if (userModel.value?.isSeller == true) {
      SellerModel sellerModel = await showSellerDetails();
      showUpload(true);
    }
  }
}

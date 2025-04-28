import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/isar_services/services.dart';
import 'package:new_looks/mainScreen.dart';
import 'package:new_looks/screens/admin/product_model.dart';
import 'package:new_looks/screens/admin/users_uploaded_products.dart';
import 'package:new_looks/widgets/custom_button.dart';

import '../../widgets/custom_header.dart';
import '../result_screeen/result_screen.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(UserCartController(),tag: "cart");
    controller.init();
    return Scaffold(
      appBar: AppHeader(
        customTitle: Center(child: Text("Your Cart")),
        canBack: false,
      ),
      backgroundColor: Color(0xffFFFFFF),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx((){
                    if(controller.products.isNotEmpty){
                      return ResultGrid(products: controller.products,fromCart: true);
                      }else if(controller.products.isEmpty){
                      return Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xf939090),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color(0xff000000))),
                                child: Text("Not product listed yet."),
                              ),
                            ),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: (){
                                // print('hello');
                                Get.offAll(() => MainScreen(initialIndex: 1,));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xff000000),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color(0xff000000))),
                                child: Text("Explore product Now",style: TextStyle(color: Color(0xffffffff)),),
                              ),
                            ),
                          ],
                        ),
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(color: Color(0xff000000),));
                    }
                  }
                  )
                ],
              ),
            ),
          )),
          Obx(
            ()=> Visibility(
              visible: controller.products.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  title: "Buy Now",
                  width: double.infinity,
                  bgColor: Color(0xff000000),
                  textColor: Color(0xffFFFFFF),
                  isSuffixBtn: true,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  suffixIcon: Obx(()=>
                    Text(controller.getProductTotal.value,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  )
                ),
              ),
            ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}


class UserCartController extends GetxController{
  var services = IsarService();
  RxList<ProductModel> products = RxList([]);
  RxString getProductTotal = "".obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  init()async{
    var isarData = await services.getCartData();
    if(isarData.isNotEmpty){
      products(isarData);
      double totalAmount = 0.0;
      for (var product in products) {
        double amount = await double.parse(product.price??'');
        double grandAmount = amount * product.count!.toDouble();
        totalAmount += grandAmount;
      }
      getProductTotal(totalAmount.toString());
      print(products.length);
    }
  }
}
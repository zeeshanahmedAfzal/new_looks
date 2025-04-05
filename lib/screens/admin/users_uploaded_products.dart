import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/constants/utiles.dart';
import 'package:new_looks/model/UserModel.dart';
import 'package:new_looks/screens/admin/product_model.dart';
import 'package:new_looks/screens/product_details/porduct_detail_screen.dart';
import 'package:new_looks/screens/result_screeen/result_screen.dart';

import 'admin_screen.dart';

class UsersUploadedProducts extends StatelessWidget {
  const UsersUploadedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(UserProductController());
    controller.getUserProduct();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Uploads",style: TextStyle(color: Color(0xffffffff)),),
        leadingWidth: 30,
        iconTheme: IconThemeData(color: Color(0xffffffff)),
        backgroundColor: Color(0xff000000),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Obx(
              () => Visibility(
                visible: controller.isLoading.isTrue,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            Obx(
              () => Visibility(
                  visible: controller.isLoading.isFalse,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.userProducts.length,
                        itemBuilder: (context, index) {
                          return UploadedProducts(
                              productModel: controller.userProducts[index]);
                        }),
                  )),
            ),
            Obx(() => Visibility(
                visible: controller.isLoading.isFalse &&
                    controller.userProducts.isEmpty,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xf939090),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xff000000))),
                        child: Text("Not product listed yet."),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          // print('hello');
                          Get.to(() => AdminScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                              color: Color(0xff000000),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Color(0xff000000))),
                          child: Text("Upload product",style: TextStyle(color: Color(0xffffffff)),),
                        ),
                      ),
                    ],
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}

class UploadedProducts extends StatelessWidget {
  const UploadedProducts({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(AdminController());
    var controller = Get.find<UserProductController>();
    return Column(
      children: [
        GestureDetector(
         onTap: (){
           Get.to(() => ProductDetailScreen(productId: productModel.productId,isOwner: true,));
         },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff000000)),
                          image: DecorationImage(
                              image: NetworkImage(productModel.image ?? ''))),
                    ),
                    Text(
                      productModel.productName ?? '',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(AlertDialog(
                      backgroundColor: Color(0xffffffff),
                      content: Text(
                        "Are you sure you want to delete this product?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      actions: [
                        GestureDetector(
                          onTap: () async {
                            Get.back();
                            await controller.deleteProduct(productModel.documentId??'');
                            await controller.getUserProduct();
                            // await controller.deleteImage(productModel.imagePublicId??'',productModel.imageAssetId??'');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xffffffff)),
                            ),
                          ),
                        )
                      ],
                    ));
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: Color(0xff000000),
        )
      ],
    );
  }
}



class UserProductController extends GetxController {
  RxList<ProductModel> userProducts =  (List<ProductModel>.of([])).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserProduct();
  }

  getUserProduct() async {
    // Fetch the seller details
    isLoading(true);
    print("start getting products");
    SellerModel sellerModel = await showSellerDetails();

    // Query Firestore for products matching the seller_id
    var sellerDoc = await FirebaseFirestore.instance
        .collection('Products')
        .where('seller_id', isEqualTo: sellerModel.sellerId)
        .get();

    // Map Firestore documents to ProductModel instances
    List<ProductModel> productList = sellerDoc.docs.map((doc) {
      isLoading(false);
      return ProductModel.fromMap(doc.data(), doc.id);
    }).toList();
    userProducts(productList);
    print(userProducts.length);
    isLoading(false);
  }

  deleteProduct(String documentId) async {
    isLoading(true);
    var data = await FirebaseFirestore.instance
        .collection('Products')
        .doc(documentId)
        .delete();
    isLoading(false);
  }
}

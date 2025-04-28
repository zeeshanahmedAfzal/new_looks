import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_looks/constants/utiles.dart';
import 'package:new_looks/model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/product_model.dart';
import '../cart/user_cart.dart';

class DashBoardController extends GetxController{

  RxList<ProductModel> featuredProducts = RxList([]);




  getStoredData() async {
    print("fetch from shared");
    UserModel userModel = await showUserDetails();
    SellerModel sellerModel = await showSellerDetails();
    print("user data : ${userModel.email}");
    print("seller data : $sellerModel");
  }

  @override
  void onInit() {
    getStoredData();
    getFeaturedProducts();
    super.onInit();
  }


  getFeaturedProducts() async {
    var featureDoc = await FirebaseFirestore.instance
        .collection('Products')
        .where('is_featured', isEqualTo: true)
        .get();

    List<ProductModel> productLists = featureDoc.docs.map((doc) {
      // isLoading(false);
      return ProductModel.fromMap(doc.data(), doc.id);
    }).toList();

    featuredProducts(productLists);
  }

}
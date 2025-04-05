import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/screens/search/widget/search_list.dart';

import '../admin/product_model.dart';

class SearchedController extends GetxController {
  RxList<SearchNameList> searchNameList = List<SearchNameList>.of([]).obs;
  RxList<ProductModel> allProducts = List<ProductModel>.of([]).obs;
  RxList<SearchNameList> searchList = [
    SearchNameList(name: "Jacket"),
    SearchNameList(name: "Shirt"),
    SearchNameList(name: "T-Shirt"),
    SearchNameList(name: "Pants"),
    SearchNameList(name: "Sweaters"),
    SearchNameList(name: "Dresses"),
    SearchNameList(name: "Jeans"),
    SearchNameList(name: "Plane T-Shirt"),
    SearchNameList(name: "Checks Shirt"),
    SearchNameList(name: "OverSize T-Shirt"),
  ].obs;

  TextEditingController searchText = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    getAllProducts();
  }

  getAllProducts() async {
    var allProduct = await FirebaseFirestore.instance
        .collection('Products')
        .get();

    List<ProductModel> productList = allProduct.docs.map((doc) {
      return ProductModel.fromMap(doc.data(), doc.id);
    }).toList();

    allProducts(productList);
  }


}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_looks/isar_services/services.dart';
import 'package:new_looks/screens/admin/product_model.dart';
import 'package:new_looks/screens/cart/user_cart.dart';
import '../../constants/colors.dart';
import '../../widgets/AssetImages.dart';
import '../../widgets/custom_button.dart';
import '../product_details/porduct_detail_screen.dart';
import 'back_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductListController(title.trim()));
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: BackWidget(
                        isTitleVisible: true,
                        title: title,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Found\n152 Results",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          height: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Color(0xff33302E).withOpacity(0.15))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Filter",
                                style: TextStyle(color: Color(0xff33302E)),
                              ),
                              Icon(Icons.arrow_drop_down_outlined, size: 22)
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    // Obx(()=>
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(() => Visibility(
                            visible: controller.isLoading.isFalse &&
                                controller.productList.isEmpty,
                            child: Center(
                              child: Container(
                                margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height *.3),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xf939090),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color(0xff000000))),
                                child: Text("Not $title is found"),
                              ),
                            ))),
                        Obx(() => Visibility(
                            visible: controller.isLoading.isTrue,
                            child: Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *.3),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ))),
                        Obx(() => Visibility(
                            visible: controller.productList.isNotEmpty,
                            child: ResultGrid(products: controller.productList))),
                      ],
                    )
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultGrid extends StatefulWidget {
  const ResultGrid({super.key, this.products, this.fromCart = false});
  final bool? fromCart;
  final List<ProductModel>? products;

  @override
  State<ResultGrid> createState() => _ResultGridState();
}

class _ResultGridState extends State<ResultGrid> {

  @override
  Widget build(BuildContext context) {
    // var cartController = Get.find<UserCartController>();
    var cartController = Get.put(UserCartController(),tag: "result");
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.products?.length ?? 10,
        padding: EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
            mainAxisExtent: widget.fromCart == true ? 280 : 255),
        itemBuilder: (context, index) {
          var obj = widget.products?[index];
          int productCount = obj?.count??0;
          return GestureDetector(
            onTap: () {
              Get.to(() => ProductDetailScreen(
                    productId: obj?.productId,
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xff000000).withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    child: obj?.image?.isNotEmpty == true
                        ? Image.network(
                            obj?.image ?? '',
                            fit: BoxFit.cover,
                            height: 185,
                            width: double.infinity,
                          )
                        : Image.asset(
                            AssetUtils.StartImage,
                            fit: BoxFit.cover,
                            height: 185,
                            width: double.infinity,
                          ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              obj?.productName ?? "Linen Dress",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1D1F22)),
                            ),
                            Visibility(
                              visible: widget.fromCart == true,
                              child: Text(
                                "${obj?.currency} ${obj?.price}" ?? "\$ 52.00 ",
                                style: TextStyle(
                                  color: Color(0xff1D1F22),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 2,
                        // ),
                        widget.fromCart == false ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${obj?.currency}${obj?.price} " ?? "\$ 52.00 ",
                              style: TextStyle(
                                color: Color(0xff1D1F22),
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${obj?.currency}${obj?.offerValue} " ??
                                  "\$ 92.00",
                              style: TextStyle(
                                color: Color(0xffBEBFC4),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            )
                          ],
                        )
                            :  Column(
                              children: [
                                SizedBox(height: 10,),
                                CustomButton(
                                  height: 40,
                                  radius: 5,
                                  bgColor: Color(0xff000000),
                                  title: "${productCount != 0 ? productCount : ""}",
                                  // title: "10",
                                  textColor: Color(0xffffffff),
                                  borderColor: Color(0xff000000),
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  defaultPadding: true,
                                  horizontalPadding: 40,
                                  icon: GestureDetector(
                                    onTap:() async {
                                      var cartData = obj;
                                      if (cartData != null) {
                                        cartData.count = (cartData.count ?? 0) - 1; // Increase count safely
                                        setState(() {
                                          productCount = cartData.count!;
                                        });
                                        if(productCount == 0){
                                          print(cartData.count);
                                          setState(() {
                                            widget.products?.removeAt(index);
                                          });
                                          IsarService().deleteProduct(obj?.productId??'');
                                        }else{
                                       await  IsarService().decreaseCount(obj?.productId ?? '');
                                       await cartController.init();
                                        }
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.remove,
                                        color: Color(0xffFFFFFF),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  icon2: GestureDetector(
                                    onTap:() async {
                                      var cartData = obj;
                                      print(cartData?.count);
                                      if (cartData != null) {
                                        cartData.count = (cartData.count ?? 0) + 1; // Increase count safely
                                        setState(() {
                                          productCount = cartData.count!;
                                        });
                                      await IsarService().increaseCount(obj?.productId ?? ''); // Update in database
                                      await cartController.init();
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.add,
                                        color: Color(0xffFFFFFF),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
  }
}

class ProductListController extends GetxController {
  ProductListController(this.selectedProduct);

  final String selectedProduct;
  RxList<ProductModel> productList =  (List<ProductModel>.of([])).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getAllProducts();
    super.onInit();
  }

  getAllProducts() async {
    isLoading(true);
    var productDoc = await FirebaseFirestore.instance
        .collection('Products')
        .where('category', isEqualTo: selectedProduct)
        .get();

    List<ProductModel> productLists = productDoc.docs.map((doc) {
      isLoading(false);
      return ProductModel.fromMap(doc.data(), doc.id);
    }).toList();

    productList(productLists);
    isLoading(false);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:new_looks/isar_services/services.dart';
import 'package:new_looks/model/UserModel.dart';
import 'package:new_looks/screens/admin/product_model.dart';
import 'package:new_looks/widgets/custom_button.dart';
import 'package:new_looks/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/utiles.dart';
import '../../mainScreen.dart';
import '../../widgets/AssetImages.dart';
import '../../widgets/address.dart';
import '../../widgets/custom_edit_textfield.dart';
import '../../widgets/sizeandcolor_widget.dart';
import '../result_screeen/back_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, this.productId, this.isOwner = false});

  final String? productId;
  final bool? isOwner;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProjectDetailController(productId));
    Widget startWidget() {
      return Stack(
        children: [
          Obx(
            () => Container(
              height: MediaQuery.of(context).size.height / 1.8,
              width: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: Color(0xff000000))),
              child: controller.productModel.value?.image?.isNotEmpty == true
                  ? Image.network(
                      controller.productModel.value?.image ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Image.asset(
                      AssetUtils.StartImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackWidget(
                  isTitleVisible: false,
                  backColor: Colors.white,
                ),
                Visibility(
                  visible: isOwner == true,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget bottomSheetWidget() {
      double getDescriptionHeight(String text) {
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          maxLines: null,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: Get.width - 32);

        return textPainter.height + 100; // Additional padding space
      }

      double screenHeight = Get.height; // GetX way to get screen height
      double descriptionHeight = getDescriptionHeight(
          controller.productModel.value?.description ?? "");

      double maxSize = (descriptionHeight / screenHeight)
          .clamp(0.5, 0.9); // Min 50%, Max 90%

      return DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: isOwner == true ? maxSize * 1.4 : maxSize * 1.2,
        //|| isExpandedReview
        expand: true,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 80,
                      child: Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (isOwner == true) {
                                Get.dialog(RenameDialog(
                                  title: 'Edit Name',
                                  initialText:
                                      controller.productName.value.isEmpty
                                          ? controller.productModel.value
                                                  ?.productName ??
                                              ''
                                          : controller.productName.value,
                                  onEdit: (value) {
                                    controller.productName(value);
                                    if (value.isEmpty) {
                                      controller.productName(controller
                                              .productModel
                                              .value
                                              ?.productName ??
                                          '');
                                    }
                                    controller.updatedData();
                                    print(value);
                                  },
                                ));
                              }
                            },
                            child: Obx(
                              () => Text(
                                controller.productName.value.isEmpty
                                    ? controller
                                            .productModel.value?.productName ??
                                        ''
                                    : controller.productName.value,
                                // controller.productName ??,
                                style: TextStyle(
                                  color: Color(0xff1D1F22),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isOwner == true) {
                                Get.dialog(RenameDialog(
                                  title: 'Edit Price',
                                  initialText:
                                      controller.productPrice.value.isEmpty
                                          ? controller.productModel.value?.price
                                          : controller.productPrice.value,
                                  onEdit: (value) {
                                    controller.productPrice(value);
                                    if (value.isEmpty) {
                                      controller.productPrice(controller
                                              .productModel.value?.price ??
                                          '');
                                    }
                                    controller.updatedData();
                                  },
                                ));
                              }
                            },
                            child: Obx(
                              () => Text(
                                "${controller.productModel.value?.currency} ${controller.productPrice.value.isEmpty ? controller.productModel.value?.price : controller.productPrice.value}" ??
                                    "\$" + " 80.00",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (isOwner == true) {
                                Get.dialog(RenameDialog(
                                  title: "Edit Size",
                                  widget: SizeSelectTextField(
                                    initialSize: controller.newSizes.isEmpty
                                        ? controller
                                                .productModel.value?.sizes ??
                                            []
                                        : controller.newSizes,
                                    onSizesChanged:
                                        controller.handleSizesChanged,
                                  ),
                                  onEdit: (String) {
                                    print(controller.newSizes);
                                    controller.updatedData();
                                  },
                                ));
                              }
                            },
                            child: Obx(
                              () => SelectedContainer(
                                title: 'Size',
                                count: 3,
                                list: controller.newSizes.isEmpty
                                    ? controller.productModel.value?.sizes ?? []
                                    : controller.newSizes,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8), // Optional spacing
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (isOwner == true) {
                                Get.dialog(RenameDialog(
                                  title: 'Edit Color',
                                  widget: MultiColorPickerTextField(
                                      initialColor: controller.newColor.isEmpty
                                          ? controller.getColorsFromHexList(
                                              controller
                                                  .productModel.value?.colors)
                                          : controller.getColorsFromHexList(
                                              controller.newColor),
                                      onColorsChanged:
                                          controller.handleColorsChanged),
                                  onEdit: (String) {
                                    print(controller.newColor);
                                    print(controller.newColor);
                                    controller.updatedData();
                                  },
                                ));
                              }
                            },
                            child: Obx(
                              () => SelectedContainer(
                                title: 'Color',
                                count: 3,
                                isColor: true,
                                list: controller.newColor.isEmpty
                                    ? controller.getColorsFromHexList(
                                        controller.productModel.value?.colors)
                                    : controller.getColorsFromHexList(
                                        controller.newColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10,),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isOwner == true,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Featured",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              Obx(
                                () => FlutterSwitch(
                                  height: 22,
                                  width: 40,
                                  activeColor: Color(0xff000000),
                                  value: controller.isProductFeature.value,
                                  onToggle: (bool value) async {
                                    controller.isProductFeature.value =
                                        !controller.isProductFeature.value;
                                    print(value);
                                    controller.isProductFeature(value);
                                    controller.updatedData();
                                    print(controller.isProductFeature);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("In Stock",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              Obx(
                                () => FlutterSwitch(
                                  height: 22,
                                  width: 40,
                                  activeColor: Color(0xff000000),
                                  value: controller.inStock.value,
                                  onToggle: (bool value) async {
                                    controller.inStock.value =
                                        !controller.inStock.value;
                                    controller.inStock(value);
                                    controller.updatedData();
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discription",
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                            Visibility(
                              visible: isOwner == true,
                              child: GestureDetector(
                                onTap: () {
                                  Get.dialog(RenameDialog(
                                    title: 'Edit Description',
                                    initialText: controller
                                            .productModel.value?.description ??
                                        '',
                                    onEdit: (value) {
                                      controller.productDescription(value);
                                      if (controller
                                          .productDescription.isEmpty) {
                                        controller.productDescription(controller
                                            .productModel.value?.description);
                                      }
                                      controller.updatedData();
                                    },
                                  ));
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() => Text(
                              controller.productDescription.value.isEmpty
                                  ? controller
                                          .productModel.value?.description ??
                                      ''
                                  : controller.productDescription.value,
                            ))
                      ],
                    ),
                    // Stack(
                    //   children: [
                    //     AnimatedContainer(
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(4),
                    //       ),
                    //       duration: Duration(milliseconds: 300),
                    //       curve: Curves.easeInOut,
                    //       width: double.infinity,
                    //       // height: isExpanded ? 200 : 50,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           GestureDetector(
                    //             onTap: () {
                    //               setState(() {
                    //                 isExpanded = !isExpanded;
                    //               });
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 color: Colors.transparent,
                    //               ),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //                 child: Column(
                    //                   children: [
                    //                     SizedBox(height: 12),
                    //                     Row(
                    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text(
                    //                           "Discription",
                    //                           style: TextStyle(
                    //                             color: Color(0xff000000),
                    //                             fontWeight: FontWeight.w600,
                    //                             fontSize: 16,
                    //                           ),
                    //                         ),
                    //                         Icon(
                    //                           isExpanded
                    //                               ? Icons.keyboard_arrow_down
                    //                               : Icons.keyboard_arrow_right,
                    //                           color: Colors.black,
                    //                         ),
                    //                       ],
                    //                     ),
                    //                     SizedBox(height: 12),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //           Visibility(
                    //               visible: isExpanded,
                    //               child: Container(
                    //                 height: 200,
                    //               )
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 10,),
                    // Divider(
                    //   thickness: 1,
                    //   color: Colors.grey,
                    // ),
                    // SizedBox(height: 10,),
                    // AnimatedContainer(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //   ),
                    //   duration: Duration(milliseconds: 300),
                    //   curve: Curves.easeInOut,
                    //   width: double.infinity,
                    //   // height: isExpanded ? 200 : 50,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             // isExpandedReview = !isExpandedReview;
                    //           });
                    //         },
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             color: Colors.transparent
                    //           ),
                    //           child: Padding(
                    //             padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //             child: Column(
                    //               children: [
                    //                 SizedBox(height: 12),
                    //                 Row(
                    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Text(
                    //                       "Reviews",
                    //                       style: TextStyle(
                    //                         color: Color(0xff000000),
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 16,
                    //                       ),
                    //                     ),
                    //                     Icon(
                    //                       isExpandedReview
                    //                           ? Icons.keyboard_arrow_down
                    //                           : Icons.keyboard_arrow_right,
                    //                       color: Colors.black,
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 SizedBox(height: 12),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Visibility(
                    //         visible: isExpandedReview,
                    //         child: Container(
                    //           height: 200,
                    //         )
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Obx(()=> Visibility(
                visible: controller.isLoading.isTrue,
                child: Center(child: CircularProgressIndicator(color: Color(0xff000000),))),
            ),
            Obx(()=>
               Visibility(
                visible: controller.isLoading.isFalse,
                child: Stack(
                  fit: StackFit.loose,
                  children: [
                    Column(
                      children: [
                        startWidget(),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: bottomSheetWidget(),
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            children: [
                              Visibility(
                                visible: isOwner == false,
                                child: Container(
                                  height: 80,
                                  color: Color(0xffFFFFFF),
                                  child: Stack(
                                    children: [
                                      Obx(()=>
                                         Visibility(
                                          visible: controller.isProductInCart.isTrue,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: CustomButton(
                                                      title: "View",
                                                    bgColor: Color(0xff000000),
                                                      textColor: Color(0xffffffff),
                                                      onTap: (){
                                                        Get.offAll(() => MainScreen(initialIndex: 2));
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Expanded(
                                                    child: CustomButton(
                                                      title: "${controller.cartProductData.value?.count != 0 ? controller.cartProductData.value?.count : ""}",
                                                      borderColor: Color(0xff000000),
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      defaultPadding: true,
                                                      horizontalPadding: 40,
                                                      icon: GestureDetector(
                                                        onTap:(){
                                                          var cartData = controller.cartProductData.value;
                                                          if (cartData != null) {
                                                            cartData.count = (cartData.count ?? 0) - 1; // Increase count safely
                                                            if(cartData.count == 0){
                                                              print(cartData.count);
                                                              controller.isProductInCart(false);
                                                              controller.service.deleteProduct(productId??'');
                                                            }else{
                                                              controller.cartProductData.refresh(); // Notify GetX
                                                              controller.service.decreaseCount(productId ?? '');
                                                            }
                                                          }
                                                        },
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Icon(Icons.remove,
                                                          color: Color(0xff000000),
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      icon2: GestureDetector(
                                                        onTap:(){
                                                          var cartData = controller.cartProductData.value;
                                                          print(cartData?.count);
                                                          if (cartData != null) {
                                                            cartData.count = (cartData.count ?? 0) + 1; // Increase count safely
                                                            controller.cartProductData.refresh(); // Notify GetX
                                                            controller.service.increaseCount(productId ?? ''); // Update in database
                                                          }
                                                        },
                                                        child: Align(
                                                          alignment: Alignment.centerRight,
                                                          child: Icon(Icons.add,
                                                            color: Color(0xff000000),
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                      Obx(()=>
                                        Visibility(
                                          visible: controller.isProductInCart.isFalse,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            child: CustomButton(
                                              title: "Add to cart",
                                            bgColor: Color(0xff000000),
                                              textColor: Color(0xffFFFFFF),
                                              onTap: () async {
                                                await controller.service.storeCartData(
                                                    controller.productModel.value,
                                                    1);
                                                var isarData = await controller.service.getCartData();
                                                for(var data in isarData){
                                                  if(data.productId == productId){
                                                    controller.isProductInCart(true);
                                                    controller.cartProductData(data);
                                                    print("count data : ${data.count}");
                                                  }
                                                }
                                              }
                                              // },
                                            ),
                                          )
                                          // Container(
                                          //   height: 80,
                                          //   decoration: BoxDecoration(
                                          //       color: Color(0xff000000),
                                          //       border: Border.all(color: Color(0xfffffff)),
                                          //       borderRadius: BorderRadius.only(
                                          //           topRight: Radius.circular(50),
                                          //           topLeft: Radius.circular(50))),
                                          //   child: Column(
                                          //     crossAxisAlignment: CrossAxisAlignment.center,
                                          //     mainAxisAlignment: MainAxisAlignment.center,
                                          //     children: [
                                          //       Center(
                                          //         child: Text(
                                          //           "Add to Cart",
                                          //           style: TextStyle(
                                          //               color: Color(0xffffffff),
                                          //               fontSize: 24,
                                          //               fontWeight: FontWeight.w600),
                                          //         ),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: isOwner == true,
                                  child: controller.isEdit.value == true
                                      ? Obx(
                                          () => Stack(
                                            children: [
                                              controller.isUpdating.value
                                                  ? CircularProgressIndicator(
                                                      color: Color(0xff000000),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () async {
                                                        await controller.updateProductData();
                                                      },
                                                      child: CustomButton(
                                                        height: 50,
                                                        title: "Update",
                                                        bgColor: Color(0xff000000),
                                                        textColor: Color(0xffffffff),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          height: 40,
                                          width: double.infinity,
                                          decoration:
                                              BoxDecoration(color: Color(0xff000000)),
                                          child: Text(
                                            'Tap on the element to edit',
                                            style: TextStyle(
                                                color: Color(0xffffffff), fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectDetailController extends GetxController {
  final String? productId;

  ProjectDetailController(this.productId);

  Rx<ProductModel?> productModel = Rx<ProductModel?>(null);
  RxBool isProductFeature = false.obs;
  IsarService service = IsarService();
  RxBool isEdit = false.obs;
  RxBool isInStock = false.obs;
  RxBool isLoading = false.obs;
  RxString productName = "".obs;
  RxString productPrice = "".obs;
  RxString productOfferValue = "".obs;
  RxString productDescription = "".obs;
  RxBool inStock = true.obs;
  RxBool isUpdating = false.obs;
  RxBool isProductInCart = false.obs;
  RxList<String> newSizes = (List<String>.of([])).obs;
  RxList<String> newColor = (List<String>.of([])).obs;
  Rx<ProductModel?> cartProductData = Rx<ProductModel?>(null);



  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() async {
    await getProductData();
    var isarData = await service.getCartData();
    for(var data in isarData){
      if(data.productId == productId){
        isProductInCart(true);
        cartProductData(data);
        print("count data : ${data.count}");
      }
    }
    // getColorsFromHexList(productModel.value?.colors);
    isProductFeature(productModel.value?.isFeatured);
    inStock(productModel.value?.isStock);
    print(inStock);
  }

  updatedData() {
    if (productName.isNotEmpty ||
        productPrice.isNotEmpty ||
        productDescription.isNotEmpty ||
        newColor.isNotEmpty ||
        newSizes.isNotEmpty ||
        inStock.value != productModel.value?.isStock ||
        isProductFeature.value != productModel.value?.isFeatured) {
      isEdit(true);
    } else {
      isEdit(false);
    }
  }

  handleSizesChanged(List<String> selectedSizes) {
    newSizes(selectedSizes);
    if (newSizes.isEmpty) {
      newSizes(productModel.value?.sizes);
    }
    print("Selected Colors: $selectedSizes");
  }

  handleColorsChanged(List<String> colors) async {
    newColor(colors);
    if (newColor.isEmpty) {
      newColor(productModel.value?.colors);
    }
    print("Selected Colors: $colors");
  }

  getProductData() async {
    isLoading(true);
    var product = await FirebaseFirestore.instance
        .collection('Products')
        .where('product_id', isEqualTo: productId)
        .get();
    if (product.docs.isNotEmpty) {
      var doc = product.docs.first; // Get the first document
      var productsDetails = ProductModel.fromMap(doc.data(), doc.id);
      productModel(productsDetails);
      print(productModel.value?.productId);
    }
    isLoading(false);
  }

  List<Color> getColorsFromHexList(List<String>? hexColors) {
    if (hexColors == null || hexColors.isEmpty) {
      print("Invalid input: Hex colors list is null or empty.");
      return [];
    }

    List<Color> colors = [];

    for (String hexColor in hexColors) {
      try {
        colors.add(getColorFromHex(hexColor));
      } catch (e) {
        print("Error parsing color: $hexColor. Error: $e");
      }
    }
    return colors;
  }

  updateProductData() async {
    isUpdating(true);
    var model = ProductModel(
      productName: productName.value,
      price: productPrice.value,
      currency: "",
      offerValue: productOfferValue.value,
      sizes: newSizes,
      colors: newColor,
      description: productDescription.value,
      isFeatured: isProductFeature.value,
      isStock: inStock.value,
    );

    await FirebaseFirestore.instance
        .collection('Products')
        .doc(productModel.value?.documentId)
        .update({
      'product_name':productName.value.isNotEmpty ? productName.value : productModel.value?.productName,
      'price':productPrice.value.isNotEmpty ? productPrice.value : productModel.value?.price,
      'offer_value':productOfferValue.value.isNotEmpty ? productOfferValue.value : productModel.value?.offerValue,
      'sizes': newSizes.isNotEmpty ? newSizes : productModel.value?.sizes,
      'colors': newColor.isNotEmpty ? newColor : productModel.value?.colors,
      'description': productDescription.value.isNotEmpty ? productDescription.value : productModel.value?.description,
      'is_featured': isProductFeature.value,
      'is_stock': inStock.value
    });

    isUpdating(false);

    isLoading(true);
    var updatedDoc = await FirebaseFirestore.instance
        .collection('Products')
        .where('product_id', isEqualTo: productModel.value?.productId)
        .get();

    if (updatedDoc.docs.isNotEmpty) {
      var data = ProductModel.fromMap(
          updatedDoc.docs.first.data(), updatedDoc.docs.first.id);
      productModel(data);
      isLoading(false);
      showSnackbar(message: "Successfully Updated");
    }
  }
}

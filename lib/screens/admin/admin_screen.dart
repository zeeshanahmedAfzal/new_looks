import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_looks/constants/utiles.dart';
import 'package:new_looks/model/UserModel.dart';
import 'package:new_looks/screens/admin/product_model.dart';
import 'package:new_looks/widgets/custom_button.dart';
import 'package:new_looks/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../../constants/colors.dart';
import 'package:crypto/crypto.dart';
import '../../widgets/custom_textfield.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminController());
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff000000),
        automaticallyImplyLeading: false,
        title: Text("Add Product",style: TextStyle(color: Color(0xffFFFFFF)),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Obx(()=>
                      GestureDetector(
                        onTap: (){
                          controller.pickImage();
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff000000)),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: controller.selectedImageFile.value != null ?
                              Image(image: FileImage(controller.selectedImageFile.value??File("")))
                              :Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Text("Upload\nImage")
                                ],
                              ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Upload your product image"),
                        GestureDetector(
                            onTap: (){
                              controller.removeImage();
                            },
                            child: Text("Remove image")),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text("Enter Product Details",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22
                    ),),
                    SizedBox(height: 10,),
                    AdminText(text: "Product Name"),
                    SizedBox(height: 10,),
                    CustomTextField(
                      labelText: "",
                      isLoginScreen: false,
                      controller: controller.productName,
                      isConstraintsApplied: false,
                      isError: true,
                      normalBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff000000)
                        )
                      ),
                      floatingLabelStyle: Color(0xff000000),
                      cursorColor: Color(0xff000000),
                      focusBorderColor: Color(0xff000000),
                    ),
                    SizedBox(height: 10,),
                    AdminText(text: "Price"),
                    SizedBox(height: 10,),
                    CustomTextField(
                      labelText: "",
                      isLoginScreen: false,
                      controller: controller.price,
                      isConstraintsApplied: false,
                      isError: true,
                      normalBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff000000)
                        )
                      ),
                      floatingLabelStyle: Color(0xff000000),
                      cursorColor: Color(0xff000000),
                      focusBorderColor: Color(0xff000000),
                    ),
                    SizedBox(height: 10,),
                    AdminText(text: "Currency"),
                    SizedBox(height: 10,),
                    CustomTextField(
                      labelText: "",
                      isLoginScreen: false,
                      controller: controller.currency,
                      isConstraintsApplied: false,
                      isError: true,
                      normalBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff000000)
                        )
                      ),
                      floatingLabelStyle: Color(0xff000000),
                      cursorColor: Color(0xff000000),
                      focusBorderColor: Color(0xff000000),
                    ),
                    SizedBox(height: 10,),
                    AdminText(text: "Offer Value"),
                    SizedBox(height: 10,),
                    CustomTextField(
                      labelText: "",
                      isLoginScreen: false,
                      controller: controller.offerValue,
                      isConstraintsApplied: false,
                      isError: true,
                      normalBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff000000)
                          )
                      ),
                      floatingLabelStyle: Color(0xff000000),
                      cursorColor: Color(0xff000000),
                      focusBorderColor: Color(0xff000000),
                    ),
                    SizedBox(height: 10,),
                    AdminText(text: "Description"),
                    SizedBox(height: 10,),
                    CustomTextField(
                      labelText: "",
                      isLoginScreen: false,
                      controller: controller.description,
                      isConstraintsApplied: false,
                      isError: true,
                      normalBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff000000)
                          )
                      ),
                      floatingLabelStyle: Color(0xff000000),
                      cursorColor: Color(0xff000000),
                      focusBorderColor: Color(0xff000000),
                    ),
                    SizedBox(height: 10,),
                    AdminText(text: "Category"),
                    SizedBox(height: 10,),
                    CategorySelectTextField(),
                    SizedBox(height: 10,),
                    AdminText(text: "Select Available Colors"),
                    SizedBox(height: 10,),
                    Obx(()=>
                       MultiColorPickerTextField(
                        isClear: controller.isClear.value,
                        onColorsChanged: controller.handleColorsChanged,
                      ),
                    ),
                    SizedBox(height: 10,),
                    AdminText(text: "Select Sizes Available"),
                    SizedBox(height: 10,),
                    Obx(()=>
                       SizeSelectTextField(
                        isClear: controller.isClear.value,
                        onSizesChanged: controller.handleSizesChanged,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Obx(()=>
                       CustomButton(
                          title: "Upload",
                          textColor: Color(0xffffffff),
                          bgColor: Color(0xC0000000),
                        isLoading: controller.isLoading.value,
                        onTap: () async {
                            await controller.uploadProductToFirebase();
                        },
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}


class AdminController extends GetxController{

  var imagePicker = ImagePicker();
  var selectedCategory = ''.obs;
  Rx<File?> selectedImageFile = Rx<File?>(null);
  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController currency = TextEditingController();
  TextEditingController offerValue = TextEditingController();
  final db = FirebaseFirestore.instance;
  RxList<String> colors =  (List<String>.of([])).obs;
  RxList<String> sizes = (List<String>.of([])).obs;
  RxList<String> categories =  (List<String>.of([])).obs;
  RxBool isClear = false.obs;
  TextEditingController description = TextEditingController();
  RxString firebaseImageUrl = "".obs;
  RxString firebaseImagePublicID = "".obs;
  RxString assetId = "".obs;
  var isLoading = false.obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  pickImage() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if(image != null ){
      File imageFile = File(image.path);
      selectedImageFile(imageFile);
    }
  }

  removeImage(){
    selectedImageFile.value = null;
  }

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  handleColorsChanged(List<String> selectedColors) {
    colors(selectedColors);
    print("Selected Colors: $selectedColors");
  }

  handleSizesChanged(List<String> selectedSizes) {
    sizes(selectedSizes);
    print("Selected Colors: $selectedSizes");
  }

  void fetchCategories() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2)); // Mock delay
    categories.value = ["Jacket", "Shirt", "T-Shirt", "Pants", "Sweaters","Dresses",
    "Jeans","Plane T-Shirt","Checks Shirt","OverSize T-Shirt"];
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }



  // Future<void> deleteImage(String publicId) async {
  //   const cloudName = 'dzczj4dnb';  // Your Cloudinary cloud name
  //
  //
  //   String timestamp = DateTime.now().toString();
  //
  //   final signature = generateSignature1(publicId: publicId, timestamp: timestamp, apiSecret: 'nomZvF_jsOSYbdGEtL7nKu');
  //
  //   final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/destroy');
  //
  //   final body = {
  //     'public_id': publicId,
  //     'api_key': '924184769494621',
  //     'timestamp': timestamp,
  //     'signature': signature,
  //   };
  //
  //   try {
  //     final response = await http.post(url, body: body);
  //
  //     if (response.statusCode == 200) {
  //       final responseBody = jsonDecode(response.body);
  //       if (responseBody['result'] == 'ok') {
  //         print('Image deleted successfully.');
  //       } else {
  //         print('Failed to delete image: ${responseBody['result']}');
  //       }
  //     } else {
  //       print('Delete request failed with status: ${response.statusCode}');
  //       print('Response: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error deleting image: $e');
  //   }
  // }

  Future<void> deleteImage(String publicId,String signature) async {
    print(publicId);
    const cloudName = 'dzczj4dnb'; // Your Cloudinary cloud name
    const apiSecret = "nomZvF_jsOSYbdGEtL7nKu"; // Your Cloudinary API secret
    const apiKey = "924184769494621"; // Your Cloudinary API key

    try {
      // Generate UNIX timestamp (seconds since epoch)
      final timestamp = (DateTime.now()).toString();



      // API endpoint
      final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/destroy');

      // Make the POST request
      final response = await http.post(
        url,
        body: {
          'api_key': apiKey,
          'timestamp': timestamp,
          'signature': signature,
          'public_id': publicId,
        },
      );

      // Handle the response
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        print('Image deleted: $responseBody');
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }



  upload() async {
    if (selectedImageFile.value == null) {
      print("No image selected for upload.");
      return;
    }

    try {
      print("Upload starting...");
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dzczj4dnb/upload');
      final request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = 'dhbwCUINOL'
        ..fields['public_id'] = selectedCategory.value
        ..files.add(await http.MultipartFile.fromPath(
          'file',
          selectedImageFile.value!.path,
        ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final json = jsonDecode(responseString);
        final imageUrl = json['url'];
        final publicId = json['public_id'];
        final assetIds = json['asset_id'];
        print("Image URL is: $imageUrl");
        print("public Id is: $publicId");
        print("Signature is: $assetIds");
        print(json);
        firebaseImageUrl(imageUrl);
        firebaseImagePublicID(publicId);
        assetId(assetIds);
      } else {
        print("Upload failed with status: ${response.statusCode}");
        final errorData = await response.stream.toBytes();
        print("Error response: ${String.fromCharCodes(errorData)}");
      }
    } catch (e) {
      print("Error during upload: $e");
    }
  }



  String generateSignature1({
    required String publicId,
    required String timestamp,
    required String apiSecret,
  }) {
    // Prepare the string to sign
    final String stringToSign = "public_id=$publicId&timestamp=$timestamp";

    // Append the API secret and generate the SHA1 hash
    final payload = "$stringToSign$apiSecret";
    final signature = sha1.convert(utf8.encode(payload)).toString();

    return signature;
  }


  // getGeneratedSignature(String publicId){
  //   Map<String, dynamic> requestData = {
  //     "public_ids[0]": publicId,
  //     "api_key": "924184769494621",
  //     "resource_type": "image",
  //   };
  //
  //   // API Secret from your Cloudinary account
  //   const apiSecret = "nomZvF_jsOSYbdGEtL7nKu";
  //
  //   // Generate the signature
  //   final signature = generateSignature(
  //     requestData: requestData,
  //     apiSecret: apiSecret,
  //   );
  //
  //   print("Signature: $signature");
  //   return signature;
  // }

  uploadProductToFirebase() async {
    isLoading(true);
    // if(formKey.currentState?.validate() == true){
      await upload();
      if(firebaseImageUrl.isNotEmpty){
        SellerModel sellerModel = await showSellerDetails();
        var productId = const Uuid().v4();
        var model = ProductModel(
            productId: productId,
            sellerId: sellerModel.sellerId,
            image: firebaseImageUrl.value,
            productName: productName.value.text,
            price: price.value.text,
            category: selectedCategory.value,
            currency: currency.value.text,
            offerValue: offerValue.value.text,
            sizes: sizes,
            colors: colors,
            isFeatured: false,
            description: description.value.text,
            isStock: true,
            imageAssetId: assetId.value,
            imagePublicId: firebaseImagePublicID.value
        );
        await db.collection("Products").add(model.toJson()).then((doc) async {
          isLoading(false);
          selectedCategory.value = "";
          selectedImageFile.value = null;
          productName.text = "";
          price.text = "";
          currency.text = "";
          offerValue.text = "";
          colors.clear();
          isClear.value = true;
          sizes.clear();
          description.text = "";
          firebaseImageUrl.value = "";
          firebaseImagePublicID.value = "";
          assetId.value = '';
          // Get.back();
          showSnackbar(message: "Project Uploaded Successfully");
        }).catchError((error, stackTrace) {
          print("Error adding user: $error");
        });
      }
    // }else{
    //   showSnackbar(message: 'All fields are required');
    //   isLoading(false);
    // }
    // isLoading(false);
  }
}


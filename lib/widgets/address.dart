
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/utiles.dart';
import '../model/UserModel.dart';
import 'custom_button.dart';
import 'custom_textfield.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AddressController());
    return Center(
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xff000000))
            ),
            child: Material(
              color: Color(0xffffffff),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Address",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                  ),),
                  SizedBox(height: 10,),
                  CustomTextField(
                    maxLine: 5,
                    textInputType: TextInputType.multiline,
                    focusBorderColor: Color(0xff000000),
                    cursorColor: Color(0xff000000),
                    isConstraintsApplied: false,
                    controller: controller.addressController,
                    borderColor:Color(0XFF000000),
                  ),
                  Obx(()=>
                      Visibility(
                          visible: controller.isEmpty.value,
                          child: Text("Please enter your address",
                            style: TextStyle(
                                color: Colors.red
                            ),
                          )),
                  ),
                  SizedBox(height: 10,),
                  CustomButton(
                    title: "Add",
                    height: 40,
                    onTap: (){
                      if(controller.addressController.text.isNotEmpty){
                        controller.isEmpty(false);
                        controller.addAddressToFirebase();
                      }else{
                        controller.isEmpty(true);
                      }
                    },
                    bgColor: Color(0xff000000),
                    textColor: Color(0xffffffff),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AddressController extends GetxController{


  var addressController = TextEditingController();
  final db = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var isEmpty = false.obs;


  addAddressToFirebase() async {
    try {
      // Fetch the user details
      UserModel userModel = await showUserDetails();
      if (userModel.email.isNotEmpty) {
        // Retrieve the existing user document
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userModel.documentId)
            .get();

        // Get the existing addresses list or initialize it as an empty list
        List<String> existingAddresses = [];
        if (userDoc.exists && userDoc.data()?['addresses'] != null) {
          existingAddresses = List<String>.from(userDoc.data()?['addresses']);
        }

        // Add the new address to the list
        existingAddresses.add(addressController.text.trim());

        // Update the Firestore document with the updated list
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userModel.documentId)
            .update({
          "addresses": existingAddresses,
        });

        var updatedDoc  = await FirebaseFirestore.instance
            .collection('Users')
            .where('id', isEqualTo: userModel.id)
            .get();

        // Store the updated data locally
        await storedObject(
          jsonObject: updatedDoc.docs.first.data(), // Updated user data as JSON
          key: 'userData',              // Local storage key
          docId: userModel.documentId??"",  // Firestore document ID
          docIdKey: 'userDocId',        // Local storage document ID key
        );

        showSnackbar(message: "Address added successfully");
      } else {
        // If the document doesn't exist, handle the case
        showSnackbar(message: "User document not found.");
      }

      isLoading(false);
    } catch (error) {
      isLoading(false);
      print("Error adding address: $error");
      showSnackbar(message: "Failed to add address");
    }
  }
}
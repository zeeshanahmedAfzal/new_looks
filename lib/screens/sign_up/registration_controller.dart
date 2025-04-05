import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_looks/model/UserModel.dart';
import 'package:new_looks/screens/DashBoard/dashborad.dart';
import 'package:new_looks/screens/login/login_scrren.dart';
import 'package:uuid/uuid.dart';

import '../../constants/utiles.dart';
import '../../mainScreen.dart';
import 'otp_verfication_screen.dart';

class RegistrationController extends GetxController {
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString email = "".obs;
  final db = FirebaseFirestore.instance;
  RxString password = "".obs;
  RxString businessName = "".obs;
  RxString contactNumber = "".obs;
  RxBool isLoading = false.obs;

  RxString emailError = "".obs;
  RxString firstNameError = "".obs;
  RxString lastNameError = "".obs;
  RxString passwordError = "".obs;
  RxString businessNameError = "".obs;
  RxString contactNumberError = "".obs;


  RxBool enableButton = false.obs;
  validation(txt) {
    RegExp regExp = new RegExp(Constant.EMAIL_REGEX);
    if (email.value.length == 0) {
      emailError('Please enter email');
    } else if (!regExp.hasMatch(email.value)) {
      emailError('Please enter valid email');
    } else {
      emailError('');
    }
  }

  void validateEmail({bool? isBusiness}) {
    bool isValid = true;
    RegExp regExp = RegExp(Constant.EMAIL_REGEX);
    RegExp regExp1 = RegExp(Constant.PASS_REGEX1);

    if (email.value.length == 0) {
      emailError('Please enter email');
      isValid = false;
    } else if (!regExp.hasMatch(email.value)) {
      emailError('Please enter valid email');
      isValid = false;
    } else {
      emailError('');
    }

    if (password.value.length == 0) {
      passwordError('Please enter password');
      isValid = false;
    } else if (!regExp1.hasMatch(password.value)) {
      passwordError('Please enter valid password');
      isValid = false;
    } else {
      passwordError('');
    }

    if (firstName.trim().length == 0) {
      firstNameError('Please enter first name');
      isValid = false;
    } else {
      firstNameError('');
    }

    if (lastName.trim().length == 0) {
      lastNameError("Please enter last name");
      isValid = false;
    }
    else {
      lastNameError('');
    }

    if(isBusiness == true){
      if (businessName.trim().length == 0) {
        businessNameError("Please enter business name");
        isValid = false;
      }
      else {
        businessNameError('');
      }
      if (contactNumber.trim().length == 0) {
        contactNumberError("Please enter contact number");
        isValid = false;
      }
      else {
        contactNumberError('');
      }

    }

    enableButton(isValid);
    print("button val : ${enableButton.value}");
  }



  register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    bool? isSeller,
    String? contactNumber,
    String? businessName,
  }) async {
    isLoading(true);
    if (enableButton.value == true) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("User created: ${userCredential.user?.uid}");

        await saveOrUpdateUser(
          id: userCredential.user?.uid ?? '',
          firstName: firstName,
          lastName: lastName,
          email: email,
          isSeller: isSeller,
          contactNumber: contactNumber,
          businessName: businessName,
        );

        Get.offAll(() => MainScreen());

        showSnackbar(message: "Registered Successfully");
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          showSnackbar(message: "Password Provided is too weak");
        } else if (e.code == "email-already-in-use") {
          print("code : ${e.code}");
          showSnackbar(message: "Email Already Exists");
        }
        print("FirebaseAuthException: ${e.message}");
      } catch (e) {
        print("Unexpected error: $e");
      } finally {
        isLoading(false);
      }
    }
  }






    saveOrUpdateUser({required String firstName,required String lastName,
      required String email, required String id,String? businessName,String? contactNumber,
      bool? isSeller
    }) async {

      final sellerId = const Uuid().v4();

     var model = UserModel(
         id: id,
         email: email,
         firstName: firstName,
         lastName: lastName,
         isSeller: isSeller,
       sellerId: isSeller == true ? sellerId : null,
     );

      var seller = SellerModel(
          sellerId: sellerId,
          sellerEmail: email,
          businessName: businessName??'',
          contactNumber: contactNumber??'');


      await saveUserData(model,seller,isSeller: isSeller);
    }


    saveUserData(UserModel user,SellerModel seller,{bool? isSeller}) async {
      // Adding and storing user data
      await db.collection("Users").add(user.toJson()).then((doc) async {
        await storedObject(
          jsonObject: user.toJson(),
          key: 'userData',
          docId: doc.id,
          docIdKey: 'userDocId',
        );
      }).catchError((error, stackTrace) {
        print("Error adding user: $error");
      });

  // Adding and storing seller data
      if (isSeller == true) {
        var sellerData = await db.collection("Sellers").add(seller.toJson()).then((doc) async {
          await storedObject(
            jsonObject: seller.toJson(),
            key: 'sellerData',
            docId: doc.id,
            docIdKey: 'sellerDocId',
          );
        }).catchError((error, stackTrace) {
          print("Error adding seller: $error");
        });
      }

    }


  registeringAsSeller({required String email,
    required String password,
    required String firstName,
    required String lastName,
    bool? isSeller,
    required LoginController controller,
    String? contactNumber,
    String? businessName,}) async {
    var userListFromFirebase = await FirebaseFirestore.instance
        .collection('Users')
        .get();


    if (userListFromFirebase.docs.isNotEmpty) {
      // Map each document to a UserModel
      List<UserModel> userList = userListFromFirebase.docs
          .map((doc) => UserModel.fromMap(doc.data(),doc.id))
          .toList();

      // Print user details
      for (var user in userList) {
        if(user.email == email && user.isSeller == false){
          try{
            var sellerId = const Uuid().v4();

            var data = await FirebaseFirestore.instance
                .collection('Users')
                .doc(user.documentId)
                .update({
              'is_seller': true,
              'seller_id': sellerId,
            });


            UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email, password: password);


            controller.fetchUserData(userCredential.user?.uid??'');

            var seller = SellerModel(
                sellerId: sellerId,
                sellerEmail: email,
                businessName: businessName??'',
                contactNumber: contactNumber??'');
            var saveData =  await db.collection("Sellers").add(seller.toJson()).catchError((error,stackTrace){
              print("error is : $error");
            });


            if(saveData.id.isNotEmpty){
              Get.offAll(() => MainScreen());
            }
          }on FirebaseAuthException catch (e){
            if (e.code == 'wrong-password') {
          print('Please Provide right password to upgrade to your existing account to seller account');
        }else if(e.code == 'invalid-credential'){
              showSnackbar(message: 'Please Provide proper credential to upgrade to your existing account to seller account');
             print('Please Provide proper credential to upgrade to your existing account to seller account');
            }
          }
        }
        else if(user.email == email && user.isSeller == true){
          showSnackbar(message: 'Email already exists as a seller');
        } else{
          print("email not exist");
          await register(
              email: email,
              password: password,
              firstName: firstName,
              lastName: lastName,
              businessName: businessName,
              contactNumber: contactNumber,
              isSeller: true
          );
        }
      }
    }
  }


}

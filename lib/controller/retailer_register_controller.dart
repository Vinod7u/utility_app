import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utility_app_flutter/utils/utils.dart';

import '../screens/home/usersection/user_home_page.dart';
import '../utils/Constants/api_url.dart';
import '../utils/appServices/apiservices.dart';
import '../widgets/snackbar.dart';

class RetailerRegisterController extends GetxController{
  final  nameC = TextEditingController();
  final  phoneC = TextEditingController();
  final  emailC = TextEditingController();
  final  shopNameC = TextEditingController();
  final  mPinC = TextEditingController();
  final  passC = TextEditingController();
  final  confirmPassC = TextEditingController();
  final  otpC = TextEditingController();

  final  pinCodeC = TextEditingController();
  final  addressC = TextEditingController();
  final  stateC = TextEditingController();
  final  districtC = TextEditingController();
  final  aadhaarController = TextEditingController();
  final  panController = TextEditingController();
  final  bankAccountController = TextEditingController();
  final  ifscController = TextEditingController();
  final  nomineeController = TextEditingController();
  final  fileC = TextEditingController();
  final  mFilesC = TextEditingController();

  var token = ''.obs;

  var aadhaarFile = Rx<File?>(null);
  var shopPhotoFile = Rx<File?>(null);
  var ownerPhotoFile = Rx<File?>(null);
  var addressProofFile = Rx<File?>(null);
  var panFile = Rx<File?>(null);
  var bankFile = Rx<File?>(null);
  var selfieFile = Rx<File?>(null);
  var selectedValue = 'Select Type'.obs;
  var selectedShop = 'Normal'.obs;
  var isAadhaarVerify = false.obs;
  var isSendOtp = false.obs;

  final List<String> items = [
    'CSc',
    'General Store',
    'Mobile Shop',
    'Cyber Cafe',
    'Other',
  ];

  // Terms & location
  var acceptedTerms = false.obs;
  var position = Rx<Position?>(null);

  final picker = ImagePicker();
  RxBool isLoading = false.obs;


  Future<void> pickFile(Rx<File?> target) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      target.value = File(picked.path);
    }
  }

  Future<void> captureSelfie() async {
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      selfieFile.value = File(picked.path);
    }
  }

  Future<void> getLocation() async {
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position.value = pos;
  }

  void toggleTerms(bool? val) {
    acceptedTerms.value = val ?? false;
  }

  void submitForm() {
    if (!acceptedTerms.value) {
      Get.snackbar("Error", "You must accept Terms & Conditions");
      return;
    }

    Get.snackbar("Success", "Form submitted successfully");
  }

  Future<void> createRetailerApi() async {
    final mobileNo = phoneC.text;
    final name = nameC.text;
    final email = emailC.text;
    final mpin = mPinC.text;
    final password = passC.text;
    final confirmPassword = confirmPassC.text;
    //final postOfficeName = phoneC.text;
    //final businessName = phoneC.text;
    //final businessType = phoneC.text;
    final role = phoneC.text;
    final pinCode = pinCodeC.text;
    final fullAddress = addressC.text;
    //final country = .text;
    final state = stateC.text;
    final city = districtC.text;
    final shopName = shopNameC.text;
    //final block = pinCodeC.text;
    try {
      isLoading.value = true;
      final data = {
        "mobileNumber": mobileNo,
        "email": email,
        "name": name,
        "mpin": mpin,
        "password": password,
        "confirmPassword": confirmPassword,
        "pinCode": pinCode,
        "shopPhoto": [],
        "ownerPhoto": "",
        //"postOfficeName": '',
        //"businessName": '',
        //"businessType": mobileNumber,
        "role": "Retailer",
        "address":{
          "fullAddress": fullAddress,
          "country": "India",
          "state": state,
          "city": city,
          "block": 'E',
        },
        "shopName": shopName,
        "shopType": "CSc",
        "references": [],
        "educationQualification": "",
        "financialExperience": "",
        "directorKycFiles": [],
      };
      // prepare files
      List<File> files = [];
      if (shopPhotoFile.value != null) {
        files.add(shopPhotoFile.value!);
      }
      if (ownerPhotoFile.value != null) {
        files.add(ownerPhotoFile.value!);
      }
      if (addressProofFile.value != null) {
        files.add(addressProofFile.value!);
      }
      log('All Parameters : ${data}');
      log('All files : ${files}');
      final response = await Apiservices().uploadMultipleFiles(
        ApiUrl.createCandidate,
        data: data,
        files: files,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        final token = response.data["token"];
        print('My Token Generated : ${token}');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        // token = prefs.getString('token');
        print("Response : ${response.data}");
        showSnackBar(title: "Success", message: response.data["message"]);
      } else {
        isLoading.value = false;
        showSnackBar(title: "Failed", message: response.data["message"]);
      }
    } catch (e) {
      isLoading.value = false;
      showSnackBar(title: "Failed", message: e.toString());
    }
  }


  Future<void> sendAadhaarOtpApi() async {
    final aadhaar = aadhaarController.text;
    try {
      isLoading.value = true;
      final data = {"aadharNumber": aadhaar};
      final response = await Apiservices().postRequest(
        ApiUrl.verifyAadhaarOtp,
        data: data,
      );
      print('${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        if(response.data["message"] != "Invalid Aadhaar Number."){
          isAadhaarVerify.value = true;
        }
        isLoading.value = false;

        showSnackBar(title: "Success", message: response.data["message"]);

      } else {
        isLoading.value = false;

        showSnackBar(title: "Failed", message: response.data["message"]);
      }
    } catch (e) {
      isLoading.value = false;

      showSnackBar(title: "Failed", message: e.toString());
    }
  }
}
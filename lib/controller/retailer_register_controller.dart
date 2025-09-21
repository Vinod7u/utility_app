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
  RxBool isLoadingOtp = false.obs;
  RxBool isLoadingVerifyOtp = false.obs;


  RxBool isShowButton = false.obs;
  RxBool isShowButtonPan = false.obs;

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
        log("${response.data}");
        log("${response.statusCode}");
        final token = response.data["token"];
        final userId = response.data["newUser"]["_id"];
        print('My Token Generated : ${token}');
        print('My UserId : ${userId}');
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('userId', userId);

        print("User id Set : ${userId}");
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
      isLoadingOtp.value = true;
      final data = {"aadharNumber": aadhaar};
      final response = await Apiservices().postRequest(
        ApiUrl.verifyAadhaarOtp,
        data: data,
      );
      print('${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Api Response : ${response.data}");
        print("Api Response 2 : ${response.data}");
        print("Api Response 3 : ${response.data["data"]["data"]["data"]["client_id"]}");
        final clientID = response.data["data"]["data"]["data"]["client_id"];
        print("client Id : ${clientID}");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('client_id', clientID);
        print("client_id : ${clientID}");
        if(response.data["message"] != "Invalid Aadhaar Number."){
          isAadhaarVerify.value = true;
        }
        isLoadingOtp.value = false;

        showSnackBar(title: "Success", message: response.data["message"]);

      } else {
        isLoadingOtp.value = false;

        showSnackBar(title: "Failed", message: response.data["message"]);
      }
    } catch (e) {
      isLoadingOtp.value = false;

      showSnackBar(title: "Failed", message: e.toString());
    }
  }

  Future<void> verifyAadhaarOtpApi() async {
    final aadhaarNo = aadhaarController.text;
    final otpText = otpC.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final clientId = prefs.getString('client_id');
    final userId = prefs.getString('_id');
    try {
      isLoadingVerifyOtp.value = true;
      final data = {
        "aadharNumber": aadhaarNo,
        "otp": otpText,
        "client_id": clientId,
        "userId": userId,
      };
      final response = await Apiservices().postRequest(
        ApiUrl.submitAadhaarOtp,
        data: data,
      );
      print('${clientId}');
      print('${userId}');
      print('${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoadingVerifyOtp.value = false;

        showSnackBar(title: "Success", message: response.data["message"]);

      } else {
        isLoadingVerifyOtp.value = false;

        showSnackBar(title: "Failed", message: response.data["message"]);
      }
    } catch (e) {
      isLoadingVerifyOtp.value = false;

      showSnackBar(title: "Failed", message: e.toString());
    }
  }

  Future<void> verifyPanOtpApi() async {
    final panNo = panController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final clientId = prefs.getString('client_id');
    final userId = prefs.getString('_id');
    try {
      isLoading.value = true;
      final data = {
        "id_number": panNo,
        "userId": userId,
      };
      final response = await Apiservices().postRequest(
        ApiUrl.verifyPanOtp,
        data: data,
      );
      print('Client ID ${clientId}');
      print('User ID ${userId}');
      print('DATA : ${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        isShowButtonPan.value = true;
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


  Future<void> verifyBankApi() async {
    final bankAccNo = bankAccountController.text;
    final ifsc = ifscController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final clientId = prefs.getString('client_id');
    final userId = prefs.getString('_id');
    try {
      isLoading.value = true;
      final data = {
        "id_number": bankAccNo,
        "ifsc": ifsc,
        "userId": userId,
      };
      final response = await Apiservices().postRequest(
        ApiUrl.verifyBank,
        data: data,
      );
      print('Client ID ${clientId}');
      print('User ID ${userId}');
      print('DATA : ${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final name = response.data["pandata"]["data"]["data"]["account_name"];
        final accountNo = response.data["pandata"]["data"]["data"]["account_number"];
        final ifsc = response.data["pandata"]["data"]["data"]["ifsc"];
        prefs.setString('account_name',name);
        prefs.setString('account_number',accountNo);
        prefs.setString('ifsc',ifsc);

        isLoading.value = false;
        isShowButtonPan.value = true;
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

  Future<void> submitKYCApi() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final clientId = prefs.getString('client_id');
    final userId = prefs.getString('_id');
    try {
      isLoading.value = true;
      final data = {
        "userId": userId,
      };
      final response = await Apiservices().postRequest(
        ApiUrl.verifyBank,
        data: data,
      );
      print('Client ID ${clientId}');
      print('User ID ${userId}');
      print('DATA : ${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        isShowButtonPan.value = true;
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
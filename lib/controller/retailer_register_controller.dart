import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RetailerRegisterController extends GetxController{
  final  nameC = TextEditingController();
  final  phoneC = TextEditingController();
  final  emailC = TextEditingController();
  final  shopNameC = TextEditingController();
  final  mPinC = TextEditingController();
  final  passC = TextEditingController();
  final  confirmPassC = TextEditingController();

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

  var aadhaarFile = Rx<File?>(null);
  var shopPhotoFile = Rx<File?>(null);
  var ownerPhotoFile = Rx<File?>(null);
  var addressProofFile = Rx<File?>(null);
  var panFile = Rx<File?>(null);
  var bankFile = Rx<File?>(null);
  var selfieFile = Rx<File?>(null);
  var selectedValue = 'Select Type'.obs;
  var selectedShop = 'Normal'.obs;
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

  /*Future<void> createRetailerApi(String mobileNumber) async {
    try {
      isLoading.value = true;
      final data = {"mobileNumber": mobileNumber};
      final response = await Apiservices().postRequest(
        ApiUrl.sendOtp,
        data: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;

        showSnackBar(title: "Success", message: response.data["message"]);
        Get.to(() => OtpVerifyScreen(), arguments: {
          "mobile" : mobileNumber
        });
      } else {
        isLoading.value = false;

        showSnackBar(title: "Failed", message: response.data["message"]);
      }
    } catch (e) {
      isLoading.value = false;

      showSnackBar(title: "Failed", message: e.toString());
    }
  }*/
}
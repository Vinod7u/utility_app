import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utility_app_flutter/utils/Constants/api_url.dart';
import 'package:utility_app_flutter/utils/appServices/apiservices.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class UserRegisterController extends GetxController {
  // 🔹 Form Controllers
  final fullNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final mpinController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final aadharOtpController = TextEditingController();

  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodeController = TextEditingController();
  final fullAddressController = TextEditingController();

  final aadhaarController = TextEditingController();
  final panController = TextEditingController();

  final bankAccountController = TextEditingController();
  final ifscController = TextEditingController();

  // 🔹 File Pickers
  var aadhaarFrontFile = Rx<File?>(null);
  var aadhaarBackFile = Rx<File?>(null);
  var panFile = Rx<File?>(null);
  var bankProofFile = Rx<File?>(null);
  var selfieFile = Rx<File?>(null);

  // 🔹 States
  RxBool isLoading = false.obs;
  RxBool isOtpSending = false.obs;
  RxBool isOtpVerifying = false.obs;

  var acceptedTerms = false.obs;
  var currentPosition = Rx<Position?>(null);

  final picker = ImagePicker();

  // ---------------------- File & Camera ---------------------- //

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

  // ---------------------- Location ---------------------- //
  Future<void> getCurrentLocation() async {
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPosition.value = pos;
  }

  void toggleTerms(bool? val) {
    acceptedTerms.value = val ?? false;
  }

  // ---------------------- API Calls ---------------------- //

  /// 🔹 Register User API
  Future<void> registerUserApi(int index) async {
    try {
      isLoading.value = true;

      final data = {
        "mobileNumber": mobileController.text.trim(),
        "email": emailController.text.trim(),
        "name": fullNameController.text.trim(),
        "mpin": mpinController.text.trim(),
        "password": passwordController.text.trim(),
        "confirmPassword": confirmPasswordController.text.trim(),
        "pinCode": pincodeController.text.trim(),
        "role": "User",
        "address": {
          "fullAddress": fullAddressController.text.trim(),
          "country": countryController.text.trim(),
          "state": stateController.text.trim(),
          "city": districtController.text.trim(),
          "block": "E",
        },
        "shopType": "CSC",
        "references": [],
        "educationQualification": "",
        "financialExperience": "",
        "directorKycFiles": [],
      };

      // Prepare files
      List<File> files = [];
      if (selfieFile.value != null) files.add(selfieFile.value!);
      if (bankProofFile.value != null) files.add(bankProofFile.value!);
      if (aadhaarFrontFile.value != null) files.add(aadhaarFrontFile.value!);
      if (aadhaarBackFile.value != null) files.add(aadhaarBackFile.value!);
      if (panFile.value != null) files.add(panFile.value!);

      log('Request Data: $data');
      log('Files: $files');

      final response = await Apiservices().uploadMultipleFiles(
        ApiUrl.createCandidate,
        data: data,
        files: files,
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data["token"];
        final userId = response.data["newUser"]["_id"];

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('userId', userId);
        index++;

        showSnackBar(title: "Success", message: response.data["message"]);
      } else {
        showSnackBar(title: "Failed", message: response.data["message"]);
      }
    } catch (e) {
      isLoading.value = false;
      showSnackBar(title: "Failed", message: e.toString());
    }
  }

  /// 🔹 Send Aadhaar OTP
  Future<void> sendAadhaarOtp() async {
    try {
      isOtpSending.value = true;
      final data = {"aadharNumber": aadhaarController.text.trim()};

      final response = await Apiservices().postRequest(
        ApiUrl.verifyAadhaarOtp,
        data: data,
      );

      isOtpSending.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final clientID =
            response.data["data"]["data"]["data"]["client_id"] ?? "";

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('client_id', clientID);

        showSnackBar(
          title: "Success",
          message: response.data["data"]["message"],
        );
      } else {
        showSnackBar(
          title: "Failed",
          message: response.data["data"]["message"],
        );
      }
    } catch (e) {
      isOtpSending.value = false;
      showSnackBar(title: "Failed", message: e.toString());
    }
  }

  /// 🔹 Verify Aadhaar OTP
  Future<void> verifyAadhaarOtp() async {
    try {
      isOtpVerifying.value = true;

      final prefs = await SharedPreferences.getInstance();
      final clientId = prefs.getString('client_id');
      final userId = prefs.getString('userId');

      final data = {
        "aadharNumber": aadhaarController.text.trim(),
        "otp": aadharOtpController.text.trim(),
        "client_id": clientId,
        "userId": userId,
      };

      final response = await Apiservices().postRequest(
        ApiUrl.submitAadhaarOtp,
        data: data,
      );

      isOtpVerifying.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar(title: "Success", message: response.data["message"]);
      } else {
        showSnackBar(title: "Failed", message: response.data["message"]);
      }
    } catch (e) {
      isOtpVerifying.value = false;
      showSnackBar(title: "Failed", message: e.toString());
    }
  }

  /// 🔹 Verify PAN
  Future<void> verifyPan() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      final data = {"id_number": panController.text.trim(), "userId": userId};

      final response = await Apiservices().postRequest(
        ApiUrl.verifyPanOtp,
        data: data,
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        showSnackBar(title: "Success", message: response.data["message"]);
      } else {
        showSnackBar(title: "Failed", message: response.data["message"]);
      }
    } catch (e) {
      isLoading.value = false;
      showSnackBar(title: "Failed", message: e.toString());
    }
  }

  /// 🔹 Verify Bank Account
  Future<void> verifyBankAccount() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');

      final data = {
        "id_number": bankAccountController.text.trim(),
        "ifsc": ifscController.text.trim(),
        "userId": userId,
      };

      final response = await Apiservices().postRequest(
        ApiUrl.verifyBank,
        data: data,
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final bankData = response.data["pandata"]["data"]["data"];
        prefs.setString('account_name', bankData["account_name"]);
        prefs.setString('account_number', bankData["account_number"]);
        prefs.setString('ifsc', bankData["ifsc"]);

        showSnackBar(title: "Success", message: response.data["message"]);
      } else {
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
      final data = {"userId": userId};
      final response = await Apiservices().postRequest(
        ApiUrl.submitKYC,
        data: data,
      );
      print('Client ID ${clientId}');
      print('User ID ${userId}');
      print('DATA : ${data}');
      if (response.statusCode == 200 || response.statusCode == 201) {
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

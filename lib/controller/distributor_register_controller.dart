import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:utility_app_flutter/utils/Constants/api_url.dart';
import 'package:utility_app_flutter/utils/appServices/apiservices.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class DistributorRegisterController extends GetxController {
  // --- Step 1 ---
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final mpinController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodeController = TextEditingController();
  final fullAddressController = TextEditingController();
  final businessName = TextEditingController();
  final businessType = TextEditingController();

  // var shopPhotoFile = Rx<File?>(null);

  // --- Step 2 ---
  final blockController = TextEditingController();
  final subscriptionPlanController = TextEditingController();

  // --- Step 3 ---
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final qualificationController = TextEditingController();
  final experienceController = TextEditingController();
  final aadharOtpController = TextEditingController();
  // --- Step 4 (Documents) ---

  final aadhaarController = TextEditingController();
  final panController = TextEditingController();
  final bankAccountController = TextEditingController();
  final ifscController = TextEditingController();
  final referencePerson1Name = TextEditingController();
  final referencePerson1Mobile = TextEditingController();
  final referencePerson2name = TextEditingController();
  final referencePerson2Mobile = TextEditingController();

  var aadhaarFrontFile = Rx<File?>(null);
  var aadhaarBackFile = Rx<File?>(null);

  var panFile = Rx<File?>(null);
  var bankFile = Rx<File?>(null);
  var selfieFile = Rx<File?>(null);
  var addressProof = Rx<File?>(null);

  // --- Terms ---
  var acceptedTerms = false.obs;
  RxBool isLoading = false.obs;
  RxBool isOtpSending = false.obs;
  RxBool isOtpVerifying = false.obs;

  /// Toggle Terms
  void toggleTerms(bool? value) {
    acceptedTerms.value = value ?? false;
  }

  /// File picker
  Future<void> pickFile(Rx<File?> target) async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      target.value = File(file.path);
    }
  }

  /// Capture selfie from camera
  Future<void> captureSelfie() async {
    final picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      selfieFile.value = File(photo.path);
    }
  }

  // ---------------------- API Calls ---------------------- //

  /// 🔹 Register User API
  Future<void> registerDestributerApi(int index) async {
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
          "city": cityController.text.trim(),
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
      if (bankFile.value != null) files.add(bankFile.value!);
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

  @override
  void onClose() {
    // Dispose all controllers
    fullNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    mpinController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    cityController.dispose();
    blockController.dispose();
    stateController.dispose();
    subscriptionPlanController.dispose();
    question1Controller.dispose();
    question2Controller.dispose();
    question3Controller.dispose();
    qualificationController.dispose();
    experienceController.dispose();

    aadhaarController.dispose();
    panController.dispose();
    bankAccountController.dispose();
    super.onClose();
  }
}

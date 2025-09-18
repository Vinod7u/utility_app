import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final streetController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pincodeController = TextEditingController();
  final aadhaarController = TextEditingController();
  final panController = TextEditingController();
  final bankAccountController = TextEditingController();
  final ifscController = TextEditingController();
  final nomineeController = TextEditingController();
  var aadhaarFile = Rx<File?>(null);
  var panFile = Rx<File?>(null);
  var bankFile = Rx<File?>(null);
  var selfieFile = Rx<File?>(null);

  // Terms & location
  var acceptedTerms = false.obs;
  var position = Rx<Position?>(null);

  final picker = ImagePicker();

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
}

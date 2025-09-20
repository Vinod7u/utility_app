import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DistributorRegisterController extends GetxController {
  // --- Step 1 ---
  final firmNameController = TextEditingController();
  final DsEmailController = TextEditingController();
  final DSMobile_NumberController = TextEditingController();
  final Mpin = TextEditingController();
  final Ds_password = TextEditingController();
  final Ds_confirm_password = TextEditingController();

  // var shopPhotoFile = Rx<File?>(null);

  // --- Step 2 ---
  final districtController = TextEditingController();
  final blockController = TextEditingController();
  final stateController = TextEditingController();
  final subscriptionPlanController = TextEditingController();

  // --- Step 3 ---
  final Qus1Controller = TextEditingController();
  final Qus2Controller = TextEditingController();
  final Qus3Controller = TextEditingController();
  final qualificationController = TextEditingController();
  final experienceController = TextEditingController();

  // --- Step 4 (Documents) ---

  final aadhaarController = TextEditingController();
  final panController = TextEditingController();
  final bankAccountController = TextEditingController();
  var aadhaarFile = Rx<File?>(null);
  var panFile = Rx<File?>(null);
  var bankFile = Rx<File?>(null);
  var selfieFile = Rx<File?>(null);

  // --- Terms ---
  var acceptedTerms = false.obs;

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

  @override
  void onClose() {
    // Dispose all controllers
    firmNameController.dispose();
    DsEmailController.dispose();
    DSMobile_NumberController.dispose();
    Mpin.dispose();
    Ds_password.dispose();
    Ds_confirm_password.dispose();

    districtController.dispose();
    blockController.dispose();
    stateController.dispose();
    subscriptionPlanController.dispose();
    Qus1Controller.dispose();
    Qus2Controller.dispose();
    Qus3Controller.dispose();
    qualificationController.dispose();
    experienceController.dispose();

    aadhaarController.dispose();
    panController.dispose();
    bankAccountController.dispose();
    super.onClose();
  }
}

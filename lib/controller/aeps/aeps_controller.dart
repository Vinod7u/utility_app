import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/appServices/bio_matrics_services.dart';

class AepsController extends GetxController {
  final aadharNumberController = TextEditingController();
  final mobileNumberController = TextEditingController();
  
  final biometricService = Get.find<BiometricService>();

  @override
  void onClose() {
    aadharNumberController.dispose();
    mobileNumberController.dispose();
    super.onClose();
  }
}
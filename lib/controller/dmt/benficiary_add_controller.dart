import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BenficiaryAddController extends GetxController {
  final nameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscController = TextEditingController();
  final dobController = TextEditingController();
  final pincodeController = TextEditingController();
  final addressController = TextEditingController();
  var selectedBank = "".obs;
  var selectedGstState = ''.obs;
   var isDefault = false.obs;
  var isActive = true.obs;

  RxList<String> bankName = ["HDFC", "IDFC", "SBI", "PNB", "Kotak"].obs;
  RxList<String> stateName = [
    "Rajasthan",
    "Goa",
    "Delhi",
    "Punjab",
    "Gujrat",
  ].obs;
}

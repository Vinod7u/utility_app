import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AepsServiceFormController extends GetxController {
  final aadharNumberController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final remarkNumberController = TextEditingController();
  final amountNumberController = TextEditingController();

  RxList<String> bank = ["SBI", "PNB", "KOTAK", "HDFC", "ICICI"].obs;
  var selectedBank = "".obs; // Initially empty
}

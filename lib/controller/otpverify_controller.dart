import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/screens/home/home_page.dart';
import 'package:utility_app_flutter/screens/loginselection.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class OtpverifyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  Future<void> verifyOtp() async {
    Get.to(() => Loginselection());
  }
}

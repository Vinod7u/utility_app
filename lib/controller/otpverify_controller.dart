import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/screens/auth/loginselection.dart';
import 'package:utility_app_flutter/utils/Constants/api_url.dart';
import 'package:utility_app_flutter/utils/appServices/apiservices.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class OtpverifyController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> verifyOtp({required String otp, required String mobile}) async {
    try {
      isLoading.value = true;
      final data = {"mobileNumber": mobile, "otp": otp};
      final response = await Apiservices().postRequest(
        ApiUrl.verifyOtp,
        data: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;

        showSnackBar(title: "Success", message: response.data["message"]);
        Get.to(() => Loginselection());
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

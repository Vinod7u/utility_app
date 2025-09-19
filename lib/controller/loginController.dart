import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/screens/auth/otp_verify_screen.dart';
import 'package:utility_app_flutter/utils/Constants/api_url.dart';
import 'package:utility_app_flutter/utils/appServices/apiservices.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class Logincontroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  final mobileNumberController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  // function for calling the sendOtpApi
  Future<void> sendOtpApi(String mobileNumber) async {
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
  }


}

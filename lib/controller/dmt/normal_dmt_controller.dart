import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NormalDmtController extends GetxController {
  final mobileNumberController = TextEditingController();
  final otpController = TextEditingController();
  final aadharNumberController = TextEditingController();
  var currentStep = 0.obs; // step 0 = mobile input, 1 = otp, 2 = transfer etc.
  // static const platform = MethodChannel('aeps_scanner_channel');
  var statusMessage = "Please place your finger on the scanner".obs;
  var isScanning = true.obs;
  var isCapturing = false.obs;

  // Function(bool success, String message, String? biometricData)?
  // onBiometricResult;

  // void setCallback(
  //   Function(bool success, String message, String? biometricData)? callback,
  // ) {
  //   onBiometricResult = callback;
  // }

  @override
  void onInit() {
    super.onInit();
    // captureFingerprint();
  }

  // Future<void> captureFingerprint() async {
  //   if (isCapturing.value) return; // prevent duplicate calls
  //   isCapturing.value = true;

  //   try {
  //     final result = await platform.invokeMethod('captureFingerprint');
  //     if (result != null && result['success'] == true) {
  //       statusMessage.value = "Biometric captured successfully!";
  //       String biometricData = result['data'] ?? '';
  //       onBiometricResult?.call(true, "Success", biometricData);
  //     } else {
  //       statusMessage.value = "Capture failed";
  //       onBiometricResult?.call(false, "Failed", null);
  //     }
  //   } on PlatformException catch (e) {
  //     statusMessage.value = "Error: ${e.message ?? 'Scanner not connected'}";
  //     onBiometricResult?.call(false, e.message ?? "Error occurred", null);
  //   } finally {
  //     isCapturing.value = false;
  //   }
  // }

  void closeDialogAfterDelay() {
    Future.delayed(const Duration(seconds: 2), () {
      // Get.to(() => AepsServicesScreen());
    });
  }

  void goToNextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void goBackStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      Get.back(); // exit screen if step = 0
    }
  }
}

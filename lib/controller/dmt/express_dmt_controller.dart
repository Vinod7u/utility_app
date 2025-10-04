import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ExpressDmtController extends GetxController {
  final mobileNumberController = TextEditingController();
  final otpController = TextEditingController();
  final nameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final ifscController = TextEditingController();
  final amountController = TextEditingController();
  var selectedMethod = ''.obs;
  RxList<String> method = ["IMPS", "BMPS"].obs;
  var currentStep = 0.obs; // step 0 = mobile input, 1 = otp, 2 = transfer etc.
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

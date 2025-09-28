import 'package:get/get.dart';

class SecurityController extends GetxController {
  var isBiometricEnabled = false.obs;
  var isAppLockEnabled = false.obs;

  void toggleBiometric() {
    isBiometricEnabled.value = !isBiometricEnabled.value;
  }

  void toggleAppLock() {
    isAppLockEnabled.value = !isAppLockEnabled.value;
  }
}

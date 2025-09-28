import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/screens/auth/login.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();

    // Animation setup
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    animationController.forward();

    // ⏳ Add 4 second delay, then navigate
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAll(() => const Login()); // Change to LoginSelection() if needed
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}

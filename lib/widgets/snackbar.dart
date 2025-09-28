import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

void showSnackBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColors.appbarsecondColor,
    colorText: Colors.white,
    margin: const EdgeInsets.all(12),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
  );
}

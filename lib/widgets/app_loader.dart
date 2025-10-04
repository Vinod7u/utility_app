import 'package:flutter/material.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

Widget appLoader() {
  return Center(
    child: CircularProgressIndicator(color: AppColors.darkColor),
  );
}

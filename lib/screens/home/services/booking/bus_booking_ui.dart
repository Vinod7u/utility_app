import 'package:flutter/material.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class BusBookingUi extends StatefulWidget {
  const BusBookingUi({super.key});

  @override
  State<BusBookingUi> createState() => _BusBookingUiState();
}

class _BusBookingUiState extends State<BusBookingUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: CustomScrollView(
        slivers: [
          
        ],
      ),
    );
  }
}
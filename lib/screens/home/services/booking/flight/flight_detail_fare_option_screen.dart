import 'package:flutter/material.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class FlightDetailFareOptionScreen extends StatefulWidget {
  const FlightDetailFareOptionScreen({super.key});

  @override
  State<FlightDetailFareOptionScreen> createState() => _FlightDetailFareOptionScreenState();
}

class _FlightDetailFareOptionScreenState extends State<FlightDetailFareOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(child: CustomScrollView(
        slivers: [
          
        ],
      )),
    );
  }
}
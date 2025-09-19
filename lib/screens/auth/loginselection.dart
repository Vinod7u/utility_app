import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/screens/auth/distributer_register.dart';
import 'package:utility_app_flutter/screens/auth/retailer_register.dart';
import 'package:utility_app_flutter/screens/auth/user_register.dart';
import 'package:utility_app_flutter/screens/auth/login.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class Loginselection extends StatefulWidget {
  const Loginselection({super.key});

  @override
  State<Loginselection> createState() => _LoginselectionState();
}

class _LoginselectionState extends State<Loginselection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.whiteshade, AppColors.purpleshade],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose Login Type',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryC,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Select your account type to continue',
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
                SizedBox(height: 40),
                _buildLoginOption(
                  context,
                  'User Login',
                  'Individual customers',
                  Icons.person,
                  [AppColors.primaryC, AppColors.primary],
                  UserType.user,
                  () {
                    Get.offAll(() => UserRegister(userType: UserType.user));
                  },
                ),
                SizedBox(height: 16),
                _buildLoginOption(
                  context,
                  'Retailer Login',
                  'Retail partners',
                  Icons.store,
                  [AppColors.primaryC, AppColors.primary],
                  UserType.retailer,
                  () {
                    Get.offAll(() => RetailerRegister());
                  },
                ),
                SizedBox(height: 16),
                _buildLoginOption(
                  context,
                  'Distributor Login',
                  'Distribution partners',
                  Icons.business,
                  [AppColors.primaryC, AppColors.primary],
                  UserType.distributor,
                  () {
                    Get.offAll(() => DistributerRegister());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    List<Color> gradientColors,
    UserType userType,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFe2e8f0), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryC,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

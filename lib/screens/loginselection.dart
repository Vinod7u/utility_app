import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utility_app_flutter/screens/login.dart';
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
            colors: [Color(0xFFf5f7fa), Color(0xFFc3cfe2)],
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
                    color: Color(0xFF1a202c),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Select your account type to continue',
                  style: TextStyle(fontSize: 16, color: Color(0xFF64748b)),
                ),
                SizedBox(height: 40),
                _buildLoginOption(
                  context,
                  'User Login',
                  'Individual customers',
                  Icons.person,
                  [Color(0xff0c3d4c), Color(0xff57A1CE)],
                  UserType.user,
                ),
                SizedBox(height: 16),
                _buildLoginOption(
                  context,
                  'Retailer Login',
                  'Retail partners',
                  Icons.store,
                  [Color(0xff0c3d4c), Color(0xff57A1CE)],
                  UserType.retailer,
                ),
                SizedBox(height: 16),
                _buildLoginOption(
                  context,
                  'Distributor Login',
                  'Distribution partners',
                  Icons.business,
                  [Color(0xff0c3d4c), Color(0xff57A1CE)],
                  UserType.distributor,
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
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(() => Login(userType: userType));
      },
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
                color: Color(0xFF1a202c),
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Color(0xFF64748b)),
            ),
          ],
        ),
      ),
    );
  }
}

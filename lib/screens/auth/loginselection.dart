import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/login_selection_controller.dart';
import 'package:utility_app_flutter/screens/auth/distributer_register.dart';
import 'package:utility_app_flutter/screens/auth/retailer_register.dart';
import 'package:utility_app_flutter/screens/auth/user_register.dart';
import 'package:utility_app_flutter/screens/auth/login.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';
import 'package:utility_app_flutter/widgets/app_loader.dart';

class Loginselection extends StatefulWidget {
  const Loginselection({super.key});

  @override
  State<Loginselection> createState() => _LoginselectionState();
}

class _LoginselectionState extends State<Loginselection> {
  final roleController = Get.put(LoginSelectionController());

  @override
  void initState() {
    super.initState();
    roleController.loadRoles(); // fetch roles from API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Text(
                  'Choose Account Type',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Select your account type to continue',

                  style: TextStyle(fontSize: 16, color: AppColors.primaryC),
                ),
                const SizedBox(height: 40),

                // 🔹 Role List from API
                Obx(() {
                  if (roleController.isLoading.value) {
                    return Center(child: appLoader());
                  }

                  if (roleController.roles.isEmpty) {
                    return Center(child: const Text("No roles available"));
                  }

                  return Column(
                    children: roleController.filteredRoles.map((roleData) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildLoginOption(
                          context,
                          "${roleData.role} Login", // Role name from API
                          "Login as ${roleData.role}", // Subtitle
                          Icons.person, // you can map roles -> icons if needed
                          [
                            AppColors.appbarFirstColor,
                            AppColors.appbarsecondColor,
                          ],
                          () {
                            // 🔹 Navigate based on role
                            if (roleData.role?.toLowerCase() == "user") {
                              Get.offAll(
                                () => UserRegister(userType: UserType.user),
                              );
                            } else if (roleData.role?.toLowerCase() ==
                                "retailer") {
                              Get.offAll(
                                () => RetailerRegister(
                                  userType: UserType.retailer,
                                ),
                              );
                            } else if (roleData.role?.toLowerCase() ==
                                "distributor") {
                              Get.offAll(
                                () => DistributorRegister(
                                  userType: UserType.distributor,
                                ),
                              );
                            } else {
                              Get.snackbar(
                                "Info",
                                "No screen mapped for ${roleData.role}",
                              );
                            }
                          },
                        ),
                      );
                    }).toList(),
                  );
                }),
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
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
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
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: AppColors.blue_text),
            ),
          ],
        ),
      ),
    );
  }
}

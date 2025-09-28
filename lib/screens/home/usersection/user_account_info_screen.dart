import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class UserAccountInfoScreen extends StatefulWidget {
  const UserAccountInfoScreen({super.key});

  @override
  State<UserAccountInfoScreen> createState() => _UserAccountInfoScreenState();
}

class _UserAccountInfoScreenState extends State<UserAccountInfoScreen> {
  final TextEditingController bankNameController = TextEditingController(
    text: "HDFC Bank",
  );
  final TextEditingController accountNumberController = TextEditingController(
    text: "123456789012",
  );
  final TextEditingController ifscController = TextEditingController(
    text: "HDFC0001234",
  );
  final TextEditingController upiController = TextEditingController(
    text: "vinod@upi",
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.appbarFirstColor,
                            AppColors.appbarsecondColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.account_balance,
                            color: Colors.white,
                            size: 40,
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            "Bank Account Info",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Form Fields
                    _buildTextField("Bank Name", bankNameController),
                    const SizedBox(height: 16),
                    _buildTextField(
                      "Account Number",
                      accountNumberController,
                      isObscure: true,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField("IFSC Code", ifscController),
                    const SizedBox(height: 16),
                    _buildTextField("UPI ID", upiController),
                    const SizedBox(height: 24),

                    // Save Button
                    Center(
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
                        child: appButton(
                          title: "Save",
                          onTap: () {
                            showSnackBar(
                              title: "Successful",
                              message: "Data Updated Successfully",
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isObscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 40,
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.appbarFirstColor, AppColors.appbarsecondColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildAppBarIcon(Icons.arrow_back_ios_new, () {
                    Get.back();
                  }),
                ),
                const Text(
                  "Account Info",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

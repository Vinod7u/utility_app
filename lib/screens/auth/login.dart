import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:utility_app_flutter/controller/loginController.dart';
import 'package:utility_app_flutter/screens/auth/otp_verify_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_home_page.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
import 'package:utility_app_flutter/widgets/app_loader.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controller = Get.put(Logincontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: appLoader());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                   color: AppColors.darkColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.person_2, color: Colors.white, size: 40),
                ),
                SizedBox(height: 20),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Welcome back! Please sign in",
                  style: TextStyle(fontSize: 16, color: Color(0xFF64748b)),
                ),
                SizedBox(height: 40),
                _buildTextField(
                  icon: Icons.person,
                  controller: controller.mobileNumberController,
                  label: 'Mobile Number',
                  hint: 'Enter Number',
                ),
                SizedBox(height: 16),

                _buildTextField(
                  icon: Icons.lock,
                  controller: controller.passwordController,
                  label: 'Password',
                  hint: 'Enter Password',
                  obscureText: true,
                ),
                SizedBox(height: 32),

                // --- Login with Password ---
                appButton(
                  title: "Login with Password",
                  onTap: () {
                    // if (controller.formKey.currentState!.validate()) {
                    //   Get.offAll(() => UserHomePage());
                    //   // Get.to(() => UserHomePage(userType: UserType.user));
                    // } else {
                    //   showSnackBar(
                    //     title: "Error",
                    //     message: "Enter valid credentials",
                    //   );
                    // }
                    //  Get.offAll(() => RetailerRegister(userType: UserType.retailer));
                    Get.offAll(() => UserHomePage());
                  },
                ),

                SizedBox(height: 16),

                // --- Send OTP ---
                appButton(
                  title: "Send Otp",
                  onTap: () {
                    final mobile = controller.mobileNumberController.text
                        .trim();
                    //
                    // if (mobile.isEmpty) {
                    //   showSnackBar(
                    //     title: "Error",
                    //     message: "Enter mobile number",
                    //   );
                    // } else if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
                    //   showSnackBar(
                    //     title: "Error",
                    //     message: "Enter a valid 10-digit mobile number",
                    //   );
                    // } else {
                    Get.to(
                      () => OtpVerifyScreen(),
                      arguments: {"mobile": mobile},
                    ); //   controller.sendOtpApi(mobile);
                    // }
                  },
                ),

                SizedBox(height: 16),

                // TextButton(
                //   onPressed: () {
                //     if (widget.userType == UserType.user) {
                //       Get.to(() => UserRegister(userType: widget.userType));
                //     } else if (widget.userType == UserType.retailer) {
                //       Get.to(() => RetailerRegister());
                //     } else {
                //       Get.to(() => DistributerRegister());
                //     }
                //   },
                //   child: RichText(
                //     text: TextSpan(
                //       style: TextStyle(color: AppColors.primaryC, fontSize: 14),
                //       children: [
                //         TextSpan(text: prefixText),
                //         TextSpan(
                //           text: "SignUp",
                //           style: TextStyle(
                //             decoration: TextDecoration.underline,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLength: label == "Mobile Number" ? 10 : null,
          keyboardType: label == "Mobile Number"
              ? TextInputType.phone
              : TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.textColor),
            hintText: hint,
            hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            filled: true,
            counterText: '',
            fillColor: AppColors.off_white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.appbarsecondColor,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }

            if (label == "Mobile Number") {
              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return 'Enter a valid 10-digit mobile number';
              }
            }

            if (label == "Password") {
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return 'Password must contain at least 1 uppercase letter';
              }
              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Password must contain at least 1 number';
              }
            }

            return null;
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:utility_app_flutter/controller/loginController.dart';
import 'package:utility_app_flutter/screens/auth/distributer_register.dart';
import 'package:utility_app_flutter/screens/auth/otp_verify_screen.dart';
import 'package:utility_app_flutter/screens/auth/retailer_register.dart';
import 'package:utility_app_flutter/screens/auth/user_register.dart';
import 'package:utility_app_flutter/screens/home/home_page.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';

import 'auth/retailer_register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controller = Get.put(Logincontroller());

  // Decide the text based on userType

  @override
  Widget build(BuildContext context) {
    String prefixText = "Don't have an account? ";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF1a202c)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
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
                  gradient: LinearGradient(
                    colors: [AppColors.primaryC, AppColors.primary],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.person_2, color: Colors.white, size: 40),
              ),
              SizedBox(height: 20),
              Text(
                "User Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1a202c),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Welcome back! Please sign in",
                style: TextStyle(fontSize: 16, color: Color(0xFF64748b)),
              ),
              SizedBox(height: 40),
              _buildTextField(
                controller: controller.usernameController,
                label: 'Mobile Number',
                hint: '+91 98765 43210',
              ),
              SizedBox(height: 16),

              _buildTextField(
                controller: controller.passwordController,
                label: 'Password',
                hint: 'Enter Password',
                obscureText: true,
              ),
              SizedBox(height: 32),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      Get.to(() => OtpVerifyScreen());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryC, AppColors.primary],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
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
      ),
    );
  }

  Widget _buildTextField({
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
            color: Color(0xFF374151),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Color(0xFFf9fafb),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFe5e7eb), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFe5e7eb), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF667eea), width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ],
    );
  }
}

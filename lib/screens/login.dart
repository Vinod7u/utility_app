import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:utility_app_flutter/controller/loginController.dart';
import 'package:utility_app_flutter/screens/home/home_page.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class Login extends StatefulWidget {
  final UserType userType;

  const Login({super.key, required this.userType});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controller = Get.put(Logincontroller());

  String get title {
    switch (widget.userType) {
      case UserType.user:
        return 'User Login';
      case UserType.retailer:
        return 'Retailer Login';
      case UserType.distributor:
        return 'Distributor Login';
    }
  }

  String get subtitle {
    switch (widget.userType) {
      case UserType.user:
        return 'Welcome back! Please sign in';
      case UserType.retailer:
        return 'Access your retailer dashboard';
      case UserType.distributor:
        return 'Access distributor portal';
    }
  }

  IconData get icon {
    switch (widget.userType) {
      case UserType.user:
        return Icons.person;
      case UserType.retailer:
        return Icons.store;
      case UserType.distributor:
        return Icons.business;
    }
  }

  List<Color> get gradientColors {
    switch (widget.userType) {
      case UserType.user:
        return [Color(0xFF667eea), Color(0xFF764ba2)];
      case UserType.retailer:
        return [Color(0xFFf093fb), Color(0xFFf5576c)];
      case UserType.distributor:
        return [Color(0xFF4facfe), Color(0xFF00f2fe)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                  gradient: LinearGradient(colors: gradientColors),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(icon, color: Colors.white, size: 40),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1a202c),
                ),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(fontSize: 16, color: Color(0xFF64748b)),
              ),
              SizedBox(height: 40),
              _buildTextField(
                controller: controller.usernameController,
                label: widget.userType == UserType.user
                    ? 'Mobile Number'
                    : widget.userType == UserType.retailer
                    ? 'Retailer ID'
                    : 'Distributor Code',
                hint: widget.userType == UserType.user
                    ? '+91 98765 43210'
                    : widget.userType == UserType.retailer
                    ? 'Enter Retailer ID'
                    : 'Enter Distributor Code',
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: controller.passwordController,
                label: widget.userType == UserType.user
                    ? 'PIN'
                    : widget.userType == UserType.retailer
                    ? 'Password'
                    : 'Access Key',
                hint: widget.userType == UserType.user
                    ? 'Enter 4-digit PIN'
                    : widget.userType == UserType.retailer
                    ? 'Enter Password'
                    : 'Enter Access Key',
                obscureText: true,
              ),
              SizedBox(height: 32),
              SizedBox(
                height: 80,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      Get.to(() => HomePage(userType: widget.userType));
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
                      gradient: LinearGradient(colors: gradientColors),
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
              TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: Text(
                  widget.userType == UserType.user
                      ? 'Forgot PIN?'
                      : widget.userType == UserType.retailer
                      ? 'Forgot Password?'
                      : 'Forgot Access Key?',
                  style: TextStyle(color: gradientColors[0], fontSize: 14),
                ),
              ),
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

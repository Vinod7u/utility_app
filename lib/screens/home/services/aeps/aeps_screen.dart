import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utility_app_flutter/controller/aeps/aeps_controller.dart';
import 'package:utility_app_flutter/screens/home/services/aeps/aeps_services_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
import 'package:utility_app_flutter/widgets/biomatrics_popup.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class AepsScreen extends StatefulWidget {
  const AepsScreen({super.key});

  @override
  State<AepsScreen> createState() => _AepsScreenState();
}

class _AepsScreenState extends State<AepsScreen> {
  final controller = Get.put(AepsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  _buildTopSection(),
                  SizedBox(height: 16),
                  _buildsecondSection(),
                  SizedBox(height: 16),
                  _buildThirdSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "AEPS DASHBOARD",
            style: TextStyle(
              color: AppColors.darkColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),

          Text(
            "Aadhar Enabled Payment  System",
            style: TextStyle(
              color: AppColors.darkColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.blue_shade,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  "Status : Accpected",
                  style: TextStyle(color: AppColors.darkColor),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.blue_shade,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  "Activation : Activated",
                  style: TextStyle(color: AppColors.darkColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildsecondSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, size: 32, color: AppColors.darkColor),
              Text(
                "Aeps Registration",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),

          SizedBox(height: 15),
          Text(
            "Complete your AEPS registration to access services",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),

          SizedBox(height: 15),

          _buildTextField(
            controller: controller.aadharNumberController,
            hint: "Enter aadhar number",
            label: "Aadhar Number",
          ),
          _buildTextField(
            controller: controller.mobileNumberController,
            hint: "Enter mobile number",
            label: "Mobile Number",
          ),

          SizedBox(height: 15),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: appButton(
              title: 'Register with Biometric',
              onTap: () {
                showBiometricCaptureDialog(
                  context,
                  title: "AEPS Registration",
                  description: "Place your finger on the scanner to register",
                  onResult: (success, message, biometricData) {
                    if (success) {
                      showSnackBar(
                        title: "Success",
                        message: "Biometric captured successfully!",
                      );
                      print("Biometric Data: $biometricData");

                      // Navigate to next screen
                      Get.to(() => AepsServicesScreen());

                      // OR navigate with data
                      // Get.to(
                      //   () => AepsServicesScreen(),
                      //   arguments: {
                      //     'biometricData': biometricData,
                      //     'aadhar': controller.aadharNumberController.text,
                      //     'mobile': controller.mobileNumberController.text,
                      //   },
                      // );
                    } else {
                      showSnackBar(title: "Failed", message: message);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThirdSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.blue_shade,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black)],
      ),
      child: Center(
        child: Text(
          "Complete registration to access AEPS services",
          style: TextStyle(color: AppColors.darkColor),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 60,
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
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                Text(
                  "AEPS",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      color: AppColors.appbarFirstColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? label,
    required String hint,
    bool obscureText = false,
    int? maxL,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLength: maxL,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            counterText: '',
            fillColor: AppColors.textfield_inside_color,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.textfield_border_color,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.textColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: (value) {},
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void showBiometricCaptureDialog(
    BuildContext context, {
    String? title,
    String? description,
    bool autoCapture = true,
    Function(bool success, String message, String? biometricData)? onResult,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BiometricCaptureDialog(
          title: title,
          description: description,
          autoCapture: autoCapture,
          onBiometricResult: onResult,
        );
      },
    );
  }
}

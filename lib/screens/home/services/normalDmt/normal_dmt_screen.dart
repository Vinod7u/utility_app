import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:utility_app_flutter/controller/dmt/normal_dmt_controller.dart';
import 'package:utility_app_flutter/screens/home/services/normalDmt/benifiacary_management_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
import 'package:utility_app_flutter/widgets/biomatrics_popup.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class NormalDmtScreen extends StatefulWidget {
  const NormalDmtScreen({super.key});

  @override
  State<NormalDmtScreen> createState() => _NormalDmtScreenState();
}

class _NormalDmtScreenState extends State<NormalDmtScreen> {
  final controller = Get.put(NormalDmtController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Obx(() {
                return Column(
                  children: [
                    const SizedBox(height: 16),
                    if (controller.currentStep.value == 0) _buildfirstTile(),
                    if (controller.currentStep.value == 1) _buildotpTile(),
                    if (controller.currentStep.value == 2)
                      _buildAadharverifySection(),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildfirstTile() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Normal Dmt Transfer",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          SizedBox(height: 15),

          _buildTextField(
            controller: controller.mobileNumberController,
            hint: "Enter mobile number",
            label: "Mobile Number",
            maxL: 10,
          ),

          SizedBox(height: 15),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: appButton(
                title: 'Verify',
                onTap: () {
                  controller.goToNextStep();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
    ),
  );

  Widget _buildotpTile() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Normal Dmt Transfer",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          SizedBox(height: 15),

          Pinput(
            length: 6,
            controller: controller.otpController,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: AppColors.primary, width: 2),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: Colors.grey.shade200,
              ),
            ),
            showCursor: true,
            onCompleted: (pin) {},
          ),

          SizedBox(height: 15),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: appButton(
                title: 'Verify Otp',
                onTap: () {
                  controller.goToNextStep();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAadharverifySection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Normal Dmt Transfer",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          SizedBox(height: 15),

          _buildTextField(
            controller: controller.aadharNumberController,
            hint: "Enter aadhar number",
            label: "Aadhar Number",
            maxL: 12,
          ),

          SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: appButton(
                  title: 'Capture Biomatric',
                  onTap: () {
                    showBiometricCaptureDialog(
                      context,
                      title: "AEPS Registration",
                      description:
                          "Place your finger on the scanner to register",
                      onResult: (success, message, biometricData) {
                        if (success) {
                          showSnackBar(
                            title: "Success",
                            message: "Biometric captured successfully!",
                          );
                          print("Biometric Data: $biometricData");

                          // Navigate to next screen
                          Get.back();

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
              SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: AppColors.primary, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => BenifiacaryManagementScreen());
                    },
                    child: Text(
                      "Submit Kyc",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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
                  "Normal Dmt Transfer",
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
          keyboardType: TextInputType.number,
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

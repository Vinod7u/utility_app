import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/user_register_controller.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_home_page.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/Validators/validators.dart';
import 'package:utility_app_flutter/utils/utils.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class UserRegister extends StatefulWidget {
  final UserType userType;

  const UserRegister({super.key, required this.userType});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final controller = Get.put(UserRegisterController());
  final RxInt stepIndex = 0.obs;

  /// Form keys for each step
  final formKeys = List.generate(5, (_) => GlobalKey<FormState>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: stepIndex.value > 0
            ? InkWell(
                onTap: () {
                  if (stepIndex.value > 0) {
                    stepIndex.value--;
                  } else {
                    Get.back();
                  }
                },
                child: const Icon(Icons.arrow_back_ios, color: Colors.black),
              )
            : null,
        centerTitle: true,
        title: const Text("Register"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => Column(
          children: [
            /// Step Indicator
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: List.generate(5, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: stepIndex.value >= index
                            ? AppColors.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                  );
                }),
              ),
            ),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
                child: _buildStep(stepIndex.value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Step switcher
  Widget _buildStep(int index) {
    switch (index) {
      case 0:
        return _buildUserDetails();
      case 1:
        return _buildAadharDetails();
      case 2:
        return _buildPandVerify();
      case 3:
        return _buildBankDetails();
      case 4:
        return _buildKycDetails();
      default:
        return _buildUserDetails();
    }
  }

  /// KYC Final Step
  Widget _buildKycDetails() {
    return _wrapStep(
      step: 4,
      isLast: true,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Submit KYC',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Everything looks good -- submit your KYC',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Review Completed. Click below to submit your KYC',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primaryC),
                )
              : appButton(
                  title: 'Submit KYC',
                  onTap: () async {
                    if (formKeys[stepIndex.value].currentState!.validate()) {
                      await controller.submitKYCApi();
                    } else {
                      showSnackBar(
                        title: "Error",
                        message: "Enter valid details",
                      );
                    }
                  },
                ),
        ),
      ],
      onNext: () {},
    );
  }

  /// PAN Verification Step
  Widget _buildPandVerify() {
    return _wrapStep(
      step: 2,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'PAN Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 10),
        _buildTextField(
          controller: controller.panController,
          label: "PAN Card Number",
          hint: "Enter PAN number",
        ),
        Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primaryC),
                )
              : appButton(
                  title: 'Verify Pan',
                  onTap: () async {
                    if (formKeys[stepIndex.value].currentState!.validate()) {
                      await controller.verifyPan();
                    } else {
                      showSnackBar(
                        title: "Error",
                        message: "Enter a valid PAN number",
                      );
                    }
                  },
                ),
        ),
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// User + Address Step
  Widget _buildUserDetails() {
    return _wrapStep(
      step: 0,
      children: [
        _buildTextField(
          controller: controller.fullNameController,
          label: "Full Name",
          hint: "Enter full name",
        ),
        _buildTextField(
          controller: controller.mobileController,
          label: "Mobile Number",
          hint: "Enter 10-digit mobile number",
        ),
        _buildTextField(
          controller: controller.emailController,
          label: "Email",
          hint: "Enter email",
        ),
        _buildTextField(
          controller: controller.mpinController,
          label: "Mpin",
          hint: "Enter Mpin",
        ),
        _buildTextField(
          controller: controller.passwordController,
          label: "Password",
          hint: "Enter password",
        ),
        _buildTextField(
          controller: controller.confirmPasswordController,
          label: "Confirm Password",
          hint: "Confirm Password",
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Address Information",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildTextField(
          controller: controller.districtController,
          label: "District Name",
          hint: "Enter district name",
        ),
        _buildTextField(
          controller: controller.stateController,
          label: "State Name",
          hint: "Enter state name",
        ),
        _buildTextField(
          controller: controller.countryController,
          label: "Country Name",
          hint: "Enter country name",
        ),
        _buildTextField(
          controller: controller.pincodeController,
          label: "Pin Code",
          hint: "Enter 6-digit pin code",
          maxlength: 6,
        ),
        _buildTextField(
          controller: controller.fullAddressController,
          label: "Full Address",
          hint: "Enter full Address",
        ),
      ],
      onNext: () => controller.registerUserApi(stepIndex.value),
    );
  }

  /// Aadhaar Step
  Widget _buildAadharDetails() {
    return _wrapStep(
      step: 1,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Aadhaar Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Verify Aadhaar and review the details',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(height: 10),
        _buildTextField(
          controller: controller.aadhaarController,
          label: "Aadhaar Number",
          maxlength: 12,
          hint: "Enter 12-digit Aadhaar number",
        ),
        const SizedBox(height: 10),
        Obx(
          () => controller.isOtpSending.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primaryC),
                )
              : appButton(
                  title: 'Send Otp',
                  onTap: () async {
                    if (controller.aadhaarController.text.length == 12) {
                      await controller.sendAadhaarOtp();
                    } else {
                      showSnackBar(
                        title: "Error",
                        message: "Enter a valid 12-digit Aadhaar number",
                      );
                    }
                  },
                ),
        ),
        const SizedBox(height: 10),
        if (controller.isOtpVerifying.value) ...[
          _buildTextField(
            controller: controller.aadharOtpController,
            label: "Otp",
            hint: "Enter Otp",
          ),
          Obx(
            () => controller.isOtpVerifying.value
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.primaryC),
                  )
                : appButton(
                    title: 'Verify Otp',
                    onTap: () async {
                      if (controller.aadharOtpController.text.length == 6) {
                        await controller.verifyAadhaarOtp();
                      } else {
                        showSnackBar(
                          title: "Error",
                          message: "Enter a valid 6-digit Otp",
                        );
                      }
                    },
                  ),
          ),
        ],
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// Bank Step
  Widget _buildBankDetails() {
    return _wrapStep(
      step: 3,
      children: [
        _buildTextField(
          controller: controller.bankAccountController,
          label: "Account Number",
          hint: "Enter bank account number",
        ),
        _buildTextField(
          controller: controller.ifscController,
          label: "IFSC Code",
          hint: "Enter IFSC code",
        ),
        const SizedBox(height: 12),
        Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primaryC),
                )
              : appButton(
                  title: 'Verify Bank',
                  onTap: () async {
                    if (formKeys[stepIndex.value].currentState!.validate()) {
                      await controller.verifyBankAccount();
                    } else {
                      showSnackBar(
                        title: "Error",
                        message: "Enter valid details",
                      );
                    }
                  },
                ),
        ),
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// Step Wrapper with Validation
  Widget _wrapStep({
    required List<Widget> children,
    required VoidCallback onNext,
    required int step,
    bool isLast = false,
  }) {
    return Padding(
      key: ValueKey(children.hashCode),
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKeys[step],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(child: Column(children: children)),
            ),
            const SizedBox(height: 20),
            appButton(
              title: isLast ? "Register" : "Next",
              onTap: () {
                if (formKeys[step].currentState!.validate()) {
                  onNext();
                } else {
                  showSnackBar(
                    title: "Error",
                    message: "Please fill all required fields",
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// TextField Builder with validation
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    int? maxlength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            maxLength: maxlength,
            controller: controller,
            obscureText: obscureText,
            keyboardType: label.contains("Mobile")
                ? TextInputType.phone
                : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xFFf9fafb),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFe5e7eb),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }

              if (label == "Mobile Number" &&
                  !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return "Enter a valid 10-digit mobile number";
              }

              if (label == "Email" &&
                  !RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                return "Enter a valid email address";
              }

              if (label == "Pin Code" && value.length != 6) {
                return "Enter a valid 6-digit pin code";
              }

              if (label == "Aadhaar Number" &&
                  !RegExp(r'^[0-9]{12}$').hasMatch(value)) {
                return "Enter a valid 12-digit Aadhaar number";
              }

              if (label == "PAN Card Number" &&
                  !RegExp(
                    r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$',
                  ).hasMatch(value.toUpperCase())) {
                return "Enter a valid PAN number";
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Upload Tile Builder
  Widget _buildUploadTile({
    required String title,
    required Rx<File?> fileObs,
    required VoidCallback onTap,
    bool isImagePreview = false,
  }) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 55,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload_file, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    fileObs.value == null ? title : "Re-upload",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (fileObs.value != null)
            isImagePreview
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(fileObs.value!, height: 100),
                  )
                : Text(
                    "📄 ${fileObs.value!.path.split('/').last}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

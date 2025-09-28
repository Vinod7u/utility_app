import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/distributor_register_controller.dart';

import 'package:utility_app_flutter/screens/home/usersection/user_home_page.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
import 'package:utility_app_flutter/widgets/app_loader.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class DistributorRegister extends StatefulWidget {
  final UserType userType;

  const DistributorRegister({super.key, required this.userType});

  @override
  State<DistributorRegister> createState() => _DistributorRegisterState();
}

class _DistributorRegisterState extends State<DistributorRegister> {
  final controller = Get.put(DistributorRegisterController());
  final RxInt stepIndex = 0.obs;

  // Form keys for each step
  final formKeys = [
    GlobalKey<FormState>(), // Step 0
    GlobalKey<FormState>(), // Step 1
    GlobalKey<FormState>(), // Step 2
    GlobalKey<FormState>(), // Step 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
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
        title: const Text("Distributor Register"),
        backgroundColor: AppColors.off_white,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => Column(
          children: [
            _buildStepIndicator(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                child: _buildStep(stepIndex.value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Step indicator UI
  Widget _buildStepIndicator() {
    return Padding(
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
                    ? AppColors.new_blue
                    : Colors.grey.shade300,
              ),
            ),
          );
        }),
      ),
    );
  }

  /// Handle steps
  Widget _buildStep(int index) {
    switch (index) {
      case 0:
        return _buildBusinessDetails();
      case 1:
        return _buildAadharDetails();
      case 2:
        return _buildPandVerify();
      case 3:
        return _buildBankDetails();
      case 4:
        return _buildKycDetails();
      default:
        return _buildBusinessDetails();
    }
  }

  /// Step 1: Business Details
  Widget _buildBusinessDetails() {
    return _wrapStep(
      step: 0,
      children: [
        _buildTextField(
          icon: Icons.person,
          controller: controller.fullNameController,
          label: "Name",
          hint: "Enter name",
        ),
        _buildTextField(
          icon: Icons.email,

          controller: controller.emailController,
          label: "Email",
          hint: "Enter Email",
        ),

        _buildTextField(
          icon: Icons.mobile_friendly,

          controller: controller.mobileController,
          label: "Mobile Number",
          hint: "Enter Mobile Number",
        ),

        _buildTextField(
          icon: Icons.password,

          controller: controller.mpinController,
          label: "Mpin",
          hint: "Enter Mpin",
        ),

        _buildTextField(
          icon: Icons.lock,

          controller: controller.passwordController,
          label: "Password",
          hint: "Enter Password",
        ),

        _buildTextField(
          icon: Icons.lock,

          controller: controller.confirmPasswordController,
          label: "Confirm Password",
          hint: "Enter Confirm Password",
        ),

        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Business Questions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),

        _buildTextField(
          icon: Icons.question_answer,

          controller: controller.question1Controller,
          label: "How many total retailers?",
          hint: "",
        ),
        _buildTextField(
          icon: Icons.question_answer,

          controller: controller.question2Controller,
          label: "In present partnership with which company?",
          hint: "",
        ),
        _buildTextField(
          icon: Icons.question_answer,

          controller: controller.question3Controller,
          label: "District in which want to become distributor?",
          hint: "",
        ),

        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Business Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),

        _buildTextField(
          icon: Icons.business,

          controller: controller.businessName,
          label: "Business Name",
          hint: "Enter business name",
        ),

        _buildTextField(
          icon: Icons.business,

          controller: controller.businessType,
          label: "Business Tye",
          hint: "Enter business type",
        ),

        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Distributor Additional Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),

        _buildUploadTile(
          title: "Live Photo",
          fileObs: controller.selfieFile,
          onTap: () {
            controller.captureSelfie();
          },
        ),

        _buildUploadTile(
          title: " Office Address Proof(electricity bill/rent agreement)",
          fileObs: controller.addressProof,
          onTap: () {
            controller.pickFile(controller.addressProof);
          },
        ),

        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "References (2 persons)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),

        _buildTextField(
          icon: Icons.person,

          controller: controller.referencePerson1Name,
          label: "First Reference Person Name ",
          hint: "",
        ),

        _buildTextField(
          icon: Icons.mobile_friendly_outlined,

          controller: controller.referencePerson1Mobile,
          label: "First Reference Person Mobile ",
          hint: "",
        ),
        _buildTextField(
          icon: Icons.person,

          controller: controller.referencePerson2name,
          label: "Second Reference Person Name ",
          hint: "",
        ),
        _buildTextField(
          icon: Icons.mobile_friendly,

          controller: controller.referencePerson2Mobile,
          label: "Second Reference Person Mobile ",
          hint: "",
        ),

        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Qualifaction and Experience",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),

        _buildTextField(
          icon: Icons.question_answer,

          controller: controller.qualificationController,
          label: "Education/Qualification (optional)",
          hint: "",
        ),

        _buildTextField(
          icon: Icons.question_answer,

          controller: controller.experienceController,
          label: "Experience in Financial Services (years) *",
          hint: "",
        ),

        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Address",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),

        _buildTextField(
          icon: Icons.location_city,

          controller: controller.pincodeController,
          label: "PinCode",
          hint: "Enter PinCode",
          maxLength: 6,
        ),
        _buildTextField(
          icon: Icons.location_history,

          controller: controller.blockController,
          label: "Block",
          hint: "Enter block name",
        ),
        _buildTextField(
          icon: Icons.location_history,

          controller: controller.countryController,
          label: "Country",
          hint: "Enter Country name",
        ),

        _buildTextField(
          icon: Icons.location_history,

          controller: controller.stateController,
          label: "State",
          hint: "Enter state Name",
        ),
        _buildTextField(
          icon: Icons.location_history,

          controller: controller.cityController,
          label: "City",
          hint: "Enter City Name",
        ),

        _buildTextField(
          icon: Icons.location_history,

          controller: controller.fullAddressController,
          label: "Enter Full Address",
          hint: "Enter full address",
        ),
      ],
      onNext: () {
        controller.registerDestributerApi(stepIndex.value);
      },
    );
  }

  /// Step 2: Address
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
          icon: Icons.person,

          controller: controller.aadhaarController,
          label: "Aadhaar Number",
          maxLength: 12,
          hint: "Enter 12-digit Aadhaar number",
        ),
        const SizedBox(height: 10),
        Obx(
          () => controller.isOtpSending.value
              ? Center(child: appLoader())
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
            icon: Icons.output,

            controller: controller.aadharOtpController,
            label: "Otp",
            hint: "Enter Otp",
          ),
          Obx(
            () => controller.isOtpVerifying.value
                ? Center(child: appLoader())
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
          icon: Icons.numbers,

          controller: controller.bankAccountController,
          label: "Account Number",
          hint: "Enter bank account number",
        ),
        _buildTextField(
          icon: Icons.location_city,

          controller: controller.ifscController,
          label: "IFSC Code",
          hint: "Enter IFSC code",
        ),
        const SizedBox(height: 12),
        Obx(
          () => controller.isLoading.value
              ? Center(child: appLoader())
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
          icon: Icons.info,

          controller: controller.panController,
          label: "PAN Card Number",
          hint: "Enter PAN number",
        ),
        Obx(
          () => controller.isLoading.value
              ? Center(child: appLoader())
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
              ? Center(child: appLoader())
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

  /// Step wrapper
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

  /// TextField builder
  Widget _buildTextField({
    required IconData icon,

    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    int? maxLength,
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
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            maxLength: maxLength,
            decoration: InputDecoration(
              hintText: hint,
              counterText: "",
              hintStyle: TextStyle(fontSize: 12),
              filled: true,
              prefixIcon: Icon(icon, color: AppColors.textColor),
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
              return null;
            },
          ),
        ],
      ),
    );
  }

  /// Upload button builder
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
                      fontSize: 12,
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

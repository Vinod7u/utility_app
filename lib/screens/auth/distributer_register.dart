import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/distributor_register_controller.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_home_page.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
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
        title: const Text("Distributor Register"),
        backgroundColor: Colors.white,
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
        children: List.generate(4, (index) {
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
    );
  }

  /// Handle steps
  Widget _buildStep(int index) {
    switch (index) {
      case 0:
        return _buildBusinessDetails();
      case 1:
        return _buildAddressDetails();
      case 2:
        return _buildReferences();
      case 3:
        return _buildDocuments();
      default:
        return const SizedBox(); // Return an empty widget as a fallback
    }
  }

  /// Step 1: Business Details
  Widget _buildBusinessDetails() {
    return _wrapStep(
      step: 0,
      children: [
        _buildTextField(
          controller: controller.firmNameController,
          label: "Name",
          hint: "Enter name",
        ),
        _buildTextField(
          controller: controller.DsEmailController,
          label: "Email",
          hint: "Enter Email",
        ),

        _buildTextField(
          controller: controller.DSMobile_NumberController,
          label: "Mobile Number",
          hint: "Enter Mobile Number",
        ),

        _buildTextField(
          controller: controller.Mpin,
          label: "Mpin",
          hint: "Enter Mpin",
        ),

        _buildTextField(
          controller: controller.Ds_password,
          label: "Password",
          hint: "Enter Password",
        ),
        _buildTextField(
          controller: controller.Ds_confirm_password,
          label: "Confirm Password",
          hint: "Enter Confirm Password",
        ),
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// Step 2: Address
  Widget _buildAddressDetails() {
    return _wrapStep(
      step: 1,
      children: [
        _buildTextField(
          controller: controller.districtController,
          label: "District",
          hint: "Enter district name",
        ),
        _buildTextField(
          controller: controller.blockController,
          label: "Block",
          hint: "Enter block",
        ),
        _buildTextField(
          controller: controller.stateController,
          label: "State",
          hint: "Enter state",
        ),
        _buildTextField(
          controller: controller.subscriptionPlanController,
          label: "Subscription Plan",
          hint: "Enter subscription plan",
        ),
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// Step 3: References
  Widget _buildReferences() {
    return _wrapStep(
      step: 2,
      children: [
        _buildTextField(
          controller: controller.Qus1Controller,
          label: "How many total retailers?",
          hint: "",
        ),
        _buildTextField(
          controller: controller.Qus2Controller,
          label: "In present partnership with which company?",
          hint: "",
        ),
        _buildTextField(
          controller: controller.Qus3Controller,
          label: "District in which want to become distributor?",
          hint: "",
        ),

        // _buildTextField(
        //   controller: controller.qualificationController,
        //   label: "Qualification",
        //   hint: "Enter qualification",
        // ),
        // _buildTextField(
        //   controller: controller.experienceController,
        //   label: "Experience",
        //   hint: "Enter experience",
        // ),
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// Step 4: Documents + Terms
  Widget _buildDocuments() {
    return _wrapStep(
      step: 3,
      children: [
        _buildTextField(
          controller: controller.aadhaarController,
          label: "Aadhaar Number",
          hint: "",
        ),
        _buildUploadTile(
          title: "Upload Aadhaar",
          fileObs: controller.aadhaarFile,
          onTap: () => controller.pickFile(controller.aadhaarFile),
        ),
        _buildUploadTile(
          title: "Upload PAN",
          fileObs: controller.panFile,
          onTap: () => controller.pickFile(controller.panFile),
        ),
        _buildUploadTile(
          title: "Upload Bank Proof",
          fileObs: controller.bankFile,
          onTap: () => controller.pickFile(controller.bankFile),
        ),
        _buildUploadTile(
          title: "Capture Selfie",
          fileObs: controller.selfieFile,
          onTap: controller.captureSelfie,
          isImagePreview: true,
        ),
        const SizedBox(height: 12),
        Obx(
          () => CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primaryC,
            title: const Text("I accept Terms & Conditions"),
            value: controller.acceptedTerms.value,
            onChanged: controller.toggleTerms,
          ),
        ),
        const SizedBox(height: 20),
      ],
      onNext: () {
        if (!controller.acceptedTerms.value) {
          showSnackBar(
            title: "Error",
            message: "Please accept Terms & Conditions",
          );
        } else if (controller.aadhaarFile.value == null ||
            controller.panFile.value == null ||
            controller.bankFile.value == null ||
            controller.selfieFile.value == null) {
          showSnackBar(
            title: "Error",
            message: "Please upload all required documents",
          );
        } else {
          Get.to(() => UserHomePage());
        }
      },
      isLast: true,
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
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
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
            controller: controller,
            obscureText: obscureText,
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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/user_register_controller.dart';
import 'package:utility_app_flutter/screens/home/home_page.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class UserRegister extends StatefulWidget {
  final UserType userType;

  const UserRegister({super.key, required this.userType});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final controller = Get.put(UserRegisterController());
  final RxInt stepIndex = 0.obs; // Track current step

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            if (stepIndex.value > 0) {
              stepIndex.value--;
            } else {
              Get.back();
            }
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Register"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => Column(
          children: [
            // 🔹 Step Indicator
            Padding(
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
            ),

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

  /// 🔹 Handle each step UI
  Widget _buildStep(int index) {
    switch (index) {
      case 0:
        return _buildUserDetails();
      case 1:
        return _buildAddressDetails();
      case 2:
        return _buildIdentityDetails();
      case 3:
        return _buildBankDetails();
      default:
        return _buildUserDetails();
    }
  }

  /// Step 1: User details
  Widget _buildUserDetails() {
    return _wrapStep(
      children: [
        _buildTextField(
          controller: controller.fullNameController,
          label: "Full Name",
          hint: "Enter full name",
        ),
        _buildTextField(
          controller: controller.mobileController,
          label: "Mobile Number",
          hint: "Enter mobile number",
        ),
        _buildTextField(
          controller: controller.emailController,
          label: "Email",
          hint: "Enter email",
        ),
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// Step 2: Address
  Widget _buildAddressDetails() {
    return _wrapStep(
      children: [
        _buildTextField(
          controller: controller.streetController,
          label: "Street Name",
          hint: "Enter street name",
        ),
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
          controller: controller.pincodeController,
          label: "Pin Code",
          hint: "Enter pin code",
        ),
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// Step 3: Aadhaar + PAN
  Widget _buildIdentityDetails() {
    return _wrapStep(
      children: [
        _buildTextField(
          controller: controller.aadhaarController,
          label: "Aadhaar Number",
          hint: "Enter Aadhaar number",
        ),
        _buildUploadTile(
          title: "Upload Aadhaar",
          fileObs: controller.aadhaarFile,
          onTap: () => controller.pickFile(controller.aadhaarFile),
        ),
        _buildTextField(
          controller: controller.panController,
          label: "PAN Card Number",
          hint: "Enter PAN number",
        ),
        _buildUploadTile(
          title: "Upload PAN",
          fileObs: controller.panFile,
          onTap: () => controller.pickFile(controller.panFile),
        ),
      ],
      onNext: () => stepIndex.value++,
    );
  }

  /// Step 4: Bank + Selfie
  Widget _buildBankDetails() {
    return _wrapStep(
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
        _buildUploadTile(
          title: "Upload Bank Proof (Cheque/Passbook)",
          fileObs: controller.bankFile,
          onTap: () => controller.pickFile(controller.bankFile),
        ),
        _buildUploadTile(
          title: "Capture Selfie",
          fileObs: controller.selfieFile,
          onTap: controller.captureSelfie,
          isImagePreview: true,
        ),
        _buildTextField(
          controller: controller.nomineeController,
          label: "Nominee",
          hint: "Enter nominee name",
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
        if (controller.acceptedTerms.value) {
          Get.to(() => HomePage(userType: widget.userType));
        } else {
          Get.snackbar("Error", "Please accept Terms & Conditions");
        }
      },
      isLast: true,
    );
  }

  /// 🔹 Step Wrapper with Next Button
  Widget _wrapStep({
    required List<Widget> children,
    required VoidCallback onNext,
    bool isLast = false,
  }) {
    return Padding(
      key: ValueKey(children.hashCode), // Important for animation
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(child: Column(children: children)),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    isLast ? "Register" : "Next",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 TextField Builder
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
            validator: (value) =>
                value == null || value.isEmpty ? 'Please enter $label' : null,
          ),
        ],
      ),
    );
  }

  /// 🔹 Upload Button Builder
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

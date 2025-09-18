import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/user_register_controller.dart';
import 'package:utility_app_flutter/screens/home/home_page.dart';
import 'package:utility_app_flutter/utils/appcolors.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class UserRegister extends StatefulWidget {
  final UserType userType;

  const UserRegister({super.key, required this.userType});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final controller = Get.put(UserRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Register"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            _buildTextField(
              controller: controller.aadhaarController,
              label: "Aadhaar Number",
              hint: "Enter Aadhaar number",
            ),
            _buildTextField(
              controller: controller.panController,
              label: "PAN Card Number",
              hint: "Enter PAN number",
            ),
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
            _buildTextField(
              controller: controller.nomineeController,
              label: "Nominee",
              hint: "Enter nominee name",
            ),
            const SizedBox(height: 20),

            // 🔹 Upload Section
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Upload Documents",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

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
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
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

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    Get.to(() => HomePage(userType: widget.userType));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // important for gradient
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.transparent, // no flat color
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
                    child: const Text(
                      "Register",
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

            const SizedBox(height: 20),
          ],
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
                borderSide: const BorderSide(
                  color: Color(0xFF667eea),
                  width: 2,
                ),
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

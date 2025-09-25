import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

import '../../controller/retailer_register_controller.dart';
import '../../utils/Validators/validators.dart';
import '../../utils/utils.dart';
import '../../widgets/app_button.dart';
import '../../widgets/snackbar.dart';
import '../home/usersection/user_home_page.dart';

class RetailerRegister extends StatefulWidget {
  final UserType userType;
  RetailerRegister({super.key, required this.userType});

  @override
  State<RetailerRegister> createState() => _RetailerRegisterState();
}

class _RetailerRegisterState extends State<RetailerRegister> {
  final controller = Get.put(RetailerRegisterController());

  // 🔹 Form keys for validation in each step
  final formKeys = [
    GlobalKey<FormState>(), // Step 0
    GlobalKey<FormState>(), // Step 1
    GlobalKey<FormState>(), // Step 2
    GlobalKey<FormState>(), // Step 3
    GlobalKey<FormState>(), // Step 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: controller.stepIndex.value > 0
            ? InkWell(
                onTap: () {
                  if (controller.stepIndex.value > 0) {
                    controller.stepIndex.value--;
                  } else {
                    Get.back();
                  }
                },
                child: const Icon(Icons.arrow_back_ios, color: Colors.black),
              )
            : null, // No leading icon when stepIndex == 0
        centerTitle: true,
        surfaceTintColor: Colors.white,
        title: const Text("Register"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primaryC),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Step Indicator
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
                        color: controller.stepIndex.value >= index
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
                child: _buildStep(controller.stepIndex.value),
              ),
            ),
          ],
        );
      }),
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
      case 4:
        return _buildKycDetails();
      default:
        return _buildUserDetails();
    }
  }

  Widget _buildUserDetails() {
    return _wrapStep(
      step: 0,
      children: [
        _buildTextField(
          controller: controller.nameC,
          label: "Full Name",
          hint: "Enter full name",
        ),
        _buildTextField(
          controller: controller.phoneC,
          label: "Mobile Number",
          maxL: 10,
          hint: "Enter 10-digit mobile number",
        ),
        _buildTextField(
          controller: controller.emailC,
          label: "Email",
          hint: "Enter email",
          validator: Validators.validateEmail,
        ),

        //_buildDropDownTile(title: 'Role', label: 'Select Role'),
        _buildTextField(
          controller: controller.mPinC,
          label: "MPIN",
          obscureText: true,
          maxL: 6,
          hint: "",
        ),
        _buildTextField(
          controller: controller.passC,
          label: "Password",
          obscureText: true,
          hint: "",
          validator: Validators.validatePassword,
        ),
        _buildTextField(
          controller: controller.confirmPassC,
          label: "Confirm Password",
          obscureText: true,
          hint: "",
          validator: Validators.validateEmail,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Retailer Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 10),
        _buildTextField(
          controller: controller.shopNameC,
          label: "Shop Name",
          hint: "Enter Shop name",
        ),

        _buildDropDownTile(title: 'Select Role', label: 'Shop Type'),
        _buildUploadTile(
          title: "Upload Shop Photos",
          fileObs: controller.shopPhotoFile,
          onTap: () => controller.pickFile(controller.shopPhotoFile),
        ),

        _buildUploadTile(
          title: "Upload Owner Photo",
          fileObs: controller.ownerPhotoFile,
          onTap: () => controller.pickFile(controller.ownerPhotoFile),
        ),

        _buildUploadTile(
          title: "Shop Address Proof (utility bill, license etc.) ",
          fileObs: controller.addressProofFile,
          onTap: () => controller.pickFile(controller.addressProofFile),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Address Information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        _buildTextField(
          controller: controller.stateC,
          label: "State Name",
          hint: "Enter State name",
        ),
        _buildTextField(
          controller: controller.districtC,
          label: "District Name",
          hint: "Enter district name",
        ),
        _buildTextField(
          controller: controller.pinCodeC,
          label: "Pin Code",
          maxL: 6,
          hint: "Enter 6-digit pin code",
        ),
        _buildTextField(
          controller: controller.addressC,
          label: "Full Address",
          hint: "Enter Full Address",
        ),
      ],
      onNext: () async {
        // final success = await controller.createRetailerApi();
        // if (success) {
        //   print('Sucessss');
        //   controller.stepIndex.value++;// ✅ Only go to next step if API success
        // }
        controller.stepIndex.value++;
      },
    );
  }

  /// Step 2: Address
  Widget _buildAddressDetails() {
    return _wrapStep(
      step: 1,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Aadhaar Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Verify Aadhaar and review the details',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 10),
        _buildTextField(
          controller: controller.aadhaarController,
          label: "Aadhaar Number",
          maxL: 12,
          hint: "Enter 12-digit Aadhaar number",
        ),
        SizedBox(height: 10),

        appButton(
          title: 'Send Otp',
          onTap: () async {
            if (controller.aadhaarController.text.length == 12) {
              await controller.sendAadhaarOtpApi();
            } else {
              showSnackBar(
                title: "Error",
                message: "Enter a valid 12-digit Aadhaar number",
              );
            }
            //controller.isAadhaarVerify.value = true;
          },
        ),
        SizedBox(height: 10),
        // if(controller.isAadhaarVerify.value)
        // _buildUploadTile(
        //   title: "Upload Aadhaar",
        //   fileObs: controller.aadhaarFile,
        //   onTap: () => controller.pickFile(controller.aadhaarFile),
        // ),
        if (controller.isAadhaarVerify.value)
          _buildTextField(
            controller: controller.otpC,
            label: "Otp",
            maxL: 6,
            hint: "Enter Otp",
          ),
        if (controller.isAadhaarVerify.value)
          Obx(() {
            if (controller.isLoadingVerifyOtp.value) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryC),
              );
            }
            return appButton(
              title: 'Verify Otp',
              onTap: () async {
                if (controller.otpC.text.isNotEmpty ||
                    controller.otpC.text.length == 6) {
                  await controller.verifyAadhaarOtpApi();
                } else {
                  showSnackBar(
                    title: "Error",
                    message: "Enter a valid 12-digit Aadhaar number",
                  );
                }
                //controller.isAadhaarVerify.value = true;
              },
            );
          }),
      ],
      onNext: () {
        if (formKeys[controller.stepIndex.value].currentState!.validate()) {
        } else {
          controller.stepIndex.value++;
        }
      },
    );
  }

  /// Step 3: Aadhaar + PAN
  Widget _buildIdentityDetails() {
    return _wrapStep(
      step: 2,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'PAN Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Verify PAN and review the details',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 10),
        _buildTextField(
          controller: controller.panController,
          label: "PAN Card Number",
          hint: "Enter PAN number",
          validator: Validators.validatePan,
        ),

        // _buildUploadTile(
        //   title: "Upload PAN",
        //   fileObs: controller.panFile,
        //   onTap: () => controller.pickFile(controller.panFile),
        // ),
        Obx(() {
          if (controller.isLoadingOtp.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryC),
            );
          }
          return appButton(
            title: 'Verify Pan',
            onTap: () async {
              if (formKeys[controller.stepIndex.value].currentState!
                  .validate()) {
                await controller.verifyPanOtpApi();
              } else {
                showSnackBar(
                  title: "Error",
                  message: "Enter a valid Pan number",
                );
              }
              //controller.isAadhaarVerify.value = true;
            },
          );
        }),
        SizedBox(height: 10),
      ],
      onNext: () {
        controller.stepIndex.value++;
        // if (controller.aadhaarFile.value == null ||
        //     controller.panFile.value == null) {
        //   Get.snackbar("Error", "Please upload Aadhaar and PAN files");
        // } else {
        //   stepIndex.value++;
        // }
      },
    );
  }

  /// Step 4: Bank + Selfie
  Widget _buildBankDetails() {
    return _wrapStep(
      step: 3,
      children: [
        _buildTextField(
          controller: controller.bankAccountController,
          label: "Bank Account Number",
          maxL: 14,
          hint: "Enter bank account number",
          //validator: Validators
        ),
        _buildTextField(
          controller: controller.ifscController,
          label: "IFSC Code",
          maxL: 11,
          hint: "Enter IFSC code",
        ),

        // _buildUploadTile(
        //   title: "Upload Bank Proof (Cheque/Passbook)",
        //   fileObs: controller.bankFile,
        //   onTap: () => controller.pickFile(controller.bankFile),
        // ),
        // _buildUploadTile(
        //   title: "Capture Selfie",
        //   fileObs: controller.selfieFile,
        //   onTap: controller.captureSelfie,
        //   isImagePreview: true,
        // ),
        // _buildTextField(
        //   controller: controller.nomineeController,
        //   label: "Nominee",
        //   hint: "Enter nominee name",
        // ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoadingOtp.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryC),
            );
          }
          return appButton(
            title: 'Verify Bank',
            onTap: () async {
              if (formKeys[controller.stepIndex.value].currentState!
                  .validate()) {
                // await controller.verifyBankApi();
              } else {
                showSnackBar(title: "Error", message: "Enter a valid Details");
              }
              //controller.isAadhaarVerify.value = true;
            },
          );
        }),
        // Obx(
        //   () => CheckboxListTile(
        //     controlAffinity: ListTileControlAffinity.leading,
        //     activeColor: AppColors.primaryC,
        //     title: const Text("I accept Terms & Conditions"),
        //     value: controller.acceptedTerms.value,
        //     onChanged: controller.toggleTerms,
        //   ),
        // ),
        const SizedBox(height: 20),
      ],
      onNext: () {
        controller.stepIndex.value++;
        // if (!controller.acceptedTerms.value) {
        //   Get.snackbar("Error", "Please accept Terms & Conditions");
        // } else if (controller.bankFile.value == null ||
        //     controller.selfieFile.value == null) {
        //   Get.snackbar("Error", "Please upload bank proof and selfie");
        // } else {
        //   Get.to(() => HomePage(userType: widget.userType));
        // }
      },
      isLast: false,
    );
  }

  /// Step 5: Bank + Selfie
  Widget _buildKycDetails() {
    return _wrapStep(
      step: 4,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Submit KYC',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Everything looks good -- submit your KYC',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),

        SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Submit KYC',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Review Completed. Click below to submit your KYC',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),

        // _buildUploadTile(
        //   title: "Upload Bank Proof (Cheque/Passbook)",
        //   fileObs: controller.bankFile,
        //   onTap: () => controller.pickFile(controller.bankFile),
        // ),
        // _buildUploadTile(
        //   title: "Capture Selfie",
        //   fileObs: controller.selfieFile,
        //   onTap: controller.captureSelfie,
        //   isImagePreview: true,
        // ),
        // _buildTextField(
        //   controller: controller.nomineeController,
        //   label: "Nominee",
        //   hint: "Enter nominee name",
        // ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoadingOtp.value) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryC),
            );
          }
          return appButton(
            title: 'Submit KYC',
            onTap: () async {
              if (formKeys[controller.stepIndex.value].currentState!
                  .validate()) {
                // await controller.verifyBankApi();
              } else {
                showSnackBar(title: "Error", message: "Enter a valid Details");
              }
              //controller.isAadhaarVerify.value = true;
            },
          );
        }),
        // Obx(
        //   () => CheckboxListTile(
        //     controlAffinity: ListTileControlAffinity.leading,
        //     activeColor: AppColors.primaryC,
        //     title: const Text("I accept Terms & Conditions"),
        //     value: controller.acceptedTerms.value,
        //     onChanged: controller.toggleTerms,
        //   ),
        // ),
        const SizedBox(height: 20),
      ],
      onNext: () {
        // if (!controller.acceptedTerms.value) {
        //   Get.snackbar("Error", "Please accept Terms & Conditions");
        // } else if (controller.bankFile.value == null ||
        //     controller.selfieFile.value == null) {
        //   Get.snackbar("Error", "Please upload bank proof and selfie");
        // } else {
        //   Get.to(() => HomePage(userType: widget.userType));
        // }
      },
      isLast: true,
    );
  }

  /// 🔹 Step Wrapper with Validation
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
            if (controller.initialButtonShow.value)
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.primaryC),
                  );
                }
                return appButton(
                  title: isLast ? "Register" : "Next",
                  onTap: () async {
                    onNext();
                    // if (formKeys[step].currentState!.validate()) {
                    //   if (step == 0) {
                    //     if (controller.shopPhotoFile.value == null) {
                    //       showSnackBar(
                    //         title: "Error",
                    //         message: "Please upload shop photo",
                    //       );
                    //       return;
                    //     }
                    //     if (controller.ownerPhotoFile.value == null) {
                    //       showSnackBar(
                    //         title: "Error",
                    //         message: "Please upload owner photo",
                    //       );
                    //       return;
                    //     }
                    //     if (controller.addressProofFile.value == null) {
                    //       showSnackBar(
                    //         title: "Error",
                    //         message: "Please upload address proof",
                    //       );
                    //       return;
                    //     }
                    //     print("Index = ${step}");
                    //     // 👇 Call API when Address Details step is completed
                    //     // final success = await controller.createRetailerApi();
                    //     // if (success) {
                    //     //   print('Sucessss12');
                    //     //   onNext(); // ✅ Only go to next step if API success
                    //     // }
                    //     //onNext();
                    //   }
                    //   if (step == 1) {
                    //     print("Index = 1");
                    //     // 👇 Call API when Address Details step is completed
                    //     //await controller.sendAadhaarOtpApi();
                    //    // onNext();
                    //   }
                    //   if (step == 2) {
                    //     print("Index = 2");
                    //     // 👇 Call API when Address Details step is completed
                    //     //await controller.sendAadhaarOtpApi();
                    //     onNext();
                    //   }
                    //   if (step == 3) {
                    //     // print("Index = 3");
                    //     // // 👇 Call API when Address Details step is completed
                    //     // await controller.verifyBankApi();
                    //     onNext();
                    //   } else {
                    //     onNext();
                    //   }
                    // } else {
                    //   showSnackBar(
                    //     title: "Error",
                    //     message: "Please fill all required fields",
                    //   );
                    // }
                  },
                );
              }),
            const SizedBox(height: 20),
          ],
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
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLength: maxL,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType:
              label.contains("Mobile") ||
                  label.contains('Pin') ||
                  label.contains('Aadhaar') ||
                  label.contains('MPIN') ||
                  label.contains('Otp')
              ? TextInputType.phone
              : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            counterText: '',
            fillColor: const Color(0xFFf9fafb),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFe5e7eb), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
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
            if (label == "Email" &&
                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return "Enter a valid email address";
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
            if (label == "IFSC Code" &&
                !RegExp(
                  r'^[A-Z]{4}0[A-Z0-9]{6}$',
                ).hasMatch(value.toUpperCase())) {
              return "Enter a valid IFSC code";
            }
            if (label == "Account Number" &&
                !RegExp(r'^[0-9]{9,18}$').hasMatch(value)) {
              return "Enter a valid account number (9–18 digits)";
            }
            if (label == "Password" &&
                !RegExp(
                  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
                ).hasMatch(value)) {
              return "Password must be at least 8 chars, include upper, lower, number & special char";
            }
            if (label == "Confirm Password" &&
                !RegExp(
                  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
                ).hasMatch(value)) {
              return "Password must be at least 8 chars, include upper, lower, number & special char";
            }

            return null;
          },
        ),
        const SizedBox(height: 10),
      ],
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

  Widget _buildDropDownTile({required String title, required String label}) {
    return Obx(
      () => Column(
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
          const SizedBox(height: 10),
          InputDecorator(
            decoration: InputDecoration(
              hintText: title,
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
                horizontal: 10,
                vertical: 12,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                value: controller.selectedValue.value.isEmpty
                    ? null
                    : controller.selectedValue.value,
                hint: const Text(
                  'Select Type',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                items: controller.items
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  controller.selectedValue.value = value!;
                },
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }



}

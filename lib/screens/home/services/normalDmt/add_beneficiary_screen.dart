import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/dmt/benficiary_add_controller.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';

class AddBeneficiaryScreen extends StatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  final controller = Get.put(BenficiaryAddController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SingleChildScrollView(child: _buildBodySection()),
    );
  }

  Widget _buildBodySection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: controller.nameController,
            hint: "Enter Name",
            label: "Beneficiary Name",
          ),
          _buildDropDownTile(
            label: "Bank Name",
            items: controller.bankName,
            selectedValue: controller.selectedBank,
          ),

          _buildTextField(
            controller: controller.accountNumberController,
            hint: "Enter Account Number",
            label: "Account Number",
          ),

          _buildTextField(
            controller: controller.ifscController,
            hint: "Enter Ifsc Number",
            label: "Ifsc Number",
          ),

          _buildDropDownTile(
            label: "Gst State Name",
            items: controller.stateName,
            selectedValue: controller.selectedGstState,
          ),

          _buildTextField(
            controller: controller.dobController,
            hint: "Enter DOB",
            label: "Dob",
          ),

          _buildTextField(
            controller: controller.pincodeController,
            hint: "Enter Pincode",
            label: "Pincode",
          ),

          _buildTextField(
            controller: controller.addressController,
            hint: "Enter address",
            label: "Address",
          ),

          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Obx(
              () => CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: controller.isDefault.value,
                onChanged: (val) => controller.isDefault.value = val ?? false,
                title: const Text("Verified Beneficiary"),
                controlAffinity: ListTileControlAffinity.leading,
                selectedTileColor: AppColors.darkColor,
                activeColor: AppColors.darkColor,
              ),
            ),
          ),

          SizedBox(height: 20),
          appButton(title: "Add Beneficiary", onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildDropDownTile({
    required String label,
    required List<String> items,
    required RxString selectedValue,
  }) {
    return Obx(
      () => Column(
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
          DropdownButtonFormField<String>(
            value: selectedValue.value.isNotEmpty ? selectedValue.value : null,
            hint: Text("Select $label"),
            onChanged: (val) {
              if (val != null) selectedValue.value = val;
            },
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? label,
    required String hint,
    bool obscureText = false,
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
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.textfield_inside_color,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

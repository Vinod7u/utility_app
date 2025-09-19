import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

import '../../controller/retailer_register_controller.dart';

class RetailerRegister extends StatefulWidget {
  const RetailerRegister({super.key});

  @override
  State<RetailerRegister> createState() => _RetailerRegisterState();
}

class _RetailerRegisterState extends State<RetailerRegister> {
  final controller = Get.put(RetailerRegisterController());
  final List<String> items = [
    'Retailer',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Retailer Register', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: controller.nameC,
              label: ' Full Name',
              hint: 'Enter Your Name',
            ),
            _buildTextField(
              controller: controller.phoneC,
              label: 'Mobile Number',
              hint: 'Enter Your Phone',
            ),
            _buildTextField(
              controller: controller.emailC,
              label: 'Email',
              hint: 'Enter Your Email',
            ),

            _buildDropDownTile(title: controller.selectedValue.value),
            /*InputDecorator(
              decoration: InputDecoration(
                hintText: 'Role',
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
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  value: selectedValue,
                  hint: const Text(
                    'Select Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  items: items
                      .map(
                        (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
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
            ),*/
            _buildTextField(
              controller: controller.shopNameC,
              label: 'MPIN',
              hint: 'Enter MPIN',
            ),
            _buildTextField(
              controller: controller.shopNameC,
              label: 'Password',
              hint: 'Confirm Password',
            ),
            _buildTextField(
              controller: controller.shopNameC,
              label: 'Shop Name',
              hint: 'Enter Shop Name',
            ),
           /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: InputDecorator(
                decoration: InputDecoration(
                  hintText: 'Select Type',
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
                    value: selectedValue,
                    hint: const Text(
                      'Select Type',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    items: items
                        .map(
                          (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
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
            ),*/

            _buildDropDownTile(title: controller.selectedShop.value),
            /*Card(
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

                    // _buildUploadTile(
                    //   title: "Upload Aadhaar",
                    //   fileObs: controller.aadhaarFile,
                    //   onTap: () => controller.pickFile(controller.aadhaarFile),
                    // ),
                    // _buildUploadTile(
                    //   title: "Upload PAN",
                    //   fileObs: controller.panFile,
                    //   onTap: () => controller.pickFile(controller.panFile),
                    // ),
                    _buildUploadTile(
                      title: "Upload Shop Photos",
                      fileObs: controller.bankFile,
                      onTap: () => controller.pickFile(controller.bankFile),
                    ),
                    _buildUploadTile(
                      title: "Shop Address Proof",
                      fileObs: controller.selfieFile,
                      onTap: controller.captureSelfie,
                      isImagePreview: true,
                    ),
                    _buildUploadTile(
                      title: "Upload Owner Photo",
                      fileObs: controller.selfieFile,
                      onTap: controller.captureSelfie,
                      isImagePreview: true,
                    ),
                  ],
                ),
              ),
            ),*/
            _buildTextField(
              controller: controller.nameC,
              label: 'PinCode',
              hint: 'Enter PinCode',
            ),
            _buildDropDownTile(title: controller.selectedShop.value),
            _buildTextField(
              controller: controller.nameC,
              label: 'State',
              hint: '',
            ),
            _buildTextField(
              controller: controller.nameC,
              label: 'City/District',
              hint: '',
            ),
            _buildDropDownTile(title: controller.selectedShop.value),
            _buildTextField(
              controller: controller.nameC,
              label: 'Full Address',
              hint: 'Full Address',
            ),

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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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

  Widget _buildDropDownTile({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 10),
      child: Obx(
            () => InputDecorator(
          decoration: InputDecoration(
            hintText: 'Select Type',
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
              items: items
                  .map(
                    (String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
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
      ),
    );
  }

}

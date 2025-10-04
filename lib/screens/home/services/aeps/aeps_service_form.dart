import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/aeps/aeps_service_form.dart';
import 'package:utility_app_flutter/screens/home/services/aeps/aeps_service_result_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_home_page.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';

class AepsServiceForm extends StatefulWidget {
  final String serviceName;
  const AepsServiceForm({super.key, required this.serviceName});

  @override
  State<AepsServiceForm> createState() => _AepsServiceFormState();
}

class _AepsServiceFormState extends State<AepsServiceForm> {
  final controller = Get.put(AepsServiceFormController());

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
                  _buildSecondSection(),
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
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
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
            "Aadhar Enabled Payment System",
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
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.blue_shade,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Status: Accepted",
                  style: TextStyle(color: AppColors.darkColor),
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.blue_shade,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Activation: Activated",
                  style: TextStyle(color: AppColors.darkColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecondSection() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "${widget.serviceName} Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          SizedBox(height: 12),
          Text(
            "Verify your details before process",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          SizedBox(height: 16),

          // Aadhar Number
          _buildTextField(
            controller: controller.aadharNumberController,
            hint: "Enter aadhar number",
            label: "Aadhar Number",
          ),

          // Mobile Number
          _buildTextField(
            controller: controller.mobileNumberController,
            hint: "Enter mobile number",
            label: "Mobile Number",
          ),

          // Bank Dropdown
          _buildDropDownTile(
            title: "Select Bank",
            label: "Bank Name",
            items: controller.bank,
            selectedValue: controller.selectedBank,
          ),

          // Amount (only for cash withdrawal)
          if (widget.serviceName.toLowerCase() == "cash withdrawal")
            _buildTextField(
              controller: controller.amountNumberController,
              hint: "Enter amount",
              label: "Amount",
            ),

          // Remark
          _buildTextField(
            controller: controller.remarkNumberController,
            hint: "Enter remark",
            label: "Remark",
          ),

          SizedBox(height: 16),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // App Button
              Expanded(
                child: appButton(
                  title: "Confirm & Proceed",
                  onTap: () {
                    Get.to(
                      () => AepsServiceResultScreen(
                        serviceName: widget.serviceName,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 16),
              // Outlined Button
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.offAll(
                        () => UserHomePage(),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.darkColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.darkColor,
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

  Widget _buildDropDownTile({
    required String title,
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
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            hint: Text(title),
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

  Widget _buildThirdSection() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.blue_shade,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Center(
        child: Text(
          "Complete registration to access AEPS services",
          style: TextStyle(color: AppColors.darkColor),
        ),
      ),
    );
  }
}

/// GetX Controller

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/services/loan_controller.dart';
import 'package:utility_app_flutter/screens/home/reports/loans_report.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';

class LoansServicesScreen extends StatefulWidget {
  final String serviceName;
  const LoansServicesScreen({super.key, required this.serviceName});

  @override
  State<LoansServicesScreen> createState() => _LoansServicesScreenState();
}

class _LoansServicesScreenState extends State<LoansServicesScreen> {
  late LoanController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoanController()); // inject GetX controller
  }

  @override
  void dispose() {
    Get.delete<LoanController>(); // clean up controller when leaving screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(widget.serviceName),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      _buildTextField("Full Name", controller.nameController),
                      _buildTextField(
                        "Mobile No.",
                        controller.mobileController,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        "Email",
                        controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _buildTextField(
                        "Aadhar No.",
                        controller.aadharController,
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField("PAN No.", controller.panController),
                      _buildTextField(
                        "Loan Amount",
                        controller.amountController,
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField(
                        "Duration (Months)",
                        controller.durationController,
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField(
                        "Purpose",
                        controller.purposeController,
                        maxLines: 3,
                      ),

                      const SizedBox(height: 20),

                      // 🔹 Upload Aadhar
                      Obx(
                        () => _buildDocUploadSection(
                          title: "Upload Aadhar Card",
                          filePath: controller.aadharDoc.value,
                          onTap: () => controller.pickDocument("aadhar"),
                        ),
                      ),

                      // 🔹 Upload PAN
                      Obx(
                        () => _buildDocUploadSection(
                          title: "Upload PAN Card",
                          filePath: controller.panDoc.value,
                          onTap: () => controller.pickDocument("pan"),
                        ),
                      ),

                      const SizedBox(height: 30),
                      appButton(
                        title: "Submit",
                        onTap: () {
                          controller.submitLoan();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ----------------- TEXT FIELD -----------------
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "$label is required" : null,
      ),
    );
  }

  /// ----------------- DOC UPLOAD -----------------
  Widget _buildDocUploadSection({
    required String title,
    required String? filePath,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  filePath ?? title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: filePath == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              const Icon(Icons.upload_file, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  /// ----------------- APP BAR -----------------
  Widget _buildCustomAppBar(String serviceName) {
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
                  child: _buildAppBarIcon(Icons.arrow_back_ios, () {
                    Get.back();
                  }),
                ),
                Text(
                  serviceName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: _buildAppBarIcon(Icons.report, () {
                    Get.to(() => LoanReportScreen());
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }



}

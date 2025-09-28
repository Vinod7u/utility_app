import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class BillDetailsScreen extends StatefulWidget {
  final String serviceName;
  final Map<String, dynamic> formData;
  
  const BillDetailsScreen({
    super.key,
    required this.serviceName,
    required this.formData,
  });

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

class _BillDetailsScreenState extends State<BillDetailsScreen> {
  String selectedPaymentMode = "Cash";
  List<String> paymentModes = ["Cash", "Card", "UPI", "Net Banking"];
  bool isProcessingPayment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: _buildBillContent(),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- APP BAR ----------------
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
                // Back Icon
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
                // Center Title
                Text(
                  widget.serviceName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                // Help Icon
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

  Widget _buildBillContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Details Header
          Text(
            "Details",
            style: TextStyle(
              color: AppColors.new_blue,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: AppColors.appbarFirstColor),
          const SizedBox(height: 10),

          // Bill Details
          _buildDetailRow("Name", "B-COnnect"),
          _buildDetailRow("Bill Number", _generateBillNumber()),
          _buildDetailRow("Bill Amt. Payable", "₹ 1000"),
          _buildDetailRow("Bill Date", _getCurrentDate()),
          _buildDetailRow("Bill Due Date", _getCurrentDate()),
          _buildDetailRow("Bill Period", _getCurrentMonth()),
          _buildDetailRow("Amount", "₹ 1000"),
          _buildDetailRow("Customer Mobile No", widget.formData['Mobile Number of Parent'] ?? "9620619244"),
          _buildDetailRow("Customer Convenience Fee", "0.00"),
          
          const SizedBox(height: 20),
          
          // Payment Mode Dropdown
          _buildPaymentModeDropdown(),

          const SizedBox(height: 30),

          // Pay Bill Button
          _buildPayBillButton(),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.new_blue,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentModeDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Payment Mode",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
        Container(
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.new_blue, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              value: selectedPaymentMode,
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down, color: AppColors.new_blue),
                iconSize: 18,
              ),
              style: TextStyle(
                color: AppColors.new_blue,
                fontSize: 14,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                elevation: 0,
                maxHeight: 200,
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 12),
              ),
              items: paymentModes
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.new_blue,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPaymentMode = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPayBillButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.new_blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: isProcessingPayment ? null : _handlePayment,
        child: isProcessingPayment
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Processing...",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : const Text(
                "Pay Bill",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  void _handlePayment() async {
    setState(() {
      isProcessingPayment = true;
    });

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isProcessingPayment = false;
    });

    // Show success message
    Get.snackbar(
      "Payment Successful",
      "Payment of ₹1000 via $selectedPaymentMode processed successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );

    // Navigate back or to success screen after a delay
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }

  String _generateBillNumber() {
    // Generate a random bill number
    final now = DateTime.now();
    return "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.millisecond}";
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  String _getCurrentMonth() {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[DateTime.now().month - 1];
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this to pubspec.yaml: flutter_svg: ^2.0.9
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/Constants/appimage.dart';

class FasttagScreen extends StatefulWidget {
  const FasttagScreen({super.key});

  @override
  State<FasttagScreen> createState() => _FasttagScreenState();
}

class _FasttagScreenState extends State<FasttagScreen> {
  final List<Map<String, String>> banks = [
    {"name": "HDFC Bank", "logo": Appimage.hdfc},
    {"name": "ICICI Bank", "logo": Appimage.icici},
    {"name": "State Bank of India", "logo": Appimage.sbi},
  ];

  final List<Map<String, String>> electricitybill = [
    {"name": "JVVNL", "logo": Appimage.hdfc},
    {"name": "Avvnl", "logo": Appimage.icici},
    {"name": "BESL", "logo": Appimage.sbi},
    {"name": "BKSEL", "logo": Appimage.sbi},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.off_white,
        body: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  // Input row with proper padding
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Vehicle Number",
                              hintStyle: TextStyle(fontSize: 14),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: AppColors.appbarFirstColor,
                                  width: 1.5,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Proceed button with fixed width for better alignment
                        SizedBox(
                          width: 100,
                          child: GestureDetector(
                            onTap: () {
                              // Add vehicle number validation and navigation logic here
                              print("Proceed tapped");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_offer,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "offer",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Top banks (first 4)
                  _buildContent(
                    onTap: (bankName) {
                      // Handle bank selection, e.g., navigate to recharge
                      print("Selected: $bankName");
                    },
                    title: "Top FastTag Bank",
                    bankList: banks.take(4).toList(), // Limit to top 4
                  ),
                  const SizedBox(height: 15),
                  // All banks
                  _buildContent(
                    onTap: (bankName) {
                      // Handle bank selection
                      print("Selected: $bankName");
                    },
                    title: "All FastTag Bank",
                    bankList: banks, // Full list
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent({
    required Function(String) onTap, // Changed to pass bank name
    required String title,
    required List<Map<String, String>> bankList,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Fixed ListView with Material wrapper to resolve "No Material widget found" error
            Material(
              color: Colors.transparent,
              child: ListView.separated(
                itemCount: bankList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  color: Colors.blueGrey.shade200,
                  thickness: 0.5,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  final data = bankList[index];
                  return ListTile(
                    contentPadding: EdgeInsets
                        .zero, // Remove default padding for cleaner look
                    leading: CircleAvatar(
                      radius: 25, // Slightly larger for better visibility
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        data['logo']!,
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                    ),
                    title: Text(
                      data['name']!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () => onTap(data['name']!),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                const Text(
                  "FastTag recharge",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Add help dialog or navigation
                      _showHelpDialog();
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.help_outline,
                        color: AppColors.appbarFirstColor,
                        size: 18,
                      ),
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

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help'),
        content: const Text('Select a bank to proceed with FastTag recharge.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

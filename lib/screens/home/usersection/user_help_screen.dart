import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class UserHelpScreen extends StatefulWidget {
  const UserHelpScreen({super.key});

  @override
  State<UserHelpScreen> createState() => _UserHelpScreenState();
}

class _UserHelpScreenState extends State<UserHelpScreen> {
  final List<Map<String, String>> faqs = [
    {
      "question": "How can I add money to my wallet?",
      "answer":
          "Go to Wallet > Add Money, select payment method, and enter the amount.",
    },
    {
      "question": "How can I transfer money to someone?",
      "answer":
          "Go to Transfer, enter recipient details, and confirm the transaction.",
    },
    {
      "question": "How do I check my transaction history?",
      "answer":
          "Go to Wallet > Transaction History to see all past transactions.",
    },
    {
      "question": "How do I report a failed transaction?",
      "answer":
          "Go to Help > Report Issue and fill out the form with transaction details.",
    },
    {
      "question": "How can I reset my wallet PIN?",
      "answer":
          "Go to Security Settings > Change PIN and follow the instructions.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Frequently Asked Questions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // FAQ List
                    ...faqs.map((faq) => _buildFaqCard(faq)).toList(),

                    const SizedBox(height: 24),

                    // Save / Contact Button
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: appButton(
                          title: "Contact Support",
                          onTap: () {
                            showSnackBar(
                              title: "Successful",
                              message: "Contact request sent to support",
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqCard(Map<String, String> faq) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // removes the divider line
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Text(
            faq['question']!,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          children: [
            Text(faq['answer']!, style: const TextStyle(color: Colors.black87)),
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
                  child: _buildAppBarIcon(Icons.arrow_back_ios_new, () {
                    Get.back();
                  }),
                ),
                const Text(
                  "Help & FAQ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: _buildAppBarIcon(Icons.info, () {}),
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

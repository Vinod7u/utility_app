import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/services/loan_report_controller.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class LoanReportScreen extends StatefulWidget {
  const LoanReportScreen({super.key});

  @override
  State<LoanReportScreen> createState() => _LoanReportScreenState();
}

class _LoanReportScreenState extends State<LoanReportScreen> {
  late LoanReportController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoanReportController());
  }

  @override
  void dispose() {
    Get.delete<LoanReportController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar("Loan Reports"),
            SliverToBoxAdapter(
              child: Obx(() {
                if (controller.loanReports.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "No Loan Reports Available",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: controller.loanReports
                        .map((report) => _buildReportCard(report))
                        .toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- REPORT CARD ----------------
  Widget _buildReportCard(Map<String, String> report) {
    Color statusColor;
    switch (report["status"]) {
      case "Approved":
        statusColor = Colors.green;
        break;
      case "Pending":
        statusColor = Colors.orange;
        break;
      case "Rejected":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () => _showLoanDetailSheet(report),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 4,
        shadowColor: Colors.black26,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRow("Loan ID", report["id"]!),
              _buildRow("Type", report["type"]!),
              _buildRow("Amount", report["amount"]!),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Status:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    report["status"]!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- REUSABLE ROW ----------------
  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  /// ---------------- SHOW BOTTOM SHEET ----------------
  void _showLoanDetailSheet(Map<String, String> report) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              "Loan Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            _buildRow("Loan ID", report["id"]!),
            _buildRow("Type", report["type"]!),
            _buildRow("Amount", report["amount"]!),
            _buildRow("Status", report["status"]!),
            const SizedBox(height: 10),
            // Additional dummy details
            _buildRow("Duration", report["duration"] ?? "12 Months"),
            _buildRow("Applied Date", report["appliedDate"] ?? "2025-09-28"),
            _buildRow("Purpose", report["purpose"] ?? "Personal"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ---------------- APP BAR ----------------
  Widget _buildCustomAppBar(String title) {
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
                // Circular back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white24,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

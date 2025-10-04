import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/screens/home/services/normalDmt/add_beneficiary_screen.dart';
import 'package:utility_app_flutter/screens/home/services/normalDmt/beneficiary_list_screen.dart';
import 'package:utility_app_flutter/screens/home/services/normalDmt/dmt_transcation_history.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class BenifiacaryManagementScreen extends StatefulWidget {
  const BenifiacaryManagementScreen({super.key});

  @override
  State<BenifiacaryManagementScreen> createState() =>
      _BenifiacaryManagementScreenState();
}

class _BenifiacaryManagementScreenState
    extends State<BenifiacaryManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  const SizedBox(height: 16),
                  _buildTabSection(),
                  const SizedBox(height: 16),
                  _buildTabContent(),
                ],
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
                  "Beneficiary Management",
                  style: TextStyle(
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

  Widget _buildTabSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 50,
        decoration: const BoxDecoration(color: Colors.white),
        child: TabBar(
          controller: _tabController,
          // isScrollable: true, // <-- Make tabs scrollable
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black),
          ),
          labelColor: AppColors.darkColor,
          unselectedLabelColor: Colors.black,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          tabs: const [
            Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text("Add Beneficiary"),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text("Beneficiary List"),
              ),
            ),
            Tab(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text("Transaction"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height -
          200, // adjust based on appbar + other paddings
      child: TabBarView(
        controller: _tabController,
        children: const [
          AddBeneficiaryScreen(),
          BeneficiaryListScreen(),
          DmtTransactionHistory(),
        ],
      ),
    );
  }
}

/// ---------------- SEPARATE SCREENS ----------------

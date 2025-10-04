import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utility_app_flutter/screens/home/services/aeps/aeps_services_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_home_page.dart'
    show UserHomePage;
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';

class AepsServiceResultScreen extends StatefulWidget {
  final String serviceName;
  const AepsServiceResultScreen({super.key, required this.serviceName});

  @override
  State<AepsServiceResultScreen> createState() =>
      _AepsServiceResultScreenState();
}

class _AepsServiceResultScreenState extends State<AepsServiceResultScreen> {
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
    switch (widget.serviceName.toLowerCase()) {
      case "balance enquiry":
        return _buildAvaliableBalance();
      case "cash withdrawal":
        return _buildcashWithdrawal();
      case "mini statement":
        return _buildMiniStatement();
      default:
        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Center(
            child: Text(
              "Service not available",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
    }
  }

  Widget _buildAvaliableBalance() {
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
        children: [
          Text(
            "Avaliable Balance",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Text(
            "10000.00",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildcashWithdrawal() {
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transaction Successful",
            style: TextStyle(
              color: AppColors.darkColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          SizedBox(height: 16),

          Text(
            "Amount withdrawn",
            style: TextStyle(
              color: AppColors.darkColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          SizedBox(height: 16),

          Text(
            "₹ 10000.76",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),

          Row(
            children: [
              Text(
                "Transaction ID",
                style: TextStyle(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 16),
              Text(
                ": B12345678910128 ",
                style: TextStyle(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          Row(
            children: [
              Text(
                "Reamining Balance",
                style: TextStyle(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 16),

              Text(
                ": B12345678910128 ",
                style: TextStyle(
                  color: AppColors.darkColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // App Button
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.offAll(() => UserHomePage());
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.darkColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      "New Transaction",
                      style: TextStyle(
                        color: AppColors.darkColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Outlined Button
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.offAll(() => UserHomePage());
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

  Widget _buildMiniStatement() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transaction',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Text('10', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 9,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              return _buildTransactionItem(
                title: 'ABCDEF',
                date: '2025-07-01',
                amount: '₹10,000.85',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String date,
    required String amount,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Date: $date',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
        ],
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/user_trabsection_controller.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class UserTrasectionHistoryScreen extends StatefulWidget {
  const UserTrasectionHistoryScreen({super.key});

  @override
  State<UserTrasectionHistoryScreen> createState() =>
      _UserTrasectionHistoryScreenState();
}

class _UserTrasectionHistoryScreenState
    extends State<UserTrasectionHistoryScreen> {
  final UserTransactionController controller = Get.put(
    UserTransactionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: Obx(() {
        return SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildCustomAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Filter chips
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildFilterChip("All"),
                          const SizedBox(width: 10),
                          _buildFilterChip("Debit"),
                          const SizedBox(width: 10),
                          _buildFilterChip("Credit"),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final tx = controller.filteredTransactions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: _buildTransactionCard(
                      tx["title"],
                      tx["subtitle"],
                      tx["amount"],
                      tx["icon"],
                      tx["time"],
                    ),
                  );
                }, childCount: controller.filteredTransactions.length),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// ---------------- CUSTOM APP BAR ----------------
  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 80,
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Obx(() {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.new_blue, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title / SearchBar
                  controller.isSearching.value
                      ? Expanded(
                          child: TextField(
                            autofocus: true,
                            onChanged: controller.setSearchQuery,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Search transactions...",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet,
                                color: AppColors.primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              "Transactions",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),

                  // Icons
                  Row(
                    children: [
                      _buildAppBarIcon(
                        controller.isSearching.value
                            ? Icons.close
                            : Icons.search,
                        controller.toggleSearch,
                      ),
                      const SizedBox(width: 10),
                      _buildAppBarIcon(Icons.filter_alt_outlined, () {
                        // Optional: open filter bottom sheet
                      }),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
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
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  /// ---------------- FILTER CHIP ----------------
  Widget _buildFilterChip(String label) {
    return Obx(() {
      final bool selected = controller.selectedFilter.value == label;
      return ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: AppColors.new_blue,
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        onSelected: (_) => controller.setFilter(label),
      );
    });
  }

  /// ---------------- TRANSACTION CARD ----------------
  Widget _buildTransactionCard(
    String title,
    String subtitle,
    String amount,
    IconData icon,
    String time,
  ) {
    final bool isCredit = amount.startsWith("+");

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondary.withOpacity(0.9),
                  AppColors.primary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3748),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isCredit ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

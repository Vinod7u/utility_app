import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/user_trabsection_controller.dart';
import 'package:utility_app_flutter/screens/home/retailerSection/drawer.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

import '../../../widgets/filter_bottom_sheet.dart';

class UserTrasectionHistoryScreen extends StatefulWidget {
  const UserTrasectionHistoryScreen({super.key});

  @override
  State<UserTrasectionHistoryScreen> createState() =>
      _UserTrasectionHistoryScreenState();
}

class _UserTrasectionHistoryScreenState
    extends State<UserTrasectionHistoryScreen> {
  final UserTransactionController controller = Get.put(UserTransactionController());
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      drawer: const MyDrawer(),
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
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _searchController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                filled: true,
                                counterText: '',
                                hintStyle: TextStyle(color: Colors.grey.shade400),
                                fillColor: const Color(0xFFf9fafb),
                                prefixIcon: Icon(Icons.search, size: 16,color: Colors.grey.shade400,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:  BorderSide(color: Colors.grey.shade200, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:  BorderSide(color: Colors.grey.shade200, width: 2),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                FilterBottomSheet(),
                                isScrollControlled: true, // 👈 optional if content is long
                                backgroundColor: Colors.transparent, // keep rounded corners
                              );
                            },
                            child: Icon(Icons.tune),
                          ),

                        ],
                      ),
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
      expandedHeight: 0,
      floating: true,
      pinned: true,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffA9E2FF), Color(0xff44A5E9)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(builder: (context){
                  return InkWell(
                    onTap: (){
                      Scaffold.of(context).openDrawer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.menu,color: Colors.white,size: 32,),
                    ),
                  );
                }),
                Text(
                  "History",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                _buildAppBarIcon(Icons.notifications_outlined, () {}),
              ],
            ),
          ),
        )
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
          borderRadius: BorderRadius.circular(20),
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

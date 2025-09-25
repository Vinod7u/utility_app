import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class NotificatonScreen extends StatefulWidget {
  const NotificatonScreen({super.key});

  @override
  State<NotificatonScreen> createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificatonScreen> {
  // 🔹 Sample notifications list (replace with API later)
  final List<Map<String, String>> notifications = [
    {
      "icon": "https://img.icons8.com/color/96/money-transfer.png",
      "title": "Money Received",
      "message": "You received ₹500 from Rahul.",
      "time": "2 min ago",
    },
    {
      "icon": "https://img.icons8.com/color/96/flash.png",
      "title": "Electricity Bill Paid",
      "message": "Your BSES bill of ₹1,200 has been paid.",
      "time": "10 min ago",
    },
    {
      "icon": "https://img.icons8.com/color/96/discount.png",
      "title": "Offer Alert",
      "message": "Flat 20% cashback on DTH recharge.",
      "time": "1 hr ago",
    },
    {
      "icon": "https://img.icons8.com/color/96/bank.png",
      "title": "Bank Transfer",
      "message": "₹2,000 successfully transferred to SBI Bank.",
      "time": "Yesterday",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),

            // 🔹 Notifications List
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final notif = notifications[index];
                return _buildNotificationTile(
                  notif["icon"]!,
                  notif["title"]!,
                  notif["message"]!,
                  notif["time"]!,
                );
              }, childCount: notifications.length),
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
                // 🔹 Back Icon
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),

                // 🔹 Center Title
                const Text(
                  "Notifications",
                  style: TextStyle(
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

  /// ---------------- NOTIFICATION TILE ----------------
  Widget _buildNotificationTile(
    String iconUrl,
    String title,
    String message,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // 🔹 Icon
          Container(
            height: 46,
            width: 46,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.newPrimaryColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(iconUrl, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),

          // 🔹 Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),

          // 🔹 Time
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

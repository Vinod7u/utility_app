import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:utility_app_flutter/controller/home_page_controller.dart';
import 'package:utility_app_flutter/screens/home/home_dashboard.dart';
import 'package:utility_app_flutter/screens/home/profile_screen.dart';
import 'package:utility_app_flutter/screens/home/service_screen.dart';
import 'package:utility_app_flutter/screens/home/trasection_history_screen.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class HomePage extends StatefulWidget {
  final UserType userType;

  const HomePage({super.key, required this.userType});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeDashboard(userType: widget.userType),
      ServiceScreen(),
      TransactionHistoryScreen(),
      ProfileScreen(userType: widget.userType),
    ];
    return Obx(
      () => Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            // Jump/scale animation
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.elasticOut),
              ),
              child: child,
            );
          },
          child: screens[controller.selectedIndex.value],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.react,
          backgroundColor: Colors.white,
          activeColor: const Color(0xFF667eea),
          color: const Color(0xFF9ca3af),
          elevation: 6,
          curveSize: 90,
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.apps, title: 'Services'),
            TabItem(icon: Icons.history, title: 'History'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          initialActiveIndex: 0,
          onTap: (index) => controller.changeTab(index),
        ),
      ),
    );
  }
}

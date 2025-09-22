import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/home_page_controller.dart';
import 'package:utility_app_flutter/screens/home/usersection/profile_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/scanner_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/service_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_trasection_history_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_home_dashboard.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final controller = Get.put(HomePageController());

  final icons = [
    Icons.home_filled,
    Icons.app_registration_rounded,
    Icons.qr_code_scanner_outlined,
    Icons.history,
    Icons.person,
  ];

  final titles = ['Home', 'Services', 'Scan', 'History', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final screens = [
      UserHomeDashboard(),
      const ServiceScreen(),
      const ScannerScreen(),
      UserTrasectionHistoryScreen(),
      ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.linear),
              ),
              child: child,
            );
          },
          child: screens[controller.userselectedIndex.value],
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 20,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            color: Colors.white,
            height: 60, // a bit taller for larger icons
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) {
                if (index == 2) {
                  // Leave gap for FAB
                  return const SizedBox(width: 65);
                }
                final bool isSelected =
                    controller.userselectedIndex.value == index;
                return Expanded(
                  child: InkWell(
                    onTap: () => controller.userchangeTab(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[index],
                          size: 28, // 🔥 bigger icons for all tabs
                          color: isSelected
                              ? AppColors.new_blue
                              : Colors.blueGrey.shade300,
                        ),
                        const SizedBox(height: 3), // less padding under icons
                        Text(
                          titles[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? AppColors.new_blue
                                : Colors.blueGrey.shade300,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),

        /// Floating Center Scan Button
        floatingActionButton: GestureDetector(
          onTap: () => controller.userchangeTab(2),
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: AppColors.new_blue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.qr_code_scanner_outlined,
              color: Colors.white,
              size: 36, // 🔥 bigger scan icon
            ),
          ),
        ),

        /// Floating Center Scan Button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

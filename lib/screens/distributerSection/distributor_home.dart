import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/home_page_controller.dart';
import 'package:utility_app_flutter/screens/distributerSection/distributor_dashboard.dart';
import 'package:utility_app_flutter/widgets/drawer.dart';
import 'package:utility_app_flutter/screens/home/usersection/profile_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/service_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_trasection_history_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_home_dashboard.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class DistributorHome extends StatefulWidget {
  const DistributorHome({super.key});

  @override
  State<DistributorHome> createState() => _DistributorHomeState();
}

class _DistributorHomeState extends State<DistributorHome> {
  final controller = Get.put(HomePageController());

  final icons = [
    Icons.home_filled,
    Icons.app_registration_rounded,
    Icons.history,
    Icons.person,
  ];

  final titles = ['Home', 'Services', 'History', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final screens = [
      DistributorDashboard(),
      ServiceScreen(),
      UserTrasectionHistoryScreen(),
      ProfileScreen(),
    ];

    return Obx(
      () => Scaffold(
        drawer: MyDrawer(),
        backgroundColor: AppColors.off_white,

        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linearToEaseOut,
                ),
              ),
              child: child,
            );
          },
          child: screens[controller.userselectedIndex.value],
        ),

        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 20,
          child: Container(
            color: Colors.white,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                final bool isSelected =
                    controller.userselectedIndex.value == index;
                return Expanded(
                  child: InkWell(
                    onTap: () => controller.distributerchangeTab(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icons[index],
                          size: 28,
                          color: isSelected
                              ? AppColors.new_blue
                              : Colors.blueGrey.shade300,
                        ),
                        const SizedBox(height: 3),
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
      ),
    );
  }
}

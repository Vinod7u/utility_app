import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/user_service_controller.dart';
import 'package:utility_app_flutter/screens/home/services/recharge/mobile_recharge_screen.dart';
import 'package:utility_app_flutter/widgets/drawer.dart';
import 'package:utility_app_flutter/screens/home/usersection/notificaton_screen.dart';
import 'package:utility_app_flutter/screens/home/services/serice_process_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final controller = Get.put(UserServiceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _buildCustomAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_outlined,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            onChanged: controller.updateSearch,
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        Obx(
                          () => controller.searchQuery.value.isNotEmpty
                              ? GestureDetector(
                                  onTap: () => controller.updateSearch(""),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.grey.shade400,
                                    size: 20,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Services Grid
          SliverFillRemaining(
            child: Obx(() {
              if (controller.searchQuery.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.services.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.85,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 16,
                        ),
                    itemBuilder: (context, idx) {
                      final s = controller.services[idx];
                      return _buildServiceTile(
                        onTap: () {
                          if (s.title == "Mobile Recharge") {
                            Get.to(
                              () => MobileRechargeScreen()
                            );
                          }else{
                            Get.to(
                            () => ServiceProcessScreen(serviceName: s.title),
                          );
                          }
                          
                        },
                        iconData: s.iconData,
                        serviceName: s.title,
                      );
                    },
                  ),
                );
              } else {
                // Show search results
                if (controller.filteredServices.isEmpty) {
                  return const Center(
                    child: Text(
                      "No services found",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredServices.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final s = controller.filteredServices[i];
                    return _buildSearchResultTile(s);
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  /// ---------------- CUSTOM APP BAR ----------------
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
                // Left Icon (Menu)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Builder(
                    builder: (context) {
                      return _buildAppBarIcon(Icons.menu, () {
                        Scaffold.of(context).openDrawer();
                      });
                    },
                  ),
                ),

                // Center Title
                const Text(
                  "All Services",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),

                // Right Icon (Notification)
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildAppBarIcon(Icons.notifications_outlined, () {
                    Get.to(() => NotificatonScreen());
                  }),
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  /// ---------------- SERVICE TILE ----------------
  Widget _buildServiceTile({
    required VoidCallback onTap,
    required IconData iconData,
    required String serviceName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.icon_blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(iconData, size: 28, color: AppColors.icon_blue),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                serviceName,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColor,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- SEARCH RESULT TILE ----------------
  Widget _buildSearchResultTile(Service s) {
    return GestureDetector(
      onTap: () => Get.to(() => ServiceProcessScreen(serviceName: s.title)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(s.iconData, color: AppColors.icon_blue, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    s.subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textColor.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.icon_blue.withOpacity(0.8),
            ),
          ],
        ),
      ),
    );
  }
}

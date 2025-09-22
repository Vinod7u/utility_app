import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/user_service_controller.dart';
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
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // 🔹 Search bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              onChanged: controller.updateSearch,
                              decoration: const InputDecoration(
                                hintText: "Search services",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Obx(
                            () => controller.searchQuery.value.isNotEmpty
                                ? GestureDetector(
                                    onTap: () => controller.updateSearch(""),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.grey,
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

            // 🔹 Body
            SliverFillRemaining(
              child: Obx(() {
                if (controller.searchQuery.isEmpty) {
                  // Show all categories in Grid
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.serviceCategories.length,
                    itemBuilder: (context, i) {
                      final cat = controller.serviceCategories[i];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cat.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cat.services.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.9,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                ),
                            itemBuilder: (context, idx) {
                              final s = cat.services[idx];
                              return _buildServiceTile(s);
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  );
                } else {
                  // Show search results (like Paytm)
                  if (controller.filteredServices.isEmpty) {
                    return const Center(child: Text("No services found"));
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
      ),
    );
  }

  /// ---------------- CUSTOM APP BAR ----------------
  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 80,
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.widgets,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildAppBarIcon(Icons.qr_code_scanner, () {}),
                    const SizedBox(width: 10),
                    _buildAppBarIcon(Icons.notifications_outlined, () {}),
                    const SizedBox(width: 10),
                    _buildProfileAvatar(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Container(
          width: 34,
          height: 34,
          color: AppColors.primary,
          child: const Icon(Icons.person, color: Colors.white, size: 18),
        ),
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

  /// ---------------- GRID STYLE ----------------
  Widget _buildServiceTile(Service s) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 36,
            width: 36,
            child: Image.network(s.iconUrl, fit: BoxFit.contain),
          ),
          const SizedBox(height: 6),
          Text(
            s.title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  /// ---------------- SEARCH RESULT ----------------
  Widget _buildSearchResultTile(Service s) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(s.iconUrl, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  s.subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

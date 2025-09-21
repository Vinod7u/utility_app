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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("All Services"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
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

            // 🔹 Body
            Expanded(
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

  /// 🔹 Grid Style Card
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

  /// 🔹 List Style Search Result
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

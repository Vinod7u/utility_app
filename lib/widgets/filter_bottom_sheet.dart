import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/Constants/screen_size.dart';
import '../controller/userscreenscontrollers/user_trabsection_controller.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final controller = Get.find<UserTransactionController>();
  
  // Individual checkbox states for different filter options
  final Map<String, bool> statusFilters = {
    'Successful': false,
    'Pending': false,
    'Failed': false,
  };
  
  final List<String> filterCategories = ["Services", "Amount", "Status", "Date"];

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Container(
      height: ScreenSize.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildDivider(),
          Expanded(child: _buildFilterContent()),
          _buildActionButtons(),
        ],
      ),
    );
  }

  /// Header with title and close button
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Filter",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFF34495E),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Divider line
  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.grey.shade300,
    );
  }

  /// Main filter content with categories and options
  Widget _buildFilterContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryList(),
          _buildFilterOptions(),
        ],
      ),
    );
  }

  /// Left side category list
  Widget _buildCategoryList() {
    return Container(
      width: ScreenSize.width * 0.35,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.new_blue.withOpacity(0.1),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: filterCategories.length,
        itemBuilder: (context, index) {
          return Obx(() {
            final isSelected = controller.isFilterCategorySelected.value &&
                index == controller.selectedFilterIndex.value;

            return GestureDetector(
              onTap: () {
                controller.selectedFilterIndex.value = index;
                controller.isFilterCategorySelected.value = true;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  border: isSelected
                      ? Border(
                          right: BorderSide(
                            color: AppColors.new_blue,
                            width: 3,
                          ),
                        )
                      : null,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Text(
                  filterCategories[index],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? AppColors.new_blue : const Color(0xFF5D6D7E),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  /// Right side filter options
  Widget _buildFilterOptions() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Obx(() {
          if (!controller.isFilterCategorySelected.value) {
            return const Center(
              child: Text(
                "Select a category to view filter options",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return _buildSelectedCategoryOptions();
        }),
      ),
    );
  }

  /// Build options based on selected category
  Widget _buildSelectedCategoryOptions() {
    final selectedIndex = controller.selectedFilterIndex.value;
    
    switch (selectedIndex) {
      case 2: // Status
        return _buildStatusOptions();
      case 0: // Services
        return _buildServicesOptions();
      case 1: // Amount
        return _buildAmountOptions();
      case 3: // Date
        return _buildDateOptions();
      default:
        return const SizedBox();
    }
  }

  /// Status filter options
  Widget _buildStatusOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text(
            "Transaction Status",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2C3E50),
            ),
          ),
        ),
        ...statusFilters.keys.map((status) {
          return _buildCustomCheckbox(
            title: status,
            value: statusFilters[status]!,
            onChanged: (value) {
              setState(() {
                statusFilters[status] = value ?? false;
              });
            },
          );
        }).toList(),
      ],
    );
  }

  /// Services filter options (placeholder)
  Widget _buildServicesOptions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service Types",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Service filters will appear here",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  /// Amount filter options (placeholder)
  Widget _buildAmountOptions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Amount Range",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Amount range filters will appear here",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  /// Date filter options (placeholder)
  Widget _buildDateOptions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date Range",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Date range filters will appear here",
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  /// Custom checkbox widget
  Widget _buildCustomCheckbox({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: value ? AppColors.new_blue : Colors.grey.shade400,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: value ? AppColors.new_blue : Colors.transparent,
                ),
                child: value
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: value ? AppColors.new_blue : const Color(0xFF2C3E50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Bottom action buttons
  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              text: "Clear All",
              isOutlined: true,
              onTap: _clearAllFilters,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              text: "Apply",
              isOutlined: false,
              onTap: _applyFilters,
            ),
          ),
        ],
      ),
    );
  }

  /// Action button widget
  Widget _buildActionButton({
    required String text,
    required bool isOutlined,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isOutlined ? Colors.white : AppColors.new_blue,
          borderRadius: BorderRadius.circular(12),
          border: isOutlined
              ? Border.all(color: Colors.grey.shade300, width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isOutlined ? Colors.grey.shade600 : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// Clear all filters
  void _clearAllFilters() {
    setState(() {
      statusFilters.updateAll((key, value) => false);
    });
    controller.isFilterCategorySelected.value = false;
    controller.selectedFilterIndex.value = -1;
  }

  /// Apply filters
  void _applyFilters() {
    // Implement filter application logic here
    final selectedStatuses = statusFilters.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    // You can pass the selected filters back to the parent or controller
    print("Applied filters: $selectedStatuses");
    
    Get.back();
  }
}
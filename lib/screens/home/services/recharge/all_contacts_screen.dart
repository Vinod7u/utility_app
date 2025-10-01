import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart'; // Fixed import: Use full package for Contact
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/services/rechargeScreen_controller.dart';
import 'package:utility_app_flutter/screens/home/services/serice_process_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class AllContactsScreen extends StatefulWidget {
  const AllContactsScreen({super.key});

  @override
  State<AllContactsScreen> createState() => _AllContactsScreenState();
}

class _AllContactsScreenState extends State<AllContactsScreen> {
  final controller = Get.find<RechargescreenController>();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      controller.searchContact(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Obx(() {
                // Wrapped in Obx for reactive updates
                if (controller.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (controller.filteredContacts.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: Text('No contacts found')),
                  );
                }
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "All Contacts",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredContacts.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1, thickness: 1),
                        itemBuilder: (context, index) {
                          return _buildAllContactsItem(
                            controller.filteredContacts[index],
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllContactsItem(Contact contact) {
    String name = contact.displayName.isNotEmpty
        ? contact.displayName
        : '${contact.name.first ?? ''} ${contact.name.last ?? ''}'.trim();
    String number = '';

    if (contact.phones.isNotEmpty) {
      Phone firstPhone = contact.phones.first;
      if (firstPhone.number != null && firstPhone.number!.isNotEmpty) {
        // Prefer normalizedNumber if available
        if (firstPhone.normalizedNumber != null &&
            firstPhone.normalizedNumber!.isNotEmpty) {
          number = firstPhone.normalizedNumber!.replaceAll(RegExp(r'\s+'), '');
        } else {
          // Fallback to raw number and clean it
          number = firstPhone.number!
              .replaceAll(RegExp(r'\s+'), '')
              .replaceAll(RegExp(r'[-()]'), '');
        }
      }
    }

    String avatarText = name.isNotEmpty ? name[0].toUpperCase() : '?';
    bool hasPhoto = contact.photo != null && contact.photo!.isNotEmpty;

    return GestureDetector(
      // Added GestureDetector for selection
      onTap: () {
        // // Select contact and navigate to plan selection (like Paytm flow)
        // controller.selectedNumber.value = number;  // Assume RxString selectedNumber in controller
        // controller.selectedName.value = name;     // Assume RxString selectedName in controller
        // controller.detectOperatorAndPlans(number);  // Fetch operator/plans
        Get.to(
          () => ServiceProcessScreen(serviceName: "Mobile Recharge"),
        ); // Return to previous screen
        // Or directly: Get.to(() => PlanSelectionScreen()); if preferred
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.darkColor,
              backgroundImage: hasPhoto ? MemoryImage(contact.photo!) : null,
              child: !hasPhoto
                  ? Text(
                      avatarText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.isNotEmpty ? name : 'Unknown',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  if (number.isNotEmpty)
                    Text(
                      number,
                      style: TextStyle(
                        color: AppColors.darkColor,
                        fontSize: 13,
                      ),
                    )
                  else
                    Text(
                      'No number',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ), // Added chevron for tappable feel
          ],
        ),
      ),
    );
  }

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
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _searchController,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: const TextStyle(color: Colors.white70),
                            fillColor: AppColors.newPrimaryColor.withOpacity(
                              0.3,
                            ), // Slight opacity for better UX
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      // Made help icon tappable
                      onTap: () {
                        // Show help dialog or navigate to help screen
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.help_outline,
                          color: AppColors.appbarFirstColor,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/services/rechargeScreen_controller.dart';
import 'package:utility_app_flutter/screens/home/services/recharge/all_contacts_screen.dart';
import 'package:utility_app_flutter/screens/home/services/serice_process_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class MobileRechargeScreen extends StatefulWidget {
  const MobileRechargeScreen({super.key});

  @override
  State<MobileRechargeScreen> createState() => _MobileRechargeScreenState();
}

class _MobileRechargeScreenState extends State<MobileRechargeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;
  late RechargescreenController controller;

  final List<Map<String, dynamic>> recents = [
    {
      "name": "Mummy",
      "number": "1234567890",
      "operator": "Jio",
      "validity": "Plan valid till 7 Nov",
      "quickRecharge": [],
    },
    {
      "name": "Papa",
      "number": "1234567890",
      "operator": "Airtel",
      "validity": "Plan valid till 1 Oct",
      "quickRecharge": [
        "1 GB for ₹26",
        "1 GB for ₹26",
        "1 GB for ₹26",
        "1 GB for",
      ],
      "popular": true,
    },
    {
      "name": "Vivek",
      "number": "1234567890",
      "operator": "Vi",
      "validity": "Plan expired !",
      "quickRecharge": [],
      "expired": true,
    },
    {
      "name": "Deepika",
      "number": "1234567890",
      "operator": "Airtel",
      "validity": "Plan valid till 7 Nov",
      "quickRecharge": [],
    },
  ];

  final List<Map<String, dynamic>> myRecharges = [
    {"name": "Mummy", "number": "1234567890", "operator": "Jio"},
    {"name": "Papa", "number": "1234567890", "operator": "Airtel"},
    {"name": "Vivek", "number": "1234567890", "operator": "Vi"},
    {"name": "Deepika", "number": "1234567890", "operator": "Airtel"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController = TextEditingController();
    controller = Get.put(
      RechargescreenController(),
    ); // Initializes and fetches contacts automatically
    _searchController.addListener(() {
      controller.searchContact(_searchController.text);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildOfferBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              "Recharge your Vi Mobile and Get Upto ₹50 cashback",
              style: TextStyle(fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
            ),
            child: Row(
              children: const [
                Text("+ 13 more offers", style: TextStyle(fontSize: 13)),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => AllContactsScreen());
            },
            child: const Icon(Icons.search, color: Colors.grey, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onTap: () {},
              controller: _searchController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter your Mobile Number",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          InkWell(
            onTap: () {
              _searchController.clear();
              Get.to(() => AllContactsScreen());
            },
            child: Icon(Icons.contact_page, color: Colors.blue[300], size: 26),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentItem(Map<String, dynamic> item) {
    bool expired = item['expired'] ?? false;
    bool hasQuickRecharge = (item['quickRecharge'] as List).isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: _getOperatorColor(item['operator']),
                child: Text(
                  item['operator'][0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      item['number'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, size: 20),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item['validity'],
            style: TextStyle(
              color: expired ? Colors.red : Colors.grey[600],
              fontSize: 13,
            ),
          ),
          if (hasQuickRecharge) ...[
            const SizedBox(height: 8),
            if (item['popular'] == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "Popular",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: (item['quickRecharge'] as List<dynamic>)
                    .map(
                      (qr) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                            side: BorderSide.none,
                          ),
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                qr.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          backgroundColor: Colors.blue[50],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
          if (expired) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(
                    () => ServiceProcessScreen(serviceName: "Mobile Recharge"),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Recharge Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getOperatorColor(String operator) {
    switch (operator) {
      case 'Jio':
        return Colors.blue[700]!;
      case 'Airtel':
        return Colors.red[600]!;
      case 'Vi':
        return Colors.red[700]!;
      default:
        return Colors.grey;
    }
  }

  Widget _buildRechargeItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: _getOperatorColor(item['operator']),
            child: Text(
              item['operator'][0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  item['number'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => ServiceProcessScreen(serviceName: "Mobile Recharge"));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  "Recharge",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.more_vert, size: 20),
        ],
      ),
    );
  }

  Widget _buildAllContactsItem(Contact contact) {
    String name = contact.displayName.isNotEmpty
        ? contact.displayName
        : '${contact.name.first ?? ''} ${contact.name.last ?? ''}'.trim();
    String number = '';
    if (contact.phones.isNotEmpty && contact.phones.first.number != null) {
      number = contact.phones.first.normalizedNumber.replaceAll(
        RegExp(r'\s+'),
        '',
      );
    }
    String avatarText = name.isNotEmpty ? name[0].toUpperCase() : '?';

    bool hasPhoto = contact.photo != null && contact.photo!.isNotEmpty;

    return  InkWell(
      onTap: (){
         Get.to(
          () => ServiceProcessScreen(serviceName: "Mobile Recharge"),
        );
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
                  Text(
                    number,
                    style: TextStyle(color: AppColors.darkColor, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  _buildOfferBanner(),
                  const SizedBox(height: 12),
                  _buildSearchField(),
                  const SizedBox(height: 16),
                  // Tabs
                  Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.darkColor,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      tabs: const [
                        Tab(text: "Prepaid"),
                        Tab(text: "Postpaid"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Recents
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "RECENTS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...recents.map((e) => _buildRecentItem(e)).toList(),
                  const SizedBox(height: 16),
                  // My Recharge & Bills
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "MY RECHARGE & BILLS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: myRecharges
                          .map((e) => _buildRechargeItem(e))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // All Contacts
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ALL CONTACTS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
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

                    int displayCount = controller.filteredContacts.length > 4
                        ? 4
                        : controller.filteredContacts.length;
                    bool showViewAll = controller.filteredContacts.length > 4;

                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: displayCount,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1, thickness: 1),
                            itemBuilder: (context, index) {
                              return _buildAllContactsItem(
                                controller.filteredContacts[index],
                              );
                            },
                          ),
                        ),
                        if (showViewAll) ...[
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(() => AllContactsScreen());
                              // Navigate to full contacts screen, e.g., Get.to(() => FullContactsScreen());
                              // Implement navigation logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 12,
                              ),
                            ),
                            child: const Text(
                              "View All",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
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
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const Text(
                  "Mobile recharge",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.3,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
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
          ),
        ),
      ),
    );
  }
}

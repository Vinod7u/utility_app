import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_app_flutter/controller/home_page_controller.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/user_home_controller.dart';
import 'package:utility_app_flutter/screens/home/services/fasttag/fasttag_screen.dart';
import 'package:utility_app_flutter/screens/home/services/loans_services_screen.dart';
import 'package:utility_app_flutter/screens/home/services/recharge/mobile_recharge_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/notificaton_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/scanner_screen.dart';
import 'package:utility_app_flutter/screens/home/services/serice_process_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:utility_app_flutter/utils/Constants/appimage.dart';

import '../../../widgets/drawer.dart';

class UserHomeDashboard extends StatefulWidget {
  const UserHomeDashboard({super.key});

  @override
  State<UserHomeDashboard> createState() => _UserHomeDashboardState();
}

class _UserHomeDashboardState extends State<UserHomeDashboard>
    with TickerProviderStateMixin {
  final UserHomeController controller = Get.put(UserHomeController());
  final _searchController = TextEditingController();

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  // Example dummy data
  final List<Map<String, dynamic>> dummyOffers = [
    {
      'image': Appimage.aadharpay,
      'message': '50% off on food delivery',
      'backgroundColor': AppColors.blue_shade,
      'isNetworkImage': false,
    },
    {
      'image': Appimage.aadharpay,
      'message': 'Flash sale on electronics',
      'backgroundColor': AppColors.new_blue.withOpacity(0.2),
      'isNetworkImage': false,
    },
    {
      'image': Appimage.aadharpay,
      'message': 'Book flights with 30% discount',
      'backgroundColor': AppColors.new_blue.withOpacity(0.4),
      'isNetworkImage': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _buildCustomAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _bannerSection(),
                _sectionDivider(),
                _walletSection(),
                _sectionDivider(height: 24),
                _serviceSection("Money Transfer", [
                  {
                    'image': "assets/images/qr-code 1.png",
                    'label': 'QR Code',
                    'hasContainer': true,
                    'onTap': () => Get.to(() => ScannerScreen()),
                  },
                  {
                    'image': "assets/images/card 1.png",
                    'label': 'AEPS Payout',
                    'hasContainer': true,
                    'onTap': () => Get.to(
                      () => FasttagScreen(),
                    ),
                  },
                  {
                    'image': "assets/images/card (2) 1.png",
                    'label': 'Normal DMT',
                    'hasContainer': true,
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'AEPS Transaction'),
                    ),
                  },
                  {
                    'image': "assets/images/transaction (6) 1.png",
                    'label': 'Express DMT',
                    'hasContainer': true,
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'BBPS Transaction'),
                    ),
                  },
                ]),
                _serviceSection("Recharge & Bills", [
                  {
                    'image': "assets/images/earth_13849445.png",
                    'label': 'DTH',
                    'onTap': () =>
                        Get.to(() => ServiceProcessScreen(service: 'DTH')),
                  },
                  {
                    'image': "assets/images/atm-card_8739601.png",
                    'label': 'Credit Card',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'Credit Card'),
                    ),
                  },
                  {
                    'image': "assets/images/electricity_9746766.png",
                    'label': 'Electricity',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'Electricity'),
                    ),
                  },
                  {
                    'image': "assets/images/payment_11703536.png",
                    'label': 'Mobile Recharge',
                    'onTap': () => Get.to(
                      () => MobileRechargeScreen(),
                    ),
                  },
                ], showoffer: true),

                _buildQuickOffer(dummyOffers),
                SizedBox(height: 12),
                _serviceSection("Cash Withdrawal", [
                  {
                    'image': Appimage.aeps,
                    'label': 'AEPS',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                  {
                    'image': Appimage.ministatement,
                    'label': 'Mini Statement',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                  {
                    'image': Appimage.aadharpay,
                    'label': 'AAdhar Pay',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                  {
                    'image': Appimage.creditcard,
                    'label': 'Micro Atm',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                ]),
                _serviceSection("Booking", [
                  {
                    'image': Appimage.school,
                    'label': 'Bus',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                  {
                    'image': Appimage.train,
                    'label': 'Train',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                  {
                    'image': Appimage.building,
                    'label': 'Hotel',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                  {
                    'image': Appimage.flight,
                    'label': 'Flight',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                ], showoffer: true),
                _serviceSection("Finance", [
                  {
                    'image': Appimage.funds,
                    'label': 'Personal Loan',
                    'onTap': () => Get.to(
                      () => LoansServicesScreen(serviceName: "Personal Loan"),
                    ),
                  },
                  {
                    'image': Appimage.handshakes,
                    'label': 'Business Loan',
                    'onTap': () => Get.to(
                      () => LoansServicesScreen(serviceName: "Business Loan"),
                    ),
                  },
                  {
                    'image': Appimage.home,
                    'label': 'Instant Loan',
                    'onTap': () => Get.to(
                      () => LoansServicesScreen(serviceName: "Instant Loan"),
                    ),
                  },

                  {
                    'image': Appimage.car,
                    'label': 'Car Loan',
                    'onTap': () => Get.to(
                      () => LoansServicesScreen(serviceName: "Car Loan"),
                    ),
                  },
                ]),

                _serviceSection("Insurence", [
                  {
                    'image': Appimage.car,
                    'label': 'Car Insurence',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                  {
                    'image': Appimage.bike,
                    'label': 'Bike Insurence',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                  {
                    'image': Appimage.home,
                    'label': 'LCB',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },

                  {
                    'image': Appimage.car,
                    'label': 'Instant Loan',
                    'onTap': () => Get.to(
                      () => ServiceProcessScreen(service: 'DMT Transaction'),
                    ),
                  },
                ]),

                const SizedBox(height: 20),

                _buildCreditCardZone(),

                _buildCreditscoreSection(),
                _buildGetCreditCardSection(),
                _buildFreeToolsSection(),
                _buildTrendingSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- APP BAR --------------------
  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 60,
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
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
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _menuButton(),
                const SizedBox(width: 10),
                Expanded(child: _searchField()),
                const SizedBox(width: 8),
                _appBarActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickOffer(List<Map<String, dynamic>> item) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: item.length,
        itemBuilder: (context, index) {
          final data = item[index];
          return Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: data['backgroundColor'] ?? Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                data['isNetworkImage'] == true
                    ? Image.network(data['image'])
                    : Image.asset(data['image']),
                Text(data['message']),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _menuButton() => Builder(
    builder: (context) => InkWell(
      onTap: () => Scaffold.of(context).openDrawer(),
      child: const Icon(Icons.menu, color: Colors.white, size: 32),
    ),
  );

  Widget _searchField() => TextFormField(
    controller: _searchController,
    keyboardType: TextInputType.text,
    cursorColor: Colors.black,
    cursorHeight: 14,
    cursorWidth: 1,
    decoration: InputDecoration(
      hintText: "Search",
      hintStyle: const TextStyle(color: Colors.white),
      fillColor: AppColors.newPrimaryColor,
      filled: true,
      prefixIcon: const Icon(Icons.search, size: 16, color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.white),
      ),
    ),
  );

  Widget _appBarActions() => Row(
    children: [
      _appBarIcon(
        Icons.notifications_outlined,
        () => Get.to(() => NotificatonScreen()),
      ),
      const SizedBox(width: 8),
      _appBarIcon(Icons.person, () {}),
    ],
  );

  Widget _appBarIcon(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    ),
  );

  // -------------------- BANNER --------------------
  Widget _bannerSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // 🔹 Carousel
          CarouselSlider.builder(
            itemCount: controller.bannerImages.length,
            itemBuilder: (context, idx, realIdx) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  controller.bannerImages[idx], // ✅ dynamic image
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
            options: CarouselOptions(
              height: 140,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.88,
              onPageChanged: (index, reason) {
                controller.currentBanner.value = index;
              },
            ),
          ),

          const SizedBox(height: 8),

          // 🔹 Dots indicator (dynamic visibility)
          Obx(() {
            // Example condition: show dots only if more than 1 banner
            if (controller.bannerImages.length <= 1) {
              return const SizedBox(); // no dots
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.bannerImages.asMap().entries.map((e) {
                final bool active = e.key == controller.currentBanner.value;

                // Example condition: hide dot for specific index
                if (e.key == 2) {
                  return const SizedBox(); // don’t show dot for 3rd banner
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }

  // -------------------- WALLET --------------------
  Widget _walletSection() {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.appbarFirstColor,
                  AppColors.appbarsecondColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/streamline-ultimate-color_money-wallet-open.svg',
                    ),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wallet Balance',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                controller.isBalanceVisible.value
                                    ? "₹ ${NumberFormat("#,##0.00").format(controller.walletBalance.value)}"
                                    : "₹ ****",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: controller.toggleBalanceVisibility,
                              child: Obx(
                                () => Icon(
                                  controller.isBalanceVisible.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.white.withOpacity(0.9),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _balanceAction(
                        'Add Money',
                        Icons.add_circle_outline,
                        () => controller.addMoney(500),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _balanceAction(
                        'Send Money',
                        Icons.send_outlined,
                        () => controller.sendMoney(500),
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

  Widget _balanceAction(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.newPrimaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- SERVICE SECTION --------------------
  Widget _serviceSection(
    String title,
    List<Map<String, dynamic>> services, {
    bool showoffer = false,
  }) {
    bool hasContainers = services.any((s) => s['hasContainer'] == true);

    // Ensure exactly 4 items visually
    List<Map<String, dynamic>> displayServices = List.from(services);
    while (displayServices.length < 4) {
      displayServices.add({'image': '', 'label': '', 'onTap': () {}});
    }

    double itemWidth = (MediaQuery.of(context).size.width - 68) / 4;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            spreadRadius: 6,
            color: Colors.grey.withOpacity(.18),
            blurRadius: 7,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                InkWell(
                  onTap: () => Get.find<HomePageController>().userchangeTab(1),
                  child: Row(
                    children: const [
                      Text("View all", style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios, size: 12),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Info Badge

            // Row with exactly 4 items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: displayServices.map((service) {
                return SizedBox(
                  width: itemWidth,
                  child: service['image'] == ''
                      ? const SizedBox() // empty placeholder
                      : hasContainers
                      ? _serviceItemWithContainer(service)
                      : _serviceItemSimple(service),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),
            if (showoffer)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      print("Info badge tapped");
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/discount.png",
                              height: 10,
                              width: 10,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Offers and many more",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      print("Info badge tapped");
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/discount.png",
                              height: 10,
                              width: 10,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Offers and many more",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _serviceItemWithContainer(Map<String, dynamic> service) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: service['onTap'],
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              service['image'],
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Flexible(
          child: Text(
            service['label'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _serviceItemSimple(Map<String, dynamic> service) {
    return InkWell(
      onTap: service['onTap'],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            service['image'],
            height: 30,
            width: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          Text(
            service['label'],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCardZone() {
    // Sample 4 cards
    List<Map<String, String>> cards = [
      {
        'title': 'Instant Payment',
        'subtitle': 'Credit Card Payment',
        'image': 'assets/images/first_card_icon.png',
      },
      {
        'title': 'VIA CREDIT CARD',
        'subtitle': 'Add money to your wallet',
        'image': 'assets/images/second_card_icon.png',
      },
      {
        'title': '5% CASHBOOK',
        'subtitle': 'Pay rent via credit card',
        'image': 'assets/images/third_card_icon.png',
      },
      {
        'title': '100% APPROVAL',
        'subtitle': 'SBM Mobikwik First Credit Card',
        'image': 'assets/images/forth_card_icon.png',
      },
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.blue_shade,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/credit_card_top_image.png",
                    height: 50,
                    width: 50,
                  ),

                  SizedBox(width: 20),

                  Text(
                    "Credit Card Zone",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Text("Add Card", style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // GridView with 4 cards
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cards.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 cards per row
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1, // adjust card height
            ),
            itemBuilder: (context, index) {
              final card = cards[index];
              return InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card["title"]!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        card["subtitle"]!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(), // pushes image to bottom
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          card['image']!,
                          height: 40,
                          width: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCreditscoreSection() {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/second_card_icon.png",
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Credit & Loans",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Text("Credit Score", style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Internal container with shadow
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xffE6EEFB),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "CREDIT SCORE",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "***/900",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.textColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          "Check Now",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Right Column: Image fits container height
                SizedBox(
                  height: 120,
                  child: Image.asset(
                    "assets/images/credit_score.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Reward & Refer containers full width
          Row(
            children: [
              // Reward Card
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 120, // 🔹 Fixed height for equal size
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffE6EEFB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // Texts on left
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Reward",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Get ₹ 200",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.textColor,
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: const Text(
                                  "4 New",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Image pinned bottom-right
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Image.asset(
                            "assets/images/gift.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Refer & Earn Card
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 120, // 🔹 Same height
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xffE6EEFB),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // Texts
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Refer & Earn",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Get 200",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Image pinned bottom-right
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Image.asset(
                            "assets/images/reward.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGetCreditCardSection() {
    // Dummy 4 card items
    List<String> cards = [
      "assets/images/card.png",
      "assets/images/card.png",
      "assets/images/card.png",
      "assets/images/card.png",
    ];

    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/get_credit_card.png",
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 8), // small spacing
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Get Your Own Credit Card",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Apply",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Text("View All", style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_ios, size: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Horizontal scroll cards
          SizedBox(
            height: 150, // container height for cards
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: cards.map((cardPath) {
                  return Container(
                    width: 200, // width of each card
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(cardPath, fit: BoxFit.cover),
                  );
                }).toList(),
              ),
            ),
          ),

          // Wrap with Align to take only the required width
          InkWell(
            onTap: () {},
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ), // optional padding
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(
                    4,
                  ), // optional rounded corners
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // important to wrap only content
                  children: [
                    Image.asset(
                      "assets/images/discount.png",
                      height: 10,
                      width: 10,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "Offers and many more",
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_right, size: 12),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          _bannerSection(),
        ],
      ),
    );
  }

  Widget _infoBadge({
    required String text,
    required String iconPath,
    Color backgroundColor = const Color(0xFFFFE4E1), // default pink shade
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(iconPath, height: 10, width: 10),
              const SizedBox(width: 4),
              Text(text, style: const TextStyle(fontSize: 10)),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFreeToolsSection() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Free Tools",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              // MF Tracker Card
              Expanded(
                child: _buildToolCard(
                  backgroundColor: Color(0xFFB8E6FF),
                  title: 'MF TRACKER',
                  subtitle: 'Track\nMutual\nFund\nPortfolio',
                  showPolicyIcon: true,

                  onTap: () {
                    // Handle MF Tracker tap
                    print('MF Tracker tapped');
                  },
                ),
              ),
              SizedBox(width: 12),

              // Easy Tax Filing Card
              Expanded(
                child: _buildToolCard(
                  backgroundColor: Color(0xFFFFF4E6),
                  title: '',
                  subtitle: 'Easy Tax\nFiling\nNow\nWith AI',
                  showPolicyIcon: true,

                  onTap: () {
                    // Handle Tax Filing tap
                    print('Tax Filing tapped');
                  },
                ),
              ),
              SizedBox(width: 12),

              // Policy Verification Card
              Expanded(
                child: _buildToolCard(
                  backgroundColor: Color(0xFFE6F7F1),
                  title: '',
                  subtitle: 'Verify\nyour\nPolicy\nInstantly',
                  showPolicyIcon: true,
                  onTap: () {
                    // Handle Policy Verification tap
                    print('Policy Verification tapped');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard({
    required Color backgroundColor,
    required String title,
    required String subtitle,
    bool showPolicyIcon = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title (if exists)
              if (title.isNotEmpty) ...[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 6),
              ],

              // Main content
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Bottom row with icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [if (showPolicyIcon) _buildPolicyIcon()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolicyIcon() {
    return Stack(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Icon(Icons.description, color: Color(0xFF4CAF50), size: 16),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection(BuildContext context) {
    // Dummy data with network image URLs
    final categories = ["Food", "Travel", "Fashion", "Tech", "Health"];
    final trendingItems = [
      {
        "image": "https://via.placeholder.com/120x90.png?text=Pizza",
        "title": "Pizza Discount",
        "subtitle": "Up to 50% off",
      },
      {
        "image": "https://via.placeholder.com/120x90.png?text=Hotel",
        "title": "Hotel Deal",
        "subtitle": "Save 30%",
      },
      {
        "image": "https://via.placeholder.com/120x90.png?text=Gadget",
        "title": "Gadget Sale",
        "subtitle": "Latest Tech",
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Text(
                "Trending Offers",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.local_fire_department, color: Colors.amber),
            ],
          ),
          SizedBox(height: 16),

          // First ListView - Categories
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),

          // Second ListView - Trending Items
          SizedBox(
            height: 150, // Adjust height according to your design
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendingItems.length,
              itemBuilder: (context, index) {
                final item = trendingItems[index];
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item["image"]!,
                          height: 90,
                          width: 120,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 90,
                              width: 120,
                              color: Colors.grey.shade200,
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        item["title"]!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item["subtitle"]!,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionDivider({double height = 16}) => SizedBox(height: height);
}

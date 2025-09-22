// // home_dashboard_ui.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:lottie/lottie.dart';
// import 'package:utility_app_flutter/controller/home_page_controller.dart';
// import 'package:utility_app_flutter/controller/userscreenscontrollers/user_home_controller.dart';
// import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
// import 'package:utility_app_flutter/widgets/app_button.dart';

// class UserHomeDashboard extends StatefulWidget {
//   const UserHomeDashboard({super.key});

//   @override
//   State<UserHomeDashboard> createState() => _UserHomeDashboardState();
// }

// class _UserHomeDashboardState extends State<UserHomeDashboard> {
//   final UserHomeController controller = Get.put(UserHomeController());

//   final List<String> bannerImages = [
//     'https://images.unsplash.com/photo-1545239351-1141bd82e8a6?w=1200',
//     'https://images.unsplash.com/photo-1508385082359-fc0a0b7f8a9a?w=1200',
//     'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=1200',
//   ];

//   int _currentBanner = 0;

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F8FB),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: AppColors.whiteshade,
//         centerTitle: false,
//         title: const Text(
//           'MyPay',
//           style: TextStyle(
//             color: AppColors.secondary,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.search, color: Colors.grey.shade700),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.notifications_none, color: Colors.grey.shade700),
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),

//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: _buildBalanceCard(width),
//           ),

//           /// Draggable Scrollable Card
//           DraggableScrollableSheet(
//             initialChildSize: 0.68,
//             minChildSize: 0.55,
//             maxChildSize: 0.95,
//             builder: (context, scrollController) {
//               return Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 12,
//                       offset: const Offset(0, -4),
//                     ),
//                   ],
//                 ),
//                 child: SingleChildScrollView(
//                   controller: scrollController,
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Drag handle
//                       Center(
//                         child: Container(
//                           width: 40,
//                           height: 4,
//                           margin: const EdgeInsets.only(bottom: 14),
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 8),
//                       _buildQuickActions(),
//                       const SizedBox(height: 14),
//                       _buildServicesGrid(),
//                       const SizedBox(height: 18),
//                       _buildBannerCarousel(),
//                       const SizedBox(height: 18),
//                       _buildTicketsSection(),
//                       _buildCreditScoreSection(),
//                       _buildRecentTransactions(),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   /// ---------------- WALLET BALANCE ----------------
//   Widget _buildBalanceCard(double width) {
//     return Obx(
//       () => Container(
//         width: width,
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18),
//           gradient: LinearGradient(
//             colors: [AppColors.primary, AppColors.secondary],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primary.withOpacity(0.2),
//               blurRadius: 14,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Wallet Balance',
//                     style: TextStyle(color: Colors.white70, fontSize: 13),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     controller.isBalanceVisible.value
//                         ? '₹${controller.walletBalance.value.toStringAsFixed(2)}'
//                         : '₹****',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 28,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       _smallActionBtn('Add', Icons.add, () {}),
//                       const SizedBox(width: 10),
//                       _smallActionBtn('Send', Icons.send, () {}),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 IconButton(
//                   onPressed: controller.toggleBalanceVisibility,
//                   icon: Icon(
//                     controller.isBalanceVisible.value
//                         ? Icons.visibility
//                         : Icons.visibility_off,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ---------------- TICKETS SECTION ----------------
//   Widget _buildTicketsSection() {
//     final tickets = [
//       {'icon': Icons.directions_bus, 'title': 'Bus'},
//       {'icon': Icons.flight_takeoff, 'title': 'Flights'},
//       {'icon': Icons.train, 'title': 'Trains'},
//       {'icon': Icons.movie, 'title': 'Movies'},
//       {'icon': Icons.event, 'title': 'Events'},
//     ];

//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Book Tickets",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 14),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: tickets.map((t) {
//               return Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 22,
//                     backgroundColor: AppColors.primary.withOpacity(0.1),
//                     child: Icon(
//                       t['icon'] as IconData,
//                       color: AppColors.secondary,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     t['title'] as String,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ---------------- CREDIT SCORE SECTION ----------------
//   Widget _buildCreditScoreSection() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Left: Circular progress
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 70,
//                 height: 70,
//                 child: CircularProgressIndicator(
//                   value: 0.65,
//                   strokeWidth: 6,
//                   valueColor: AlwaysStoppedAnimation(AppColors.secondary),
//                   backgroundColor: Colors.grey.shade200,
//                 ),
//               ),
//               const Text("650", style: TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//           const SizedBox(width: 16),

//           // Right: Text & Button
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Your Credit Score",
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 6),
//                 const Text(
//                   "Check your free credit score & improve it",
//                   style: TextStyle(fontSize: 12, color: Colors.grey),
//                 ),
//                 const SizedBox(height: 10),
//                 appButton(title: "Checknow", onTap: () {}),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _smallActionBtn(String label, IconData icon, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: Colors.white, size: 16),
//             const SizedBox(width: 6),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 13,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// ---------------- QUICK ACTIONS ----------------
//   Widget _buildQuickActions() {
//     final items = [
//       {
//         'img': "https://img.icons8.com/color/96/flash-on.png",
//         'label': 'Pay Bills',
//       },
//       {
//         'img': "https://img.icons8.com/color/96/android.png",
//         'label': 'Recharge',
//       },
//       {
//         'img': "https://img.icons8.com/color/96/money-transfer.png",
//         'label': 'Transfer',
//       },
//       // Do NOT add "More" here → it will be handled separately
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Quick Actions",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           height: 95,
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: 4, // always 4 items → 3 + "More"
//             separatorBuilder: (_, __) => const SizedBox(width: 10),
//             itemBuilder: (context, i) {
//               if (i == 3) {
//                 // Last index → Always More
//                 return InkWell(
//                   onTap: () {
//                     Get.find<HomePageController>().userchangeTab(1);
//                   },
//                   child: Container(
//                     width: 80,
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(color: Colors.grey.shade200, width: 1),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircleAvatar(
//                           radius: 20,
//                           backgroundColor: AppColors.primary.withOpacity(0.12),
//                           child: const Icon(
//                             Icons.more_horiz,
//                             color: Colors.grey,
//                             size: 22,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         const Text(
//                           "More",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 11,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }

//               final it = items[i];
//               return Container(
//                 width: 80,
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(14),
//                   border: Border.all(color: Colors.grey.shade200, width: 1),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundColor: AppColors.primary.withOpacity(0.12),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: Image.network(
//                           it['img']!,
//                           height: 20,
//                           width: 20,
//                           fit: BoxFit.contain,
//                           errorBuilder: (_, __, ___) => const Icon(
//                             Icons.broken_image,
//                             size: 20,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       it['label']!,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   /// ---------------- SERVICES GRID ----------------
//   Widget _buildServicesGrid() {
//     final services = [
//       {
//         'img': "https://img.icons8.com/color/96/electricity.png",
//         'title': 'Electricity',
//       },
//       {'img': "https://img.icons8.com/color/96/tv.png", 'title': 'DTH'},
//       {
//         'img': "https://img.icons8.com/color/96/fingerprint.png",
//         'title': 'AEPS',
//       },
//       {
//         'img': "https://img.icons8.com/color/96/insurance-agent.png",
//         'title': 'Insurance',
//       },
//       {'img': "https://img.icons8.com/color/96/bill.png", 'title': 'Bill Pay'},
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 8),
//         const Text(
//           "Services",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),

//         GridView.builder(
//           padding: const EdgeInsets.symmetric(vertical: 4),
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: services.length + 1, // +1 for "More"
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             mainAxisSpacing: 14,
//             crossAxisSpacing: 14,
//             childAspectRatio: 0.9,
//           ),
//           itemBuilder: (context, idx) {
//             if (idx == services.length) {
//               // Last item → Always "More"
//               return InkWell(
//                 onTap: () {
//                   Get.find<HomePageController>().userchangeTab(1);
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade50,
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(color: Colors.grey.shade200, width: 1),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       SizedBox(
//                         height: 38,
//                         width: 38,
//                         child: Icon(
//                           Icons.more_horiz,
//                           size: 32,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(height: 6),
//                       Text(
//                         "More",
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             final s = services[idx];
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.circular(14),
//                 border: Border.all(color: Colors.grey.shade200, width: 1),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 38,
//                     width: 38,
//                     child: Image.network(
//                       s['img']!,
//                       fit: BoxFit.contain,
//                       errorBuilder: (_, __, ___) =>
//                           const Icon(Icons.broken_image, color: Colors.grey),
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     s['title']!,
//                     style: const TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   /// ---------------- PROMO BANNERS ----------------
//   Widget _buildBannerCarousel() {
//     return Column(
//       children: [
//         CarouselSlider.builder(
//           itemCount: bannerImages.length,
//           itemBuilder: (context, idx, realIdx) {
//             final url = bannerImages[idx];
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: AspectRatio(
//                 aspectRatio: 16 / 7,
//                 child: Image.network(
//                   url,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   errorBuilder: (c, e, st) => Container(
//                     color: Colors.grey.shade200,
//                     child: const Center(
//                       child: Icon(
//                         Icons.broken_image,
//                         size: 40,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//           options: CarouselOptions(
//             height: 140,
//             autoPlay: true,
//             enlargeCenterPage: true,
//             viewportFraction: 0.92,
//             onPageChanged: (index, reason) =>
//                 setState(() => _currentBanner = index),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: bannerImages.asMap().entries.map((e) {
//             final bool active = e.key == _currentBanner;
//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               margin: const EdgeInsets.symmetric(horizontal: 6),
//               width: active ? 12 : 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 color: active ? AppColors.secondary : Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }

//   /// ---------------- TRANSACTIONS ----------------
//   Widget _buildRecentTransactions() {
//     final txs = [
//       {
//         'title': 'Airtel Recharge',
//         'subtitle': 'Mobile • 9876543210',
//         'amount': '-₹299',
//         'color': Colors.red,
//       },
//       {
//         'title': 'Electricity Bill',
//         'subtitle': 'BSES • Aug',
//         'amount': '-₹1,250',
//         'color': Colors.red,
//       },
//       {
//         'title': 'Money Received',
//         'subtitle': 'From John',
//         'amount': '+₹500',
//         'color': Colors.green,
//       },
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Recent Transactions',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         ...txs.map((t) {
//           final String title = t['title'] as String;
//           final String subtitle = t['subtitle'] as String;
//           final String amount = t['amount'] as String;
//           final Color color = t['color'] as Color;

//           return Container(
//             margin: const EdgeInsets.only(bottom: 10),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 8,
//                   offset: const Offset(0, 6),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 22,
//                   backgroundColor: AppColors.primary.withOpacity(0.1),
//                   child: Icon(Icons.currency_rupee, color: AppColors.secondary),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: const TextStyle(fontWeight: FontWeight.w700),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         subtitle,
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   amount,
//                   style: TextStyle(fontWeight: FontWeight.bold, color: color),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//       ],
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:utility_app_flutter/controller/home_page_controller.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/user_home_controller.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';

class UserHomeDashboard extends StatefulWidget {
  const UserHomeDashboard({super.key});

  @override
  State<UserHomeDashboard> createState() => _UserHomeDashboardState();
}

class _UserHomeDashboardState extends State<UserHomeDashboard>
    with TickerProviderStateMixin {
  final UserHomeController controller = Get.put(UserHomeController());

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

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
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildWelcomeSection(),
                  _buildSectionDivider(),
                  _buildBalanceCard(),
                  _buildSectionDivider(height: 24),
                  _buildQuickActionsSection(),
                  _buildSectionDivider(),
                  _buildServicesSection(),
                  _buildSectionDivider(),
                  _buildBannerCarouselSection(),
                  _buildSectionDivider(),
                  _buildTicketsSection(),
                  _buildSectionDivider(),
                  _buildCreditScoreSection(),
                  _buildSectionDivider(),
                  _buildRecentTransactions(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- APP BAR --------------------
  // -------------------- SECTION DIVIDER --------------------
  Widget _buildSectionDivider({double height = 16}) {
    return SizedBox(height: height);
  }

  // -------------------- ENHANCED SECTION WRAPPER --------------------
  Widget _buildSectionContainer({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    bool addBackground = false,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      margin: margin,
      decoration: addBackground
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            )
          : null,
      child: child,
    );
  }

  // -------------------- APP BAR --------------------
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
                        Icons.account_balance_wallet,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "MyPay",
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

  static Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
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

  static Widget _buildProfileAvatar() {
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

  // -------------------- WELCOME SECTION --------------------
  Widget _buildWelcomeSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: _buildSectionContainer(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good ${_getGreeting()}!',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.userName.value,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.green.shade200, width: 1),
                ),
                child: Row(
                  children: const [
                    CircleAvatar(radius: 4, backgroundColor: Colors.green),
                    SizedBox(width: 8),
                    Text(
                      "Online",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------- BALANCE CARD --------------------
  Widget _buildBalanceCard() {
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
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.new_blue, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                /// Balance + Animation Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),

                          /// Amount + Eye in same row
                          Row(
                            children: [
                              Text(
                                controller.isBalanceVisible.value
                                    ? "₹ ${NumberFormat("#,##0.00").format(controller.walletBalance.value)}"
                                    : "₹ ****",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                    ),

                    /// Lottie Animation (on right side)
                    Lottie.asset(
                      'assets/json/4r09bDTBS6.json',
                      height: 50,
                      repeat: true,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// Actions Row
                Row(
                  children: [
                    Expanded(
                      child: _buildBalanceAction(
                        'Add Money',
                        Icons.add_circle_outline,
                        () => controller.addMoney(500),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildBalanceAction(
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

  Widget _buildBalanceAction(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
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

  // -------------------- QUICK ACTIONS SECTION --------------------
  Widget _buildQuickActionsSection() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final items = [
      {
        'img': "https://img.icons8.com/color/96/flash-on.png",
        'label': 'Pay Bills',
      },
      {
        'img': "https://img.icons8.com/color/96/android.png",
        'label': 'Recharge',
      },
      {
        'img': "https://img.icons8.com/color/96/money-transfer.png",
        'label': 'Transfer',
      },
    ];

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          if (i == 3) {
            return InkWell(
              onTap: () {
                Get.find<HomePageController>().userchangeTab(1);
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 80,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "More",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final it = items[i];
          return Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      it['img']!,
                      height: 20,
                      width: 20,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.broken_image,
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  it['label']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A5568),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // -------------------- SERVICES SECTION --------------------
  Widget _buildServicesSection() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A202C),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.find<HomePageController>().userchangeTab(1);
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildServicesGrid(),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      {
        'img': "https://img.icons8.com/color/96/electricity.png",
        'title': 'Electricity',
      },
      {'img': "https://img.icons8.com/color/96/tv.png", 'title': 'DTH'},
      {
        'img': "https://img.icons8.com/color/96/fingerprint.png",
        'title': 'AEPS',
      },
      {
        'img': "https://img.icons8.com/color/96/insurance-agent.png",
        'title': 'Insurance',
      },
      {'img': "https://img.icons8.com/color/96/bill.png", 'title': 'Bill Pay'},
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, idx) {
        if (idx == services.length) {
          return InkWell(
            onTap: () {
              Get.find<HomePageController>().userchangeTab(1);
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 38,
                    width: 38,
                    child: Icon(Icons.more_horiz, size: 28, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "More",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A5568),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final s = services[idx];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 38,
                width: 38,
                child: Image.network(
                  s['img']!,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                s['title']!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A5568),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // -------------------- BANNER CAROUSEL SECTION --------------------
  Widget _buildBannerCarouselSection() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Special Offers",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),
          _buildBannerCarousel(),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: controller.bannerImages.length,
          itemBuilder: (context, idx, realIdx) {
            final url = controller.bannerImages[idx];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 7,
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
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
        const SizedBox(height: 12),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.bannerImages.asMap().entries.map((e) {
              final bool active = e.key == controller.currentBanner.value;
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
          ),
        ),
      ],
    );
  }

  // -------------------- TICKETS SECTION --------------------
  Widget _buildTicketsSection() {
    final tickets = [
      {'icon': Icons.directions_bus, 'title': 'Bus'},
      {'icon': Icons.flight_takeoff, 'title': 'Flights'},
      {'icon': Icons.train, 'title': 'Trains'},
      {'icon': Icons.movie, 'title': 'Movies'},
      {'icon': Icons.event, 'title': 'Events'},
    ];

    return _buildSectionContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      addBackground: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Book Tickets",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tickets.map((t) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      t['icon'] as IconData,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t['title'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // -------------------- CREDIT SCORE SECTION --------------------
  Widget _buildCreditScoreSection() {
    return _buildSectionContainer(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      addBackground: true,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    value: 0.65,
                    strokeWidth: 6,
                    valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
                const Text(
                  "650",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Credit Score",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Check your free credit score & improve it",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                appButton(title: "Check Now", onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- TRANSACTIONS --------------------
  Widget _buildRecentTransactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryC,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.find<HomePageController>().userchangeTab(3);
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.phone_android, color: Colors.blue),
                  title: Text("Mobile Recharge"),
                  subtitle: Text("Airtel - 9876543210"),
                  trailing: Text(
                    "-₹299",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.flash_on, color: Colors.orange),
                  title: Text("Electricity Bill"),
                  subtitle: Text("BSES - Payment"),
                  trailing: Text(
                    "-₹1250",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.green,
                  ),
                  title: Text("Money Received"),
                  subtitle: Text("From: John Smith"),
                  trailing: Text(
                    "+₹500",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- HELPER --------------------
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}

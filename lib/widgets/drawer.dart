import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/home_page_controller.dart';
import 'package:utility_app_flutter/screens/home/reports/fund_track.dart';
import 'package:utility_app_flutter/screens/home/reports/payout_transaction_report.dart';
import 'package:utility_app_flutter/screens/home/usersection/order_asset_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/track_enquiry.dart';
import 'package:utility_app_flutter/screens/home/usersection/view_plans.dart';
import 'package:utility_app_flutter/screens/home/usersection/fund_request.dart';
import 'package:utility_app_flutter/screens/home/reports/pay_in_transection_report.dart';
import 'package:utility_app_flutter/utils/Constants/appimage.dart';
import '../utils/Constants/app_colors.dart';
import '../utils/Constants/screen_size.dart';
import '../screens/home/reports/bbps_report.dart';
import '../screens/home/usersection/enquiry_form.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Drawer(
      width: ScreenSize.width * 0.85,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 🔹 Top Row: Logo + Rectangular Close Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Image.network(
                    "https://img.icons8.com/color/48/000000/flutter.png",
                    height: 40,
                    width: 40,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Scaffold.of(context).closeDrawer(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.appbarsecondColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Top Gradient Section with Profile & QR
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.appbarFirstColor,
                    AppColors.appbarsecondColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: const NetworkImage(
                          "https://randomuser.me/api/portraits/men/32.jpg",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Saurav',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Retailer',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/d/d0/QR_code_for_mobile_English_Wikipedia.svg",
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Drawer Items
            _buildListTile(
                            context: context,

              imageUrl: Appimage.drawer_home,
              title: 'Home',
              onTap: () => Get.back(),
            ),

            _buildExpansionTile(
              imageUrl: Appimage.plans,
              title: 'Plans Management',
              children: [
                _buildListTileSvg(
                                context: context,

                  iconPath: 'assets/icons/carbon_data-view.svg',
                  title: 'View Plans',
                  onTap: () => Get.to(() => const ViewPlans()),
                ),
                _buildListTileSvg(
                                context: context,

                  iconPath: 'assets/icons/akar-icons_wallet.svg',
                  title: 'BY Pass Plan',
                  onTap: () {},
                ),
              ],
            ),

            _buildExpansionTile(
              imageUrl: Appimage.payin,
              title: 'Payin Payout Report',
              children: [
                _buildListTileSvg(
                                context: context,

                  iconPath:
                      'assets/icons/icon-park-outline_people-plus-one.svg',
                  title: 'Payin',
                  onTap: () => Get.to(() => const PayinTransactionScreen()),
                  backgroundColor: Colors.purple.shade100,
                ),
                _buildListTileSvg(
                                context: context,

                  iconPath:
                      'assets/icons/icon-park-twotone_people-download.svg',
                  title: 'Payout',
                  onTap: () => Get.to(() => PayoutTransactionReport()),
                ),
              ],
            ),

            _buildListTile(
                            context: context,

              imageUrl: Appimage.ewallet,
              title: 'E-Wallet Report',
              onTap: () {
                Get.find<HomePageController>().userchangeTab(3);
              },
            ),

            _buildListTile(
                            context: context,

              iconData: Icons.shopping_bag,
              title: 'Order Asset',
              onTap: () => Get.to(() => OrderAssetScreen()),
            ),

            _buildExpansionTile(
              imageUrl: Appimage.enquiry,
              title: 'Enquiry',
              children: [
                _buildListTileSvg(
                                context: context,

                  iconPath: 'assets/icons/la_hand-paper-solid.svg',
                  title: 'Raise Enquiry',
                  onTap: () => Get.to(() => const EnquiryFormView()),
                  backgroundColor: Colors.blue.shade100,
                ),
                _buildListTileSvg(
                                context: context,

                  iconPath: 'assets/icons/la_hand-paper-solid.svg',
                  title: 'Track Enquiry',
                  onTap: () => Get.to(() => const TrackEnquiry()),
                  backgroundColor: Colors.blue.shade100,
                ),
              ],
            ),

            _buildExpansionTile(
              imageUrl: Appimage.fund,
              title: 'Fund',
              children: [
                _buildListTileSvg(
                                context: context,

                  iconPath: 'assets/icons/carbon_request-quote.svg',
                  title: 'Fund Request',
                  onTap: () => Get.to(() => const FundRequestView()),
                  backgroundColor: Colors.teal.shade100,
                ),
                _buildListTileSvg(
                                context: context,

                  iconPath: 'assets/icons/carbon_request-quote.svg',
                  title: 'Fund Request Tracking',
                  onTap: () => Get.to(() => const FundTrack()),
                  backgroundColor: Colors.teal.shade100,
                ),
              ],
            ),

            _buildListTile(
                            context: context,

              imageUrl: Appimage.bbps_report,
              title: 'BBPS Report',
              onTap: () => Get.to(() => const BBPSReportView()),
            ),

            _buildListTile(
              context: context,
              imageUrl: Appimage.all_services,
              title: 'All Services',
              onTap: () {
                Get.find<HomePageController>().userchangeTab(1);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// ListTile with Icon, Image, or SVG
  Widget _buildListTile({
    required BuildContext context,

    IconData? iconData,
    String? imageUrl,
    required String title,
    required VoidCallback onTap,
    Color? backgroundColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      horizontalTitleGap: 10,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: iconData != null
            ? Icon(iconData, color: Colors.white, size: 20)
            : imageUrl != null
            ? Image.asset(imageUrl, height: 40, width: 40)
            : const SizedBox(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // closes only the drawer

        onTap();
      },
    );
  }

  Widget _buildListTileSvg({
    required BuildContext context,
    required String iconPath,
    required String title,
    required VoidCallback onTap,
    Color? backgroundColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      horizontalTitleGap: 10,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(
          iconPath,
          width: 20,
          height: 20,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // closes only the drawer

        onTap();
      },
    );
  }

  /// ExpansionTile with icon, image, or SVG
  Widget _buildExpansionTile({
    IconData? iconData,
    String? imageUrl,
    String? iconPath,
    required String title,
    required List<Widget> children,
    Color? backgroundColor,
  }) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: iconData != null
              ? Icon(iconData, color: Colors.white, size: 20)
              : imageUrl != null
              ? Image.asset(imageUrl, width: 40, height: 40)
              : iconPath != null
              ? SvgPicture.asset(
                  iconPath,
                  width: 20,
                  height: 20,
                  color: Colors.white,
                )
              : const SizedBox(),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppColors.textColor,
        ),
        childrenPadding: const EdgeInsets.only(left: 40),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/screens/home/retailerSection/service_management.dart';
import 'package:utility_app_flutter/screens/home/usersection/view_plans.dart';
import 'package:utility_app_flutter/screens/home/usersection/fund_request.dart';
import 'package:utility_app_flutter/screens/home/usersection/pay_in_transection_report.dart';
import 'package:utility_app_flutter/utils/Constants/screen_size.dart';

import '../../../utils/Constants/app_colors.dart';
import '../usersection/bbps_report.dart';
import '../usersection/enquiry_form.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Drawer(
      width: ScreenSize.width * 0.8,
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            // Close button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Scaffold.of(context).closeDrawer(),
                icon: const Icon(Icons.close, color: Colors.black, size: 32),
              ),
            ),

            // Profile Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: AppColors.textColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Saurav',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Retailer',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Banner / Image
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.04,
                vertical: 10,
              ),
              child: Image.asset('assets/images/image 57.png'),
            ),

            // Drawer Items
            _buildListTile(
              icon: Icons.home_outlined,
              title: 'Dashboard',
              onTap: () => Get.back(),
            ),

            _buildExpansionTile(
              iconPath: 'assets/icons/Vector (2).svg',
              title: 'Plans Management',
              children: [
                _buildListTileSvg(
                  iconPath: 'assets/icons/carbon_data-view.svg',
                  title: 'View Plans',
                  onTap: () => Get.to(() => const ViewPlans()),
                ),
                _buildListTileSvg(
                  iconPath: 'assets/icons/akar-icons_wallet.svg',
                  title: 'BY Pass Plan',
                  onTap: () {
                    // TODO: Navigate to BY Pass Plan screen
                  },
                ),
              ],
            ),

            _buildExpansionTile(
              iconPath: 'assets/icons/Vector (3).svg',
              title: 'Payin Payout Report',
              children: [
                _buildListTileSvg(
                  iconPath:
                  'assets/icons/icon-park-outline_people-plus-one.svg',
                  title: 'Payin',
                  onTap: () => Get.to(() => const PayinTransactionScreen()),
                ),
                _buildListTileSvg(
                  iconPath:
                  'assets/icons/icon-park-twotone_people-download.svg',
                  title: 'Payout',
                  onTap: () {
                    // TODO: Navigate to Payout screen
                  },
                ),
              ],
            ),

            _buildListTileSvg(
              iconPath: 'assets/icons/akar-icons_wallet.svg',
              title: 'E-Wallet Report',
              onTap: () => Get.back(),
            ),

            _buildExpansionTile(
              iconPath: 'assets/icons/akar-icons_info.svg',
              title: 'Enquiry',
              children: [
                _buildListTileSvg(
                  iconPath: 'assets/icons/la_hand-paper-solid.svg',
                  title: 'Raise Enquiry',
                  onTap: () => Get.to(() => const EnquiryFormView()),
                ),
              ],
            ),

            _buildExpansionTile(
              iconPath: 'assets/icons/icon-park_funds.svg',
              title: 'Fund',
              children: [
                _buildListTileSvg(
                  iconPath: 'assets/icons/carbon_request-quote.svg',
                  title: 'Fund Request',
                  onTap: () => Get.to(() => const FundRequestView()),
                ),
              ],
            ),

            _buildListTileSvg(
              iconPath: 'assets/icons/tabler_report.svg',
              title: 'BBPS Report',
              onTap: () => Get.to(() => const BBPSReportView()),
            ),

            _buildListTileSvg(
              iconPath: 'assets/icons/grommet-icons_services.svg',
              title: 'All Services',
              onTap: () => Get.back(),
            ),

            _buildListTileSvg(
              iconPath: 'assets/icons/mdi_account-service.svg',
              title: 'Service Management',
              onTap: () => Get.to(() => const ServiceManagement()),
            ),
          ],
        ),
      ),
    );
  }

  /// Common ListTile
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textColor),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  /// Common ListTile with SVG
  Widget _buildListTileSvg({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: SvgPicture.asset(iconPath, color: AppColors.textColor),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  /// Common ExpansionTile
  Widget _buildExpansionTile({
    required String iconPath,
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      leading: SvgPicture.asset(iconPath, color: AppColors.textColor),
      showTrailingIcon: false,
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppColors.textColor,
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.transparent),
      ),
      childrenPadding: const EdgeInsets.only(left: 40),
      children: children,
    );
  }
}
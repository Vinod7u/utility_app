import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/user_profile_controller.dart';
import 'package:utility_app_flutter/screens/auth/login.dart';
import 'package:utility_app_flutter/screens/home/usersection/aboutus_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/grievancy_policy.dart';
import 'package:utility_app_flutter/screens/home/usersection/privacy_policy_screen.dart';
import 'package:utility_app_flutter/widgets/drawer.dart';
import 'package:utility_app_flutter/screens/home/usersection/personal_info_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/security_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_account_info_screen.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_help_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _buildCustomAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Profile Card
                  _buildProfile(),
                  const SizedBox(height: 12),
                  Divider(color: Colors.blueGrey.shade200, thickness: 1),
                  const SizedBox(height: 12),

                  /// KYC
                  _buildKycSection(),
                  const SizedBox(height: 12),

                  /// Rewards + Refer - UNCOMMENTED
                  Row(
                    children: [
                      Expanded(child: _buildRewardsContainer()),
                      const SizedBox(
                        width: 8,
                      ), // Add spacing between containers
                      Expanded(child: _buildReferFriendContainer()),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Manage Section
                  const Text(
                    "Manage",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildActionTile(
                    "assets/images/personal_Info.png",
                    "Personal info",
                    () {
                      Get.to(() => PersonalInfoScreen());
                    },
                  ),
                  _buildActionTile("assets/images/account.png", "Accounts", () {
                    Get.to(() => UserAccountInfoScreen());
                  }),
                  const SizedBox(height: 20),

                  /// Support & Legal Section
                  const Text(
                    "Support & Manage",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildActionTile("assets/images/help.png", "Help", () {
                    Get.to(() => UserHelpScreen());
                  }),
                  _buildActionTile("assets/images/report.png", "Report", () {}),
                  _buildActionTile(
                    "assets/images/security.png",
                    "Security",
                    () {
                      Get.to(() => SecurityScreen());
                    },
                  ),
                  _buildActionTile(
                    "assets/images/grivencePolicy.png",
                    "Grievance Policy",
                    () {
                      Get.to(() => GrievancePolicyScreen());
                    },
                  ),
                  _buildActionTile(
                    "assets/images/privacy_policy.png",
                    "Privacy Policy",
                    () {
                      Get.to(() => PrivacyPolicyScreen());
                    },
                  ),
                  _buildActionTile(
                    "assets/images/about_us.png",
                    "About us",
                    () {
                      Get.to(() => AboutUsScreen());
                    },
                  ),

                  _buildActionTile("assets/images/about_us.png", "Logout", () {
                    Get.offAll(() => Login());
                  }),
                  const SizedBox(height: 80), // Space for bottom navigation
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Profile - UNCHANGED
  Widget _buildProfile() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Left: Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Vinod Sain",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "6547893210",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "vinod@123",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          /// Right: Profile Image + QR
          Obx(
            () => Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: (controller.image_url.value).isNotEmpty
                      ? NetworkImage(controller.image_url.value)
                      : const AssetImage(
                              "assets/images/profile_placeholder.png",
                            )
                            as ImageProvider,
                ),
                Positioned(
                  bottom: -15,
                  right: 0,
                  child: Image.asset(
                    "assets/images/qr_image.png",
                    height: 40,
                    width: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// KYC - UNCHANGED
  Widget _buildKycSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.blue_shade,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: SvgPicture.asset("assets/icons/solar_shield-star-bold.svg"),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Complete KYC",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Unlock your wallet",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text("Start now"),
          ),
        ],
      ),
    );
  }

  /// Rewards - UNCHANGED
  Widget _buildRewardsContainer() {
    return Container(
      width: double.infinity, // Ensure container takes full available width
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        // Changed from Row to Column for better layout
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/material-symbols_cards-star-outline (1).svg",
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Text(
                "20 rewards",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              Text(
                "View now",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Refer Friend - UNCHANGED
  Widget _buildReferFriendContainer() {
    return Container(
      width: double.infinity, // Ensure container takes full available width
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        // Changed from Row to Column for better layout
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/icons/material-symbols_contacts-product.svg",
          ),
          const SizedBox(height: 20),

          Column(
            children: [
              Text(
                "Get ₹201",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue_text,
                ),
              ),
              Text(
                "refer a friend",
                style: TextStyle(fontSize: 14, color: AppColors.blue_text),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Custom AppBar - UNCHANGED
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
                  child: Builder(
                    builder: (context) {
                      return _buildAppBarIcon(Icons.menu, () {
                        Scaffold.of(context).openDrawer();
                      });
                    },
                  ),
                ),
                const Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildAppBarIcon(Icons.more_vert, () {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// AppBar Icon - UNCHANGED
  Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  /// Action Tile - UNCHANGED
  Widget _buildActionTile(String icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Image.asset(icon, height: 30, width: 20),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),

          Divider(color: Colors.blueGrey.shade200, thickness: 0.2),
        ],
      ),

      onTap: onTap,
    );
  }

  /// NEW METHODS - Bottom Navigation and Floating Button
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/user_profile_controller.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // 🔹 Profile card
                    Card(
                      color: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    controller.image_url.value.isNotEmpty
                                    ? NetworkImage(controller.image_url.value)
                                    : const AssetImage(
                                            "assets/images/profile_placeholder.png",
                                          )
                                          as ImageProvider,
                              ),
                            ),
                            const SizedBox(height: 14),
                            const Text(
                              "Full Name",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "user@example.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Sections
                    _buildSection("Personal Info", [
                      _buildTile(Icons.phone, "Mobile Number", "9876543210"),
                      _buildTile(Icons.email, "Email ID", "user@example.com"),
                      _buildTile(
                        Icons.home,
                        "Address",
                        "Street, District, State, Pincode",
                      ),
                    ]),

                    _buildSection("Documents", [
                      _buildTile(
                        Icons.badge,
                        "Aadhaar Number",
                        "XXXX-XXXX-XXXX",
                      ),
                      _buildTile(Icons.upload, "Aadhaar Upload", "aadhaar.pdf"),
                      _buildTile(Icons.credit_card, "PAN Number", "ABCDE1234F"),
                      _buildTile(Icons.upload, "PAN Upload", "pan.pdf"),
                    ]),

                    _buildSection("Bank Details", [
                      _buildTile(
                        Icons.account_balance,
                        "Bank Account",
                        "SBI Bank - 1234567890",
                      ),
                      _buildTile(
                        Icons.upload,
                        "Cancelled Cheque",
                        "cheque.jpg",
                      ),
                    ]),

                    _buildSection("Other", [
                      _buildTile(Icons.person, "Nominee", "Suresh Kumar"),
                      _buildTile(
                        Icons.location_on,
                        "Geo Location",
                        "26.9124° N, 75.7873° E",
                      ),
                      _buildTile(Icons.camera_alt, "Live Photo", "selfie.jpg"),
                      _buildTile(Icons.check_circle, "T&C Accepted", "Yes"),
                      _buildTile(Icons.computer, "IP Address", "192.168.1.1"),
                    ]),

                    // 🔹 New Section: More Options
                    _buildSection("More Options", [
                      _buildActionTile(
                        Icons.help_outline,
                        "Help & Support",
                        () {
                          // TODO: Navigate to Help screen
                        },
                      ),
                      _buildActionTile(Icons.info_outline, "About Us", () {
                        // TODO: Navigate to About screen
                      }),
                      _buildActionTile(
                        Icons.privacy_tip_outlined,
                        "Privacy Policy",
                        () {
                          // TODO: Navigate to Privacy Policy screen
                        },
                      ),
                    ]),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Custom App Bar
  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 110,
      floating: true,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    _buildAppBarIcon(Icons.edit, () {
                      // TODO: Edit Profile action
                    }),
                    const SizedBox(width: 10),
                    _buildAppBarIcon(Icons.logout, () {
                      // TODO: Logout action
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 AppBar Icon
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

  /// 🔹 Section with title
  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  /// 🔹 Profile Info Tile
  Widget _buildTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }

  /// 🔹 Action Tile (navigations like Help, About, Privacy Policy)
  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}

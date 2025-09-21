import 'package:flutter/material.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required UserType userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile"), centerTitle: true),
      body: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile picture
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                const SizedBox(height: 16),

                // Name
                const Text(
                  "Full Name",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                // Common fields
                _buildTile(Icons.phone, "Mobile Number", "9876543210"),
                _buildTile(Icons.email, "Email ID", "user@example.com"),

                const Divider(),

                // Example: Address
                _buildTile(
                  Icons.home,
                  "Address",
                  "Street, District, State, Pincode",
                ),

                // Example: Aadhaar
                _buildTile(Icons.badge, "Aadhaar Number", "XXXX-XXXX-XXXX"),
                _buildTile(Icons.upload, "Aadhaar Upload", "aadhaar.pdf"),

                // Example: PAN
                _buildTile(Icons.credit_card, "PAN Number", "ABCDE1234F"),
                _buildTile(Icons.upload, "PAN Upload", "pan.pdf"),

                // Example: Bank
                _buildTile(
                  Icons.account_balance,
                  "Bank Account Details",
                  "SBI Bank - 1234567890",
                ),
                _buildTile(
                  Icons.upload,
                  "Cancelled Cheque / Passbook",
                  "cheque.jpg",
                ),

                // Example: Nominee
                _buildTile(Icons.person, "Nominee", "Suresh Kumar"),

                // Example: Geo-location
                _buildTile(
                  Icons.location_on,
                  "Geo Location",
                  "26.9124° N, 75.7873° E",
                ),

                // Example: Live Photo
                _buildTile(Icons.camera_alt, "Live Photo", "selfie.jpg"),

                // Example: Terms & Conditions
                _buildTile(Icons.check_circle, "T&C Accepted", "Yes"),

                // Example: IP Address
                _buildTile(Icons.computer, "IP Address", "192.168.1.1"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}

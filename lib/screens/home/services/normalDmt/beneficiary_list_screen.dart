import 'package:flutter/material.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class BeneficiaryListScreen extends StatefulWidget {
  const BeneficiaryListScreen({super.key});

  @override
  State<BeneficiaryListScreen> createState() => _BeneficiaryListScreenState();
}

class _BeneficiaryListScreenState extends State<BeneficiaryListScreen> {
  // Dummy data list
  final List<Map<String, String>> beneficiaries = [
    {
      "name": "John Doe",
      "mobile": "9876543210",
      "accountNO": "123456789012",
      "bank": "HDFC",
      "ifsc": "HDFC0001234",
      "id": "B001",
      "verified": "Yes",
      "action": "Edit",
    },
    {
      "name": "Jane Smith",
      "mobile": "9123456780",
      "accountNO": "987654321098",
      "bank": "SBI",
      "ifsc": "SBIN0005678",
      "id": "B002",
      "verified": "No",
      "action": "Edit",
    },
    {
      "name": "Robert Brown",
      "mobile": "9988776655",
      "accountNO": "112233445566",
      "bank": "ICICI",
      "ifsc": "ICIC0009876",
      "id": "B003",
      "verified": "Yes",
      "action": "Edit",
    },
  ];

  List<Map<String, String>> filteredBeneficiaries = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredBeneficiaries = beneficiaries;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredBeneficiaries = beneficiaries.where((beneficiary) {
        final name = beneficiary["name"]!.toLowerCase();
        final mobile = beneficiary["mobile"]!.toLowerCase();
        final bank = beneficiary["bank"]!.toLowerCase();
        return name.contains(query) ||
            mobile.contains(query) ||
            bank.contains(query);
      }).toList();
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
      body: Column(
        children: [
          // --- SEARCH FIELD ---
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name, mobile or bank",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // --- LIST ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredBeneficiaries.length,
              itemBuilder: (context, index) {
                final data = filteredBeneficiaries[index];
                return _buildListCard(
                  name: data["name"]!,
                  mobile: data["mobile"]!,
                  accountNO: data["accountNO"]!,
                  bank: data["bank"]!,
                  ifsc: data["ifsc"]!,
                  id: data["id"]!,
                  verified: data["verified"]!,
                  action: data["action"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard({
    required String name,
    required String mobile,
    required String accountNO,
    required String bank,
    required String ifsc,
    required String id,
    required String verified,
    required String action,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Name + Verified
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: verified == "Yes" ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    verified,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Row 2: Bank + Account
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Bank: $bank", style: const TextStyle(fontSize: 14)),
                Text("Acc: $accountNO", style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 4),
            // Row 3: Mobile + IFSC
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Mobile: $mobile", style: const TextStyle(fontSize: 14)),
                Text("IFSC: $ifsc", style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 8),
            // Edit Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Edit clicked for $name")),
                  );
                },
                child: const Text(
                  "Edit",
                  style: TextStyle(
                    color: AppColors.darkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

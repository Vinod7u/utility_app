import 'package:flutter/material.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class DmtTransactionHistory extends StatefulWidget {
  const DmtTransactionHistory({super.key});

  @override
  State<DmtTransactionHistory> createState() => _DmtTransactionHistoryState();
}

class _DmtTransactionHistoryState extends State<DmtTransactionHistory> {
  final List<Map<String, String>> transactions = [
    {
      "name": "John Doe",
      "date": "2025-10-01",
      "amount": "5000",
      "status": "Success",
      "referenceNo": "TXN12345",
    },
    {
      "name": "Jane Smith",
      "date": "2025-10-02",
      "amount": "2500",
      "status": "Failed",
      "referenceNo": "TXN12346",
    },
    {
      "name": "Robert Brown",
      "date": "2025-10-03",
      "amount": "10000",
      "status": "Success",
      "referenceNo": "TXN12347",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final data = transactions[index];
          return _buildListCard(
            name: data["name"]!,
            date: data["date"]!,
            amount: data["amount"]!,
            status: data["status"]!,
            referenceNo: data["referenceNo"]!,
          );
        },
      ),
    );
  }

  Widget _buildListCard({
    required String name,
    required String date,
    required String amount,
    required String status,
    required String referenceNo,
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
            // Row 1: Name + Status
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
                    color: status == "Success" ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Row 2: Date + Reference No
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date: $date", style: const TextStyle(fontSize: 14)),
                Text("Ref: $referenceNo", style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 4),
            // Row 3: Amount
            Text("Amount: ₹$amount", style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

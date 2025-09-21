import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {
      "title": "Mobile Recharge",
      "subtitle": "Airtel - 9876543210",
      "amount": "-₹299",
      "icon": Icons.phone_android,
      "color": const Color(0xFF45B7D1),
      "time": "Today, 2:30 PM",
    },
    {
      "title": "Electricity Bill",
      "subtitle": "BSES - Payment",
      "amount": "-₹1,250",
      "icon": Icons.flash_on,
      "color": const Color(0xFFFF6B6B),
      "time": "Yesterday, 10:15 AM",
    },
    {
      "title": "Money Received",
      "subtitle": "From: John Smith",
      "amount": "+₹500",
      "icon": Icons.account_balance_wallet,
      "color": const Color(0xFF96CEB4),
      "time": "Sep 15, 6:45 PM",
    },
    {
      "title": "DTH Recharge",
      "subtitle": "Tata Sky - 123456",
      "amount": "-₹399",
      "icon": Icons.tv,
      "color": const Color(0xFFC471ED),
      "time": "Sep 10, 8:00 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
        centerTitle: true,
        backgroundColor: const Color(0xFF667eea),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _transactions.length,
        separatorBuilder: (context, index) => const Divider(height: 20),
        itemBuilder: (context, index) {
          final tx = _transactions[index];
          return _buildTransactionItem(
            tx["title"],
            tx["subtitle"],
            tx["amount"],
            tx["icon"],
            tx["color"],
            tx["time"],
          );
        },
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String subtitle,
    String amount,
    IconData icon,
    Color iconColor,
    String time,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: amount.startsWith('+')
                ? const Color(0xFF2ECC71)
                : const Color(0xFFE74C3C),
          ),
        ),
      ],
    );
  }
}

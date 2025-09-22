import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UserTransactionController extends GetxController {
  var transactions = <Map<String, dynamic>>[
    {
      "title": "Mobile Recharge",
      "subtitle": "Airtel - 9876543210",
      "amount": "-₹299",
      "icon": Icons.phone_android,
      "time": "Today, 2:30 PM",
    },
    {
      "title": "Electricity Bill",
      "subtitle": "BSES - Payment",
      "amount": "-₹1,250",
      "icon": Icons.flash_on,
      "time": "Yesterday, 10:15 AM",
    },
    {
      "title": "Money Received",
      "subtitle": "From: John Smith",
      "amount": "+₹500",
      "icon": Icons.account_balance_wallet,
      "time": "Sep 15, 6:45 PM",
    },
    {
      "title": "DTH Recharge",
      "subtitle": "Tata Sky - 123456",
      "amount": "-₹399",
      "icon": Icons.tv,
      "time": "Sep 10, 8:00 PM",
    },
  ].obs;

  var selectedFilter = "All".obs;
  var searchQuery = "".obs;
  var isSearching = false.obs;

  // Filter + Search logic
  List<Map<String, dynamic>> get filteredTransactions {
    List<Map<String, dynamic>> list = transactions;

    if (selectedFilter.value == "Credit") {
      list = list.where((tx) => tx["amount"].toString().startsWith("+")).toList();
    } else if (selectedFilter.value == "Debit") {
      list = list.where((tx) => tx["amount"].toString().startsWith("-")).toList();
    }

    if (searchQuery.value.isNotEmpty) {
      list = list
          .where((tx) =>
              tx["title"].toString().toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              tx["subtitle"].toString().toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    return list;
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) searchQuery.value = "";
  }
}

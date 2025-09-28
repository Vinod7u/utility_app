import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackEnquiryController extends GetxController {
  var showTable = false.obs; // to toggle between filter & table
  final searchController = TextEditingController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  /// Dropdown values
  final statusList = ["All Status", "Success", "Failed", "Pending"];
  var selectedStatus = "All Status".obs;

  void applyFilter() {
    print("Search: ${searchController.text}");
    print("Status: ${selectedStatus.value}");
    print("From Date: ${fromDateController.text}");
    print("To Date: ${toDateController.text}");
    showTable.value = true; // Show transaction table
  }

  void resetFilter() {
    searchController.clear();
    fromDateController.clear();
    toDateController.clear();
    selectedStatus.value = "All Status";
    showTable.value = false; // Back to filter form
  }
}

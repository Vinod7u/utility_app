import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicField {
  final String label;
  final String type; // text, dropdown
  final String hint;
  final int? maxLength;
  final List<String>? options;

  DynamicField({
    required this.label,
    required this.type,
    required this.hint,
    this.maxLength,
    this.options,
  });
}

class ServiceProcessScreenController extends GetxController {
  var fields = <DynamicField>[].obs;

  /// Store text controllers dynamically
  var textControllers = <String, TextEditingController>{};

  /// Dropdown values
  var selectedValues = <String, RxString>{};

  /// Mock API response (replace with real API call)
  void loadFields(String service) {
    if (service == "Mobile Recharge") {
      fields.value = [
        DynamicField(
          label: "Mobile Number",
          type: "text",
          hint: "Enter your mobile number",
          maxLength: 10,
        ),
        DynamicField(
          label: "Operator",
          type: "dropdown",
          hint: "Select Operator",
          options: ["Airtel", "Jio", "Vi", "BSNL"],
        ),
      ];
    } else if (service == "Electricity Bill") {
      fields.value = [
        DynamicField(
          label: "Customer ID",
          type: "text",
          hint: "Enter your customer ID",
        ),
        DynamicField(
          label: "State",
          type: "dropdown",
          hint: "Select State",
          options: ["Maharashtra", "Delhi", "Karnataka", "Tamil Nadu"],
        ),
      ];
    }

    /// Init controllers for text & dropdown fields
    for (var f in fields) {
      if (f.type == "text") {
        textControllers[f.label] = TextEditingController();
      } else if (f.type == "dropdown") {
        selectedValues[f.label] = "".obs;
      }
    }
  }
}

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

class ServiceDataDetailController extends GetxController {
  var fields = <DynamicField>[].obs;

  /// Store text controllers dynamically
  var textControllers = <String, TextEditingController>{};

  /// Dropdown values
  var selectedValues = <String, RxString>{};

  /// Mock API response (replace with real API call)
  void loadFields(String service) {
    // Clear previous data
    fields.clear();
    textControllers.clear();
    selectedValues.clear();

    switch (service.toLowerCase().trim()) {
      // FastTag
      case 'fasttag':
      case 'fastag':
      case 'fast tag':
        fields.value = [
          DynamicField(
            label: "Vehicle Number",
            type: "text",
            hint: "Enter vehicle number (e.g., RJ01AB1234)",
            maxLength: 15,
          ),
        ];
        break;

      // Electricity
      case 'electricity':
      case 'electricity bill':
        fields.value = [
          DynamicField(
            label: "Consumer Number",
            type: "text",
            hint: "Enter your consumer number",
            maxLength: 20,
          ),
        ];
        break;

      // DTH
      case 'dth':
      case 'dth recharge':
        fields.value = [
          DynamicField(
            label: "Customer ID / Subscriber ID",
            type: "text",
            hint: "Enter your subscriber ID",
            maxLength: 15,
          ),
        ];
        break;

      // Gas (Piped)
      case 'gas':
      case 'gas bill':
      case 'piped gas':
        fields.value = [
          DynamicField(
            label: "Consumer Number",
            type: "text",
            hint: "Enter your gas consumer number",
            maxLength: 20,
          ),
        ];
        break;

      // LPG Gas
      case 'lpg gas':
      case 'lpg':
        fields.value = [
          DynamicField(
            label: "LPG ID",
            type: "text",
            hint: "Enter your 17-digit LPG ID",
            maxLength: 17,
          ),
          DynamicField(
            label: "Mobile Number",
            type: "text",
            hint: "Enter registered mobile number",
            maxLength: 10,
          ),
        ];
        break;

      // Water Bill
      case 'water':
      case 'water bill':
        fields.value = [
          DynamicField(
            label: "Consumer Number",
            type: "text",
            hint: "Enter your water consumer number",
            maxLength: 20,
          ),
        ];
        break;

      // Broadband Postpaid
      case 'broadband postpaid':
      case 'broadband':
        fields.value = [
          DynamicField(
            label: "Customer ID / Account Number",
            type: "text",
            hint: "Enter your broadband customer ID",
            maxLength: 20,
          ),
          DynamicField(
            label: "Registered Mobile Number",
            type: "text",
            hint: "Enter mobile number",
            maxLength: 10,
          ),
        ];
        break;

      // Cable TV
      case 'cable tv':
      case 'cable':
        fields.value = [
          DynamicField(
            label: "Subscriber ID",
            type: "text",
            hint: "Enter your subscriber ID",
            maxLength: 20,
          ),
        ];
        break;

      // Credit Card
      case 'credit cards':
      case 'credit card':
        fields.value = [
          DynamicField(
            label: "Credit Card Number",
            type: "text",
            hint: "Enter last 4 digits of card",
            maxLength: 4,
          ),
          DynamicField(
            label: "Mobile Number",
            type: "text",
            hint: "Enter registered mobile number",
            maxLength: 10,
          ),
        ];
        break;

      // Insurance
      case 'insurance':
      case 'life insurance':
      case 'health insurance':
        fields.value = [
          DynamicField(
            label: "Policy Number",
            type: "text",
            hint: "Enter your policy number",
            maxLength: 20,
          ),
          DynamicField(
            label: "Date of Birth",
            type: "text",
            hint: "DD/MM/YYYY",
            maxLength: 10,
          ),
        ];
        break;

      // Mobile Postpaid
      case 'mobile postpaid':
      case 'postpaid':
        fields.value = [
          DynamicField(
            label: "Mobile Number",
            type: "text",
            hint: "Enter your 10-digit mobile number",
            maxLength: 10,
          ),
        ];
        break;

      // Landline
      case 'landline postpaid':
      case 'landline':
        fields.value = [
          DynamicField(
            label: "Landline Number",
            type: "text",
            hint: "Enter landline with STD code",
            maxLength: 15,
          ),
        ];
        break;

      // Education Fees
      case 'education fees':
      case 'school fees':
        fields.value = [
          DynamicField(
            label: "Student ID / Roll Number",
            type: "text",
            hint: "Enter student ID",
            maxLength: 20,
          ),
          DynamicField(
            label: "Student Name",
            type: "text",
            hint: "Enter student name",
            maxLength: 50,
          ),
        ];
        break;

      // Loan Payment
      case 'loan payment':
      case 'loan':
      case 'emi':
        fields.value = [
          DynamicField(
            label: "Loan Account Number",
            type: "text",
            hint: "Enter your loan account number",
            maxLength: 20,
          ),
          DynamicField(
            label: "Mobile Number",
            type: "text",
            hint: "Enter registered mobile number",
            maxLength: 10,
          ),
        ];
        break;

      // Housing Society
      case 'housing society':
      case 'society maintenance':
        fields.value = [
          DynamicField(
            label: "Flat Number",
            type: "text",
            hint: "Enter your flat/unit number",
            maxLength: 10,
          ),
          DynamicField(
            label: "Member ID",
            type: "text",
            hint: "Enter society member ID",
            maxLength: 15,
          ),
        ];
        break;

      // Clubs and Association
      case 'clubs and association':
      case 'club membership':
        fields.value = [
          DynamicField(
            label: "Membership Number",
            type: "text",
            hint: "Enter your membership number",
            maxLength: 20,
          ),
          DynamicField(
            label: "Member Name",
            type: "text",
            hint: "Enter member name",
            maxLength: 50,
          ),
        ];
        break;

      // Municipal Services
      case 'municipal services':
      case 'municipal':
        fields.value = [
          DynamicField(
            label: "Property ID",
            type: "text",
            hint: "Enter property ID",
            maxLength: 20,
          ),
        ];
        break;

      // Municipal Taxes
      case 'municipal taxes':
      case 'property tax':
        fields.value = [
          DynamicField(
            label: "Property Tax Number",
            type: "text",
            hint: "Enter property tax number",
            maxLength: 20,
          ),
        ];
        break;

      // Donation
      case 'donation':
      case 'charity':
        fields.value = [
          DynamicField(
            label: "Donor Name",
            type: "text",
            hint: "Enter your name",
            maxLength: 50,
          ),
          DynamicField(
            label: "PAN Number (for 80G)",
            type: "text",
            hint: "Enter PAN for tax benefit",
            maxLength: 10,
          ),
        ];
        break;

      // Rental
      case 'rental':
      case 'rent':
        fields.value = [
          DynamicField(
            label: "Property Address",
            type: "text",
            hint: "Enter property address",
            maxLength: 100,
          ),
          DynamicField(
            label: "Landlord Name",
            type: "text",
            hint: "Enter landlord name",
            maxLength: 50,
          ),
        ];
        break;

      // Subscription
      case 'subscription':
      case 'subscriptions':
        fields.value = [
          DynamicField(
            label: "Email ID / Phone Number",
            type: "text",
            hint: "Enter registered email or phone",
            maxLength: 50,
          ),
        ];
        break;

      // Recurring Deposit
      case 'recurring deposit':
      case 'rd':
        fields.value = [
          DynamicField(
            label: "RD Account Number",
            type: "text",
            hint: "Enter RD account number",
            maxLength: 20,
          ),
        ];
        break;

      // NCMC (Metro)
      case 'ncmc':
      case 'metro card':
      case 'metro':
        fields.value = [
          DynamicField(
            label: "Card Number",
            type: "text",
            hint: "Enter metro card number",
            maxLength: 16,
          ),
        ];
        break;

      // NPS
      case 'nps':
      case 'national pension system':
        fields.value = [
          DynamicField(
            label: "PRAN Number",
            type: "text",
            hint: "Enter your 12-digit PRAN",
            maxLength: 12,
          ),
        ];
        break;

      // Prepaid Meter
      case 'prepaid meter':
      case 'prepaid electricity':
        fields.value = [
          DynamicField(
            label: "Meter Number",
            type: "text",
            hint: "Enter prepaid meter number",
            maxLength: 20,
          ),
        ];
        break;

      // E-Challan
      case 'e- challan':
      case 'e-challan':
      case 'challan':
        fields.value = [
          DynamicField(
            label: "Challan Number",
            type: "text",
            hint: "Enter challan number",
            maxLength: 20,
          ),
          DynamicField(
            label: "Vehicle Number",
            type: "text",
            hint: "Enter vehicle registration number",
            maxLength: 15,
          ),
        ];
        break;

      // Default
      default:
        fields.value = [
          DynamicField(
            label: "Account Number",
            type: "text",
            hint: "Enter account number",
            maxLength: 20,
          ),
        ];
    }

    // Initialize controllers for text fields
    for (var field in fields) {
      if (field.type == "text") {
        textControllers[field.label] = TextEditingController();
      } else if (field.type == "dropdown") {
        selectedValues[field.label] = ''.obs;
      }
    }
  }

  @override
  void onClose() {
    // Dispose all controllers
    textControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.onClose();
  }
}

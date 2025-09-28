import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class LoanController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text controllers
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final aadharController = TextEditingController();
  final panController = TextEditingController();
  final amountController = TextEditingController();
  final durationController = TextEditingController();
  final purposeController = TextEditingController();

  // File paths
  var aadharDoc = RxnString();
  var panDoc = RxnString();

  /// Pick a document
  Future<void> pickDocument(String type) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.single.path != null) {
        String filePath = result.files.single.path!;
        if (type == "aadhar") {
          aadharDoc.value = filePath;
        } else if (type == "pan") {
          panDoc.value = filePath;
        }
      } else {
        showSnackBar(title: "Cancelled", message: "No file selected");
      }
    } catch (e) {
      showSnackBar(title: "Error", message: "File selection failed: $e");
    }
  }

  /// Submit loan form
  void submitLoan() {
    if (formKey.currentState!.validate()) {
      if (aadharDoc.value == null || panDoc.value == null) {
        showSnackBar(
          title: "Error",
          message: "Please upload both Aadhar & PAN documents",
        );

        return;
      }

      showSnackBar(
        title: "Success",
        message: "Loan request submitted successfully",
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    aadharController.dispose();
    panController.dispose();
    amountController.dispose();
    durationController.dispose();
    purposeController.dispose();
    super.onClose();
  }
}

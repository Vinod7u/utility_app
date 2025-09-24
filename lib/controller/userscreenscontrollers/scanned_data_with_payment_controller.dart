import 'package:get/state_manager.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class ScannedDataWithPaymentController extends GetxController {
  final RxString payeeName = "".obs;
  final RxString payeeUpi = "".obs;
  final RxString amount = "".obs;
  final RxString currency = "INR".obs;

  void parseUpiData(String data) {
    Uri? uri;
    try {
      uri = Uri.parse(data);
    } catch (_) {
      return;
    }

    if (uri.scheme != "upi") return;

    payeeName.value = uri.queryParameters["pn"] ?? "Unknown";
    payeeUpi.value = uri.queryParameters["pa"] ?? "";
    amount.value = uri.queryParameters["am"] ?? "";
    currency.value = uri.queryParameters["cu"] ?? "INR";
  }

  /// Update amount manually
  void updateAmount(String value) {
    amount.value = value;
  }

  /// Trigger UPI payment intent
  Future<void> proceedToPay() async {
    if (amount.value.isEmpty) {
      showSnackBar(title: "Error", message: "Please enter an amount");
      return;
    }

    final uri = Uri.parse(
      "upi://pay?pa=${payeeUpi.value}"
      "&pn=${Uri.encodeComponent(payeeName.value)}"
      "&am=${amount.value}"
      "&cu=${currency.value}",
    );
    showSnackBar(title: "Payment", message: "UPI Request: $uri");
  }
}

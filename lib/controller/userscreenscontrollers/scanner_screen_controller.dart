import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:utility_app_flutter/screens/home/usersection/scanned_data_with_payment.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class ScannerScreenController extends GetxController {
  final MobileScannerController qrscannerController = MobileScannerController();
  final RxString scannedData = ''.obs;

  //   Handle Qr Detection

  void onDetect(BarcodeCapture capture) {
    for (final barcode in capture.barcodes) {
      if (barcode.rawValue != null) {
        scannedData.value = barcode.rawValue!;
        // Stop scanner once detected
        qrscannerController.stop();
        if (kDebugMode) {
          print("Data for the Qr  ${scannedData.value}");
        }
        Get.off(() => ScannedDataWithPayment(scannedData: scannedData.value));
        // showSnackBar(title: "Values", message: scannedData.value);
      }
    }
  }

  /// Toggle flashlight
  void toggleTorch() {
    qrscannerController.toggleTorch();
  }

  /// Switch front/back camera
  void switchCamera() {
    qrscannerController.switchCamera();
  }

  @override
  void onClose() {
    qrscannerController.dispose();
    super.onClose();
  }
}

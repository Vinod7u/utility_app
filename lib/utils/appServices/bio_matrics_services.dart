import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Biometric scan result model
class BiometricResult {
  final bool success;
  final String message;
  final String? data;

  BiometricResult({
    required this.success,
    required this.message,
    this.data,
  });
}

/// Singleton service for handling biometric operations
class BiometricService extends GetxService {
  static const platform = MethodChannel('aeps_scanner_channel');
  
  var isScanning = false.obs;
  var statusMessage = "".obs;

  /// Capture fingerprint and return result
  Future<BiometricResult> captureFingerprint() async {
    if (isScanning.value) {
      return BiometricResult(
        success: false,
        message: "Scanner is already in use",
      );
    }

    isScanning.value = true;
    statusMessage.value = "Initializing scanner...";

    try {
      final result = await platform.invokeMethod('captureFingerprint');

      if (result != null && result['success'] == true) {
        statusMessage.value = "Biometric captured successfully!";
        return BiometricResult(
          success: true,
          message: "Success",
          data: result['data'] ?? '',
        );
      } else {
        statusMessage.value = "Capture failed";
        return BiometricResult(
          success: false,
          message: result['message'] ?? "Capture failed",
        );
      }
    } on PlatformException catch (e) {
      statusMessage.value = "Error: ${e.message ?? 'Scanner not connected'}";
      return BiometricResult(
        success: false,
        message: e.message ?? "Scanner error occurred",
      );
    } catch (e) {
      statusMessage.value = "Unexpected error occurred";
      return BiometricResult(
        success: false,
        message: "Unexpected error: ${e.toString()}",
      );
    } finally {
      isScanning.value = false;
    }
  }

  /// Check if scanner is available
  Future<bool> isScannerAvailable() async {
    try {
      final result = await platform.invokeMethod('checkScanner');
      return result == true;
    } catch (e) {
      return false;
    }
  }

  /// Cancel ongoing scan (if supported by your scanner)
  Future<void> cancelScan() async {
    try {
      await platform.invokeMethod('cancelScan');
      isScanning.value = false;
      statusMessage.value = "Scan cancelled";
    } catch (e) {
      print("Cancel scan error: $e");
    }
  }
}
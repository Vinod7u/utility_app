import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/appServices/bio_matrics_services.dart';

class BiometricCaptureDialog extends StatefulWidget {
  final Function(bool success, String message, String? biometricData)? onBiometricResult;
  final String? title;
  final String? description;
  final bool autoCapture;

  const BiometricCaptureDialog({
    super.key,
    this.onBiometricResult,
    this.title,
    this.description,
    this.autoCapture = true,
  });

  @override
  State<BiometricCaptureDialog> createState() => _BiometricCaptureDialogState();
}

class _BiometricCaptureDialogState extends State<BiometricCaptureDialog> {
  final biometricService = Get.find<BiometricService>();
  bool hasAttemptedCapture = false;

  @override
  void initState() {
    super.initState();
    if (widget.autoCapture) {
      // Auto-capture after dialog opens
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _captureFingerprint();
      });
    }
  }

  Future<void> _captureFingerprint() async {
    if (hasAttemptedCapture && biometricService.isScanning.value) return;
    hasAttemptedCapture = true;

    final result = await biometricService.captureFingerprint();

    // Call the callback
    widget.onBiometricResult?.call(
      result.success,
      result.message,
      result.data,
    );

    // Close dialog after successful capture
    if (result.success && mounted) {
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              widget.title ?? "Capturing Biometric",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1976D2),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Description (if provided)
            if (widget.description != null) ...[
              Text(
                widget.description!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],

            // Fingerprint Icon
            Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _getIconBackgroundColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.fingerprint,
                    size: 80,
                    color: _getIconColor(),
                  ),
                )),
            const SizedBox(height: 30),

            // Status Message
            Obx(() => Text(
                  biometricService.statusMessage.value.isEmpty
                      ? "Place your finger on the scanner"
                      : biometricService.statusMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF424242),
                    fontWeight: FontWeight.w500,
                  ),
                )),
            const SizedBox(height: 30),

            // Loading Indicator or Action Buttons
            Obx(() => biometricService.isScanning.value
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF42A5F5),
                      ),
                    ),
                  )
                : _buildActionButtons()),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    final hasError = biometricService.statusMessage.value.contains("Error") ||
        biometricService.statusMessage.value.contains("failed");
    final hasSuccess = biometricService.statusMessage.value.contains("successfully");

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Cancel Button
        OutlinedButton(
          onPressed: () {
            biometricService.cancelScan();
            widget.onBiometricResult?.call(false, "Cancelled by user", null);
            Get.back();
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Cancel"),
        ),
        
        // Show retry button if there was an error
        if (hasError && !hasSuccess) ...[
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () {
              hasAttemptedCapture = false;
              _captureFingerprint();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: const Color(0xFF1976D2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.refresh, size: 20),
            label: const Text("Retry"),
          ),
        ],
      ],
    );
  }

  Color _getIconColor() {
    if (biometricService.isScanning.value) {
      return const Color(0xFF42A5F5);
    }
    if (biometricService.statusMessage.value.contains("successfully")) {
      return Colors.green;
    }
    if (biometricService.statusMessage.value.contains("Error") ||
        biometricService.statusMessage.value.contains("failed")) {
      return Colors.red;
    }
    return Colors.grey;
  }

  Color _getIconBackgroundColor() {
    if (biometricService.isScanning.value) {
      return const Color(0xFF42A5F5).withOpacity(0.1);
    }
    if (biometricService.statusMessage.value.contains("successfully")) {
      return Colors.green.withOpacity(0.1);
    }
    if (biometricService.statusMessage.value.contains("Error") ||
        biometricService.statusMessage.value.contains("failed")) {
      return Colors.red.withOpacity(0.1);
    }
    return Colors.grey.withOpacity(0.1);
  }

  @override
  void dispose() {
    biometricService.cancelScan();
    super.dispose();
  }
}

// Helper function to show the dialog - put this outside the class
void showBiometricCaptureDialog(
  BuildContext context, {
  String? title,
  String? description,
  bool autoCapture = true,
  Function(bool success, String message, String? biometricData)? onResult,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BiometricCaptureDialog(
        title: title,
        description: description,
        autoCapture: autoCapture,
        onBiometricResult: onResult,
      );
    },
  );
}
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/scanner_screen_controller.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ScannerScreenController qrController = Get.put(
    ScannerScreenController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: qrController.qrscannerController,
            fit: BoxFit.cover,
            onDetect: qrController.onDetect,
            onDetectError: (error, stack) {
              showSnackBar(title: "Error", message: "Camera error: $error");
            },
            placeholderBuilder: (context) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
            overlayBuilder: (context, constraints) {
              final scanBoxSize = constraints.maxWidth * 0.7;
              return Center(
                child: Container(
                  width: scanBoxSize,
                  height: scanBoxSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
            scanWindow: Rect.fromCenter(
              center: MediaQuery.of(context).size.center(Offset.zero),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
            ),
          ),

          // ✅ Top AppBar
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.flash_on, color: Colors.white),
                      onPressed: qrController.toggleTorch,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.switch_camera,
                        color: Colors.white,
                      ),
                      onPressed: qrController.switchCamera,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ✅ Bottom Instructions
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Text(
                "Align QR code inside the box to scan",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

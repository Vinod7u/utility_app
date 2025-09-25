import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:utility_app_flutter/controller/userscreenscontrollers/scanned_data_with_payment_controller.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';

class ScannedDataWithPayment extends StatefulWidget {
  final String scannedData;

  const ScannedDataWithPayment({super.key, required this.scannedData});

  @override
  State<ScannedDataWithPayment> createState() => _ScannedDataWithPaymentState();
}

class _ScannedDataWithPaymentState extends State<ScannedDataWithPayment> {
  @override
  Widget build(BuildContext context) {
    final ScannedDataWithPaymentController controller = Get.put(
      ScannedDataWithPaymentController(),
    );
    controller.parseUpiData(widget.scannedData);

    final TextEditingController amountController = TextEditingController(
      text: controller.amount.value,
    );

    return Scaffold(
      backgroundColor: AppColors.off_white,
      appBar: AppBar(
        title: const Text("Confirm Payment"),
        centerTitle: true,
        backgroundColor: AppColors.off_white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            children: [
              // ✅ Payee details
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  controller.payeeName.isNotEmpty
                      ? controller.payeeName.value[0].toUpperCase()
                      : "?",
                  style: const TextStyle(fontSize: 28, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                controller.payeeName.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                controller.payeeUpi.value,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              const SizedBox(height: 32),

              // ✅ Amount input
              TextFormField(
                controller: amountController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  prefixText: "₹ ",
                  counterText: '',
                  fillColor: const Color(0xFFf9fafb),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFe5e7eb),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),

              const Spacer(),
              appButton(title: "Proceed to pay", onTap: () {}),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

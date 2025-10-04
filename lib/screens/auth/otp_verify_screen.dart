import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:utility_app_flutter/controller/otpverify_controller.dart';
import 'package:utility_app_flutter/screens/auth/loginselection.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/utils/utils.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';
import 'package:utility_app_flutter/widgets/app_loader.dart';
import 'package:utility_app_flutter/widgets/snackbar.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final controller = Get.put(OtpverifyController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final String mobile = args['mobile'];
    // final String userType = args['userType'];

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Verify Otp"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1a202c)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: appLoader());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "Enter OTP",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryC,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "We have sent a 6-digit code to your registered number",
                  style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                /// 🔹 Custom OTP Input
                Pinput(
                  length: 6,
                  controller: controller.otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  showCursor: true,
                  onCompleted: (pin) {
                    //  controller.verifyOtp();
                  },
                ),

                const SizedBox(height: 32),

                /// 🔹 Verify Button with Gradient
                appButton(
                  title: "Verify Otp",
                  onTap: () {
                    if (controller.otpController.text.length == 6) {
                      Get.to(() => Loginselection());

                      // controller.verifyOtp(
                      //   otp: controller.otpController.text,
                      //   mobile: mobile,
                      // );
                    } else {
                      showSnackBar(
                        title: "Error",
                        message: "Please enter valid OTP",
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),

                /// 🔹 Resend OTP
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

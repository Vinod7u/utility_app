class ApiUrl {
  static const String baseUrl = "https://api.finuniques.in/api/";

  // 🔹 Auth APIs
  static const String sendOtp = "${baseUrl}auth/send-otp";
  static const String verifyOtp = "${baseUrl}auth/verify-otp";
  static const String createRetailer = "${baseUrl}v1/auth/register";

 
}

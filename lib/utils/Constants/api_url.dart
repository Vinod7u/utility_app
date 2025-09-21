class ApiUrl {
  static const String baseUrl = "https://finuniqueadminbackend.onrender.com/api/";

  // 🔹 Auth APIs
  static const String sendOtp = "${baseUrl}auth/send-otp";
  static const String verifyOtp = "${baseUrl}auth/verify-otp";
  static const String createCandidate = "${baseUrl}v1/auth/register";
  static const String getrole = "${baseUrl}v1/getallrole";
  static const String verifyAadhaarOtp = "${baseUrl}kyc/aadhar-verify";
  static const String submitAadhaarOtp = "${baseUrl}v1/kyc/aadhar-verify";


 
}

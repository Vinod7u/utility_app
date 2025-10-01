import 'package:get/get.dart';

class DistributerHomeController extends GetxController {
  // Greeting username
  var userName = "Ranjay Kumar".obs;

  // Grid stats
  var totalUsers = 5.obs;
  var totalRetailer = 1.obs;
  var totalActiveRetailer = 1.obs;
  var totalDistributer = 1.obs;
  var totalActiveDistributer = 1.obs;
  var activeUsers = 1.obs;
  var apiManagement = 29.obs;

  var profileName = "Ranjay Kumar".obs;
  var profileEmail = "ranjaykumar0603@gmail.com".obs;
  var profileRole = "Distributor".obs;
  var profileStatus = "Active".obs;
  var kycStatus = "Pending".obs;
  var profileImage = "https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?cs=srgb&dl=pexels-sulimansallehi-1704488.jpg&fm=jpg".obs;

  // Example graph data (Payin/Payout counts per month)
  var monthlyPayIn = <int>[80, 30, 50, 70, 40, 90, 100, 75, 65, 50].obs;
  var monthlyPayout = <int>[60, 40, 30, 80, 55, 95, 85, 70, 60, 40].obs;

  List<String> months = [
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
  ];
}

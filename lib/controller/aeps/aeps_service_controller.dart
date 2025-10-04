import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/appimage.dart';

class AepsServiceController extends GetxController{
   final List<Map<String, String>> services = [
    {"image": Appimage.aeps_balance_enquiry, "title": "Balance Enquiry"},
    {"image": Appimage.cash, "title": "Cash Withdrawal"},
    {"image": Appimage.ministatment_aeps, "title": "Mini Statement"},
  ];
}
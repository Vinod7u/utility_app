import 'package:get/get.dart';
import 'package:utility_app_flutter/utils/Constants/appimage.dart';

class BookingController extends GetxController {
  var selectedTab = 0.obs;

  final List<Map<String, String>> tabs = [
    {"title": "Bus", "icon": Appimage.school},
    {"title": "Trains", "icon": Appimage.train},
    {"title": "Flights", "icon": Appimage.flight},
    {"title": "Hotels", "icon": Appimage.building},
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }
}

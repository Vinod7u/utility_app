import 'package:get/get.dart';

class HomePageController extends GetxController {
  var userselectedIndex = 0.obs;
  var distributerselectedIndex = 0.obs;
  var retailerselectedIndex = 0.obs;

  void userchangeTab(int index) {
    userselectedIndex.value = index;
  }

  void distributerchangeTab(int index) {
    distributerselectedIndex.value = index;
  }

  void retailerchangeTab(int index) {
    retailerselectedIndex.value = index;
  }
}

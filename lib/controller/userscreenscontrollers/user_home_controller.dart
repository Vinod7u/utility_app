import 'package:get/get.dart';

class UserHomeController extends GetxController {
  var userName = "John Doe".obs;
  var walletBalance = 2450.00.obs;
  var isBalanceVisible = true.obs;

  void toggleBalanceVisibility() {
    isBalanceVisible.value = !isBalanceVisible.value;
  }

  void addMoney(double amount) {
    walletBalance.value += amount;
  }

  void sendMoney(double amount) {
    if (walletBalance.value >= amount) {
      walletBalance.value -= amount;
    }
  }
}

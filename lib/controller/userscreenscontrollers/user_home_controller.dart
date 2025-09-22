import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserHomeController extends GetxController {
  var userName = "John Doe".obs;
  var walletBalance = 2450.00.obs;
  var isBalanceVisible = false.obs;

  // For quick actions button animations
  var selectedQuickAction = (-1).obs;
  final List<String> bannerImages = [
    'https://images.unsplash.com/photo-1545239351-1141bd82e8a6?w=1200',
    'https://images.unsplash.com/photo-1508385082359-fc0a0b7f8a9a?w=1200',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=1200',
  ];

  var currentBanner = 0.obs; // ✅ reactive banner index

  // Toggle balance visibility
  void toggleBalanceVisibility() {
    isBalanceVisible.value = !isBalanceVisible.value;
  }

  // Add money
  void addMoney(double amount) {
    walletBalance.value += amount;
  }

  // Send money
  void sendMoney(double amount) {
    if (walletBalance.value >= amount) {
      walletBalance.value -= amount;
    }
  }

  // Quick action selection
  void setQuickAction(int index) {
    selectedQuickAction.value = index;
  }

  void clearQuickAction() {
    selectedQuickAction.value = -1;
  }

  // Helper: formatted balance string
  String get formattedBalance {
    final formatter = NumberFormat.currency(
      locale: 'en_IN', // Indian currency format
      symbol: '₹',
      decimalDigits: 2,
    );
    return formatter.format(walletBalance.value);
  }
}

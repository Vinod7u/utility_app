import 'dart:ui';

import 'package:get/state_manager.dart';

class Service {
  final String title;
  final String subtitle;
  final String iconUrl;
  final VoidCallback onTap;

  Service({
    required this.title,
    required this.subtitle,
    required this.iconUrl,
    required this.onTap,
  });
}

class ServiceCategory {
  final String name;
  final List<Service> services;

  ServiceCategory({required this.name, required this.services});
}

class UserServiceController extends GetxController {
  var searchQuery = "".obs;
  var filteredServices = <Service>[].obs;
  var services = <Service>[
    Service(
      title: "Mobile Recharge",
      subtitle: "Prepaid & postpaid recharge",
      iconUrl: "https://img.icons8.com/color/96/phone.png",
      onTap: () {},
    ),
    Service(
      title: "DTH Recharge",
      subtitle: "Recharge your DTH instantly",
      iconUrl: "https://img.icons8.com/color/96/tv.png",
      onTap: () {},
    ),
    Service(
      title: "Electricity Bill",
      subtitle: "Pay electricity bills securely",
      iconUrl: "https://img.icons8.com/color/96/electricity.png",
      onTap: () {},
    ),
    Service(
      title: "Gas Bill",
      subtitle: "Pay piped gas bills online",
      iconUrl: "https://img.icons8.com/color/96/gas.png",
      onTap: () {},
    ),
    Service(
      title: "Water Bill",
      subtitle: "Pay your water bills easily",
      iconUrl: "https://img.icons8.com/color/96/water.png",
      onTap: () {},
    ),
    Service(
      title: "Broadband",
      subtitle: "Pay internet broadband bills",
      iconUrl: "https://img.icons8.com/color/96/wifi.png",
      onTap: () {},
    ),
    Service(
      title: "Loan Repayment",
      subtitle: "Pay EMI for your loans",
      iconUrl: "https://img.icons8.com/color/96/money-bag.png",
      onTap: () {},
    ),
    Service(
      title: "Credit Card Bill",
      subtitle: "Pay your credit card dues",
      iconUrl: "https://img.icons8.com/color/96/credit-card.png",
      onTap: () {},
    ),
    Service(
      title: "Flight Booking",
      subtitle: "Book domestic & international flights",
      iconUrl: "https://img.icons8.com/color/96/airplane-take-off.png",
      onTap: () {},
    ),
    Service(
      title: "Train Booking",
      subtitle: "Book train tickets instantly",
      iconUrl: "https://img.icons8.com/color/96/train.png",
      onTap: () {},
    ),
    Service(
      title: "Bus Booking",
      subtitle: "Reserve bus tickets online",
      iconUrl: "https://img.icons8.com/color/96/bus.png",
      onTap: () {},
    ),
    Service(
      title: "Movie Tickets",
      subtitle: "Book tickets for latest movies",
      iconUrl: "https://img.icons8.com/color/96/ticket.png",
      onTap: () {},
    ),
    Service(
      title: "Insurance",
      subtitle: "Pay premiums & manage policies",
      iconUrl: "https://img.icons8.com/color/96/insurance-agent.png",
      onTap: () {},
    ),
    Service(
      title: "Mutual Funds",
      subtitle: "Invest & track your SIPs",
      iconUrl: "https://img.icons8.com/color/96/combo-chart.png",
      onTap: () {},
    ),
    Service(
      title: "Gold Investment",
      subtitle: "Buy & sell digital gold",
      iconUrl: "https://img.icons8.com/color/96/gold-bars.png",
      onTap: () {},
    ),
    Service(
      title: "UPI Transfer",
      subtitle: "Send money instantly via UPI",
      iconUrl: "https://img.icons8.com/color/96/money-transfer.png",
      onTap: () {},
    ),
    Service(
      title: "Bank Transfer",
      subtitle: "IMPS, NEFT, RTGS transfers",
      iconUrl: "https://img.icons8.com/color/96/bank.png",
      onTap: () {},
    ),
    Service(
      title: "QR Payment",
      subtitle: "Scan any QR to pay",
      iconUrl: "https://img.icons8.com/color/96/qr-code.png",
      onTap: () {},
    ),
    Service(
      title: "Shopping",
      subtitle: "Shop online across categories",
      iconUrl: "https://img.icons8.com/color/96/shopping-cart.png",
      onTap: () {},
    ),
    Service(
      title: "Food Delivery",
      subtitle: "Order food from nearby restaurants",
      iconUrl: "https://img.icons8.com/color/96/meal.png",
      onTap: () {},
    ),
  ].obs;

  void updateSearch(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredServices.clear();
    } else {
      filteredServices.value = services
          .where(
            (s) =>
                s.title.toLowerCase().contains(query.toLowerCase()) ||
                s.subtitle.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }
}

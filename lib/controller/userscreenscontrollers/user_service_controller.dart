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
  final List<ServiceCategory> serviceCategories = [
    ServiceCategory(
      name: "Recharge & Bills",
      services: [
        Service(
          title: "Mobile Recharge",
          subtitle: "Instant prepaid recharge",
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
      ],
    ),
    ServiceCategory(
      name: "Banking",
      services: [
        Service(
          title: "DMT Transfer",
          subtitle: "Domestic Money Transfer",
          iconUrl: "https://img.icons8.com/color/96/money-transfer.png",
          onTap: () {},
        ),
        Service(
          title: "AEPS",
          subtitle: "Aadhar Enabled Payment System",
          iconUrl: "https://img.icons8.com/color/96/fingerprint.png",
          onTap: () {},
        ),
      ],
    ),
    ServiceCategory(
      name: "Insurance",
      services: [
        Service(
          title: "Life Insurance",
          subtitle: "Pay premiums easily",
          iconUrl: "https://img.icons8.com/color/96/insurance-agent.png",
          onTap: () {},
        ),
        Service(
          title: "Health Insurance",
          subtitle: "Manage your health policies",
          iconUrl: "https://img.icons8.com/color/96/heart-health.png",
          onTap: () {},
        ),
      ],
    ),
  ];

  List<Service> get allServices => serviceCategories.expand((c) => c.services).toList();

  void updateSearch(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredServices.clear();
    } else {
      filteredServices.value = allServices
          .where(
            (s) =>
                s.title.toLowerCase().contains(query.toLowerCase()) ||
                s.subtitle.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }
}

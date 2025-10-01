import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Service {
  final String title;
  final String subtitle;
  final IconData iconData;
  final VoidCallback onTap;

  Service({
    required this.title,
    required this.subtitle,
    required this.iconData,
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
      title: "Education fees",
      subtitle: "Pay school & college fees",
      iconData: Icons.school_outlined,
      onTap: () {},
    ),
    Service(
      title: "Broadband Postpaid",
      subtitle: "Pay internet broadband bills",
      iconData: Icons.wifi_outlined,
      onTap: () {},
    ),
    Service(
      title: "Cable TV",
      subtitle: "Pay cable TV bills",
      iconData: Icons.tv_outlined,
      onTap: () {},
    ),
    Service(
      title: "Clubs and Association",
      subtitle: "Pay membership fees",
      iconData: Icons.groups_outlined,
      onTap: () {},
    ),
    Service(
      title: "Credit Cards",
      subtitle: "Pay your credit card dues",
      iconData: Icons.credit_card_outlined,
      onTap: () {},
    ),
    Service(
      title: "Donation",
      subtitle: "Make charitable donations",
      iconData: Icons.favorite_outline,
      onTap: () {},
    ),
    Service(
      title: "DTH",
      subtitle: "Recharge your DTH instantly",
      iconData: Icons.satellite_alt_outlined,
      onTap: () {},
    ),
    Service(
      title: "Electricity",
      subtitle: "Pay electricity bills securely",
      iconData: Icons.lightbulb_outline,
      onTap: () {},
    ),
    Service(
      title: "Fastag",
      subtitle: "Recharge FASTag for tolls",
      iconData: Icons.local_taxi_outlined,
      onTap: () {},
    ),
    Service(
      title: "Gas",
      subtitle: "Pay piped gas bills online",
      iconData: Icons.local_gas_station_outlined,
      onTap: () {},
    ),
    Service(
      title: "Housing Society",
      subtitle: "Pay society maintenance",
      iconData: Icons.home_outlined,
      onTap: () {},
    ),
    Service(
      title: "Insurance",
      subtitle: "Pay premiums & manage policies",
      iconData: Icons.security_outlined,
      onTap: () {},
    ),
    Service(
      title: "Landline Postpaid",
      subtitle: "Pay landline phone bills",
      iconData: Icons.phone_outlined,
      onTap: () {},
    ),
    Service(
      title: "LPG Gas",
      subtitle: "Book LPG cylinder",
      iconData: Icons.propane_tank_outlined,
      onTap: () {},
    ),
    Service(
      title: "Mobile Postpaid",
      subtitle: "Pay mobile postpaid bills",
      iconData: Icons.smartphone_outlined,
      onTap: () {},
    ),
    Service(
      title: "Loan Payment",
      subtitle: "Pay EMI for your loans",
      iconData: Icons.account_balance_outlined,
      onTap: () {},
    ),
    Service(
      title: "Municipal Services",
      subtitle: "Pay municipal bills & taxes",
      iconData: Icons.account_balance_outlined,
      onTap: () {},
    ),
    Service(
      title: "Municipal Taxes",
      subtitle: "Pay property & other taxes",
      iconData: Icons.percent_outlined,
      onTap: () {},
    ),
    Service(
      title: "Mobile Recharge",
      subtitle: "Recharge prepaid mobile",
      iconData: Icons.phone_android_outlined,
      onTap: () {},
    ),
    Service(
      title: "Rental",
      subtitle: "Pay house rent online",
      iconData: Icons.home_work_outlined,
      onTap: () {},
    ),
    Service(
      title: "Subscription",
      subtitle: "Pay for subscriptions",
      iconData: Icons.subscriptions_outlined,
      onTap: () {},
    ),
    Service(
      title: "Recurring deposit",
      subtitle: "Manage recurring deposits",
      iconData: Icons.location_on_outlined,
      onTap: () {},
    ),
    Service(
      title: "NCMC",
      subtitle: "Recharge metro cards",
      iconData: Icons.credit_card_outlined,
      onTap: () {},
    ),
    Service(
      title: "NPS",
      subtitle: "National Pension System",
      iconData: Icons.account_tree_outlined,
      onTap: () {},
    ),
    Service(
      title: "Water",
      subtitle: "Pay your water bills easily",
      iconData: Icons.water_drop_outlined,
      onTap: () {},
    ),
    Service(
      title: "Life Insurance",
      subtitle: "Pay life insurance premiums",
      iconData: Icons.shield_outlined,
      onTap: () {},
    ),
    Service(
      title: "Health Insurance",
      subtitle: "Pay health insurance premiums",
      iconData: Icons.medical_services_outlined,
      onTap: () {},
    ),
    Service(
      title: "Prepaid Meter",
      subtitle: "Recharge prepaid electricity",
      iconData: Icons.electric_meter_outlined,
      onTap: () {},
    ),
    Service(
      title: "E- challan",
      subtitle: "Pay traffic fines online",
      iconData: Icons.receipt_outlined,
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

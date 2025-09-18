import 'package:flutter/material.dart';
import 'package:utility_app_flutter/utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  final UserType userType;

  const ProfileScreen({super.key, required this.userType});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

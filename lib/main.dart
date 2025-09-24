import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:utility_app_flutter/screens/auth/distributer_register.dart';
import 'package:utility_app_flutter/screens/auth/user_register.dart';
import 'package:utility_app_flutter/screens/home/usersection/user_home_page.dart';
import 'package:utility_app_flutter/screens/splashscreen.dart';
import 'package:utility_app_flutter/utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Utility Services',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

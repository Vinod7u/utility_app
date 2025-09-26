import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utility_app_flutter/screens/home/retailerSection/service_management.dart';
import 'package:utility_app_flutter/screens/home/usersection/view_plans.dart';
import 'package:utility_app_flutter/screens/home/usersection/fund_request.dart';
import 'package:utility_app_flutter/screens/home/retailerSection/view_plans.dart';
import 'package:utility_app_flutter/screens/home/usersection/pay_in_transection_report.dart';
import 'package:utility_app_flutter/utils/Constants/screen_size.dart';

import '../../../utils/Constants/app_colors.dart';
import '../usersection/bbps_report.dart';
import '../usersection/enquiry_form.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return Drawer(
      width: ScreenSize.width * .8,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            IconButton(onPressed: (){
              Scaffold.of(context).closeDrawer();
            }, icon: Icon(Icons.arrow_back_outlined,color: Colors.black,size: 32,),),

            SizedBox(height: 6,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle
            SizedBox(height: 50),
            Icon(Icons.arrow_back_outlined, color: Colors.black, size: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person),
                  ),
                ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Saurav'),
                      Text('Retailer'),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * .04,vertical: 10),
              child: Image.asset('assets/images/image 57.png',),
                    child: Icon(Icons.perm_identity),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Saurav'), Text('Retailer')],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * .02,
                vertical: 10,
              ),
              child: Image.asset('assets/images/image 57.png'),
            ),
            //SizedBox(height: 60,),
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: AppColors.textColor,
              ),
              title: Text(
                'Dashboard',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // close drawer
              },
            ),
            ExpansionTile(
              showTrailingIcon: false,
              leading: SvgPicture.asset(
                'assets/icons/Vector (2).svg',
                color: AppColors.textColor,
              ),
              title: Row(
                children: [
                  Text(
                    'Plans Management',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: ScreenSize.width * .06),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.textColor,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.transparent,
                ), // no divider when expanded
                borderRadius: BorderRadius.circular(0),
              ),
              childrenPadding: EdgeInsets.only(
                left: 40,
              ), // optional: padding for children
              children: [
                ListTile(
                  title: Text(
                    'View Plans',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/icons/carbon_data-view.svg',
                    color: AppColors.textColor,
                  ),
                  onTap: () {
                    Get.to(ViewPlans());
                  },
                ),
                ListTile(
                  title: Text(
                    'BY Pass Plan',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/icons/akar-icons_wallet.svg',
                    color: AppColors.textColor,
                  ),
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigate to Plan 2 page
                  },
                ),
                // Add more sub-items as needed
              ],
            ),

            ExpansionTile(
              showTrailingIcon: false,
              leading: SvgPicture.asset(
                'assets/icons/Vector (3).svg',
                color: AppColors.textColor,
              ),
              title: Row(
                children: [
                  Text(
                    'Payin Payout Report',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: ScreenSize.width * .06),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.textColor,
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.transparent,
                ), // no divider when expanded
                borderRadius: BorderRadius.circular(0),
              ),
              childrenPadding: EdgeInsets.only(
                left: 40,
              ), // optional: indent for children
              children: [
                ListTile(
                  title: Text(
                    'Payin',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/icons/icon-park-outline_people-plus-one.svg',
                    color: AppColors.textColor,
                  ),
                  onTap: () {
                    Get.to(
                      () => PayinTransactionScreen(),
                    ); // Navigate to Today’s Report page
                  },
                ),
                ListTile(
                  title: Text(
                    'Payout',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/icons/icon-park-twotone_people-download.svg',
                    color: AppColors.textColor,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to Weekly Report page
                  },
                ),
              ],
            ),

            ListTile(
              leading: SvgPicture.asset('assets/icons/akar-icons_wallet.svg'),
              title: const Text(
                'E-Wallet Report',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              showTrailingIcon: false,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.transparent,
                ), // no divider when expanded
                borderRadius: BorderRadius.circular(0),
              ),
              leading: SvgPicture.asset(
                'assets/icons/akar-icons_info.svg',
                color: AppColors.textColor,
              ),
              title: Row(
                children: [
                  Text(
                    'Enquiry',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: ScreenSize.width * .06),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.textColor,
                  ),
                ],
              ),
              childrenPadding: EdgeInsets.only(
                left: 40,
              ), // optional: indent for children
              children: [
                ListTile(
                  title: Text(
                    'Raise Enquiry',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/icons/la_hand-paper-solid.svg',
                    color: AppColors.textColor,
                  ),
                  onTap: () {
                    Get.to(()=> EnquiryFormView());
                    // Navigate to Customer Enquiry page
                  },
                ),
              ],
            ),
            ExpansionTile(
              showTrailingIcon: false,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.transparent,
                ), // no divider when expanded
                borderRadius: BorderRadius.circular(0),
              ),
              leading: SvgPicture.asset(
                'assets/icons/icon-park_funds.svg',
                color: AppColors.textColor,
              ),
              title: Row(
                children: [
                  Text(
                    'Fund',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: ScreenSize.width * .06),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: AppColors.textColor,
                  ),
                ],
              ),
              childrenPadding: EdgeInsets.only(
                left: 40,
              ), // optional indentation for children
              children: [
                ListTile(
                  title: Text(
                    'Fund Request',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: SvgPicture.asset(
                    'assets/icons/carbon_request-quote.svg',
                    color: AppColors.textColor,
                  ),
                  onTap: () {
                    Get.to(()=> FundRequestView());
                  },
                ),
              ],
            ),

            ListTile(
              leading: SvgPicture.asset('assets/icons/tabler_report.svg'),
              title: const Text(
                'BBPS Report',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Get.to(()=> BBPSReportView());
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                'assets/icons/grommet-icons_services.svg',
              ),
              title: const Text(
                'All Services',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: SvgPicture.asset('assets/icons/mdi_account-service.svg'),
              title: const Text(
                'Service Management',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Get.to(ServiceManagement());
              },
            ),
          ],
        ),
      ),
    );
  }
}

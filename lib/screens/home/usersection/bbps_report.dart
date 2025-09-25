import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/Constants/app_colors.dart';

class BBPSReportView extends StatefulWidget {
  const BBPSReportView({super.key});

  @override
  State<BBPSReportView> createState() => _BBPSReportViewState();
}

class _BBPSReportViewState extends State<BBPSReportView> {
  final _toDateController = TextEditingController();
  final _fromDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  children: [
                  Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //                         image: DecorationImage(image: Image.asset('assets')),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 6,
                        color: Colors.grey.withOpacity(.18),
                        blurRadius: 7,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text('From Date',style: TextStyle(fontWeight: FontWeight.w600,),),
                      TextFormField(
                        controller: _fromDateController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                         // hintText: 'Search',
                          filled: true,
                          counterText: '',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          fillColor: const Color(0xFFf9fafb),
                          //prefixIcon: Icon(Icons.search, size: 16,color: Colors.grey.shade400,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color: Colors.grey.shade200, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color: Colors.grey.shade200, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('To Date',style: TextStyle(fontWeight: FontWeight.w600,),),
                      TextFormField(
                        controller: _toDateController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          //hintText: 'Search',
                          filled: true,
                          counterText: '',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          fillColor: const Color(0xFFf9fafb),
                          //prefixIcon: Icon(Icons.search, size: 16,color: Colors.grey.shade400,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color: Colors.grey.shade200, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide(color: Colors.grey.shade200, width: 2),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 6),
                            decoration: BoxDecoration(
                                color: AppColors.darkColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('Apply',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white),),
                          ),
                          SizedBox(width: 10,),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 6),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey)
                            ),
                            child: Text('Reset All Filters',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black),),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                  ],
                ),
              ),
            ),

            // SliverList(
            //   delegate: SliverChildBuilderDelegate((context, index) {
            //     final tx = controller.filteredTransactions[index];
            //     return Padding(
            //       padding: const EdgeInsets.symmetric(
            //         horizontal: 16,
            //         vertical: 8,
            //       ),
            //       child: _buildTransactionCard(
            //         tx["title"],
            //         tx["subtitle"],
            //         tx["amount"],
            //         tx["icon"],
            //         tx["time"],
            //       ),
            //     );
            //   }, childCount: controller.filteredTransactions.length),
            // ),
          ],
        ),
      ),
    );
  }

  /// ---------------- CUSTOM APP BAR ----------------
  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 0,
      floating: true,
      pinned: true,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
          background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffA9E2FF), Color(0xff44A5E9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                  Text(
                    "BBPS Report",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  _buildAppBarIcon(Icons.notifications_outlined, () {}),
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

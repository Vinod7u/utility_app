import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class ViewPlans extends StatefulWidget {
  const ViewPlans({super.key});

  @override
  State<ViewPlans> createState() => _ViewPlansState();
}

class _ViewPlansState extends State<ViewPlans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 45,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Color(0xff8DDCFB),
        title: Text('Plans'),
        actions: [
          SvgPicture.asset('assets/icons/Vector (1).svg')
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff8DDCFB), Color(0xffFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: ListView.builder(
            itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context,index){
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey, width: 1),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: Colors.grey,
                      offset: Offset(2,4)
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.newPrimaryColor
                    ),
                    child: Text('Basic',style: TextStyle(),),
                  ),
                  SizedBox(height: 20,),

                ],
              ),
            );
          })
        ),
      ),
    );
  }
}

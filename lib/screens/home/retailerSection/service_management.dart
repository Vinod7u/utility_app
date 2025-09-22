import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utility_app_flutter/utils/Constants/screen_size.dart';

class ServiceManagement extends StatefulWidget {
  const ServiceManagement({super.key});

  @override
  State<ServiceManagement> createState() => _ServiceManagementState();
}

class _ServiceManagementState extends State<ServiceManagement> {
  List images = [
    Image.asset('assets/images/invoice.png'),
    Image.asset('assets/images/invoice (1).png'),
    Image.asset('assets/images/credit-card.png'),
    Image.asset('assets/images/star.png'),
    Image.asset('assets/images/performance.png'),
    Image.asset('assets/images/complaint.png'),
    Image.asset('assets/images/registration.png'),
    Image.asset('assets/images/faq.png'),
  ];

  List text = [
    'Bill Info',
    'Bill Fetch',
    'Payment Success',
    'Bill Fetch View',
    'Complain Status',
    'Complain Tracking',
    'Complain Registration',
    'Query Transaction',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 45,
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Color(0xff8DDCFB),
        title: Text('Services Management'),
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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding:  EdgeInsets.symmetric(horizontal: 14,vertical: 10),
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4),
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 8, // +1 for "More"
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 24,
                crossAxisSpacing: 14,
               // childAspectRatio: 0.9,
              ),
              itemBuilder: (context, idx) {
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      SizedBox(
                        height: 38,
                        width: 38,
                        child: images[idx],
                      ),
                      SizedBox(height: 10,),
                      Text(text[idx],style: TextStyle(),textAlign: TextAlign.center,)
                    ],
                  ),
                );

               // final s = services[idx];
               /* return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 38,
                        width: 38,
                        child: Image.network(
                          s['img']!,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        s['title']!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );*/
              },
            ),
          ),
        ),
      ),
    );
  }
}

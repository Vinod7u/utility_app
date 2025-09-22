import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:utility_app_flutter/screens/home/retailerSection/drawer.dart';

class RetailerHomePage extends StatefulWidget {
  const RetailerHomePage({super.key});

  @override
  State<RetailerHomePage> createState() => _RetailerHomePageState();
}

class _RetailerHomePageState extends State<RetailerHomePage> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: Builder(builder: (context){
          return InkWell(
            onTap: (){
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset('assets/icons/Vector.svg'),
            ),
          );
        }),
        leadingWidth: 45,surfaceTintColor: Colors.white,
        backgroundColor: Color(0xff8DDCFB),
        title:   Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // <-- border radius for Card
          ),
          elevation: 4,
          child: TextFormField(
            controller: _searchController,
            keyboardType: TextInputType.text,
            cursorColor: Colors.black,
            cursorHeight: 14,
            cursorWidth: 1,
            decoration: InputDecoration(
              hintText: "Search",
              //hintStyle: AppTextStyles.inriaSerif,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Icon(Icons.search, size: 16),
              prefixIconConstraints: BoxConstraints(
                minHeight: 20,
                minWidth: 30,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (v) {},
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            child: Icon(Icons.person),
          )
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff8DDCFB), Color(0xffFFFFFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset('assets/icons/streamline-plump_wallet.svg'),
                          Text('E Wallet:',style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      SizedBox(width: 30,),
                      Text('80.000/-'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/transaction (4) 1.png'),
                        Text('AEPS Transaction',textAlign: TextAlign.center,),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/rupee 1.png'),
                        Text('DMT Transaction',textAlign: TextAlign.center),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/images/inr 1.png'),
                        Text('BBPS Transaction',textAlign: TextAlign.center),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/images/hand.png'),
                        Text('Today’s Payin Count',textAlign: TextAlign.center),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/images/trade 1.png'),
                        Text('Today’s Payout Count',textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                ),
                padding: EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1), // thickness of the border
                          decoration: BoxDecoration(
                            color: Colors.transparent, // background outside avatar
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey, // border color
                              width: 1,           // border width
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Parkash',style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(height: 10,),
                            Text('Parkash@gmail.com'),
                          ],
                        )

                      ],
                    ),
                    Divider(),
                    SizedBox(height: 10,),
                    Text('Mobile Number:',style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 10,),
                    Text('Role:',style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 10,),
                    Text('Status:',style: TextStyle(fontWeight: FontWeight.w500),),
                    SizedBox(height: 10,),
                    Text('KYC:',style: TextStyle(fontWeight: FontWeight.w500),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

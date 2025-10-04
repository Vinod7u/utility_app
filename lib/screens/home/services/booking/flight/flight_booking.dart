import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:utility_app_flutter/screens/home/services/booking/flight/select_flight_screen.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';
import 'package:utility_app_flutter/widgets/app_button.dart';

class FlightBooking extends StatefulWidget {
  const FlightBooking({super.key});

  @override
  State<FlightBooking> createState() => _FlightBookingState();
}

class _FlightBookingState extends State<FlightBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SingleChildScrollView(
        child: Column(children: [_buildTopSection(), _banners()]),
      ),
    );
  }

  Widget _banners() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Offer",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              InkWell(
                onTap: () {},
                child: Text(
                  "View All >",
                  style: TextStyle(
                    color: AppColors.icon_blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage("assets/new_images/offer_image_flight.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 20),

          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage("assets/new_images/flight_deal.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Stack for From/To cards with swap button
          Stack(
            children: [
              Column(
                children: [
                  _buildItemCard(
                    title: "From",
                    subtitle: "Jaipur",
                    thirdText: "Jai",
                    forthText: "Jaipur national airport",
                    imageUrl: "assets/icons/flight-run.svg",
                  ),
                  _buildItemCard(
                    title: "To",
                    subtitle: "Delhi",
                    thirdText: "Del",
                    forthText: "Delhi airport",
                    imageUrl: "assets/icons/flight-land.svg",
                  ),
                ],
              ),

              // Positioned blue circular button
              Positioned(
                right: 50,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      // Handle swap action
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.icon_blue,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.black,
                            size: 16,
                          ),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Rest of your cards
          Row(
            children: [
              Expanded(
                child: _buildItemCard(
                  title: "Departure Date",
                  subtitle: "1 Oct ",
                  thirdText: "Wed,2025 ",
                  icon: Icons.calendar_month,
                ),
              ),
              Expanded(
                child: _buildItemCard(
                  title: "+ Add Return Date",
                  subtitle: "Save more on round trip",
                  thirdText: "",
                  imageUrl: "",
                ),
              ),
            ],
          ),

          _buildItemCard(
            title: "Traveller & Class",
            subtitle: "1",
            thirdText: "Economy Premium ",
            icon: Icons.person_2_outlined,
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Text(
                "Special Fare(Optional)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 5),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Extra Savings",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: _buildItemCard(
                  title: "Student",
                  subtitle: "Extra discount/Baggage",
                  thirdText: "",
                ),
              ),

              Expanded(
                child: _buildItemCard(
                  title: "Armed Force",
                  subtitle: "Upto RS. 100 OFF",
                  thirdText: "",
                ),
              ),
              Expanded(
                child: _buildItemCard(
                  title: "Senior Citizen",
                  subtitle: "Upto RS. 100 OFF",
                  thirdText: "",
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          appButton(
            title: "Search Flight",
            onTap: () {
              Get.to(() => SelectFlightScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard({
    required String title,
    required String subtitle,
    required String thirdText,
    String? forthText,
    IconData? icon,
    String? imageUrl,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading icon/image
            if (imageUrl != null && imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SvgPicture.asset(
                  imageUrl,
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              )
            else if (icon != null)
              Icon(icon, size: 30, color: Colors.blue),

            const SizedBox(width: 12),

            // Expanded content to prevent overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.darkColor,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          thirdText,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (forthText != null && forthText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        forthText,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

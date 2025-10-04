import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/services/bookings/booking_screen_controller.dart';
import 'package:utility_app_flutter/screens/home/services/booking/bus_booking_ui.dart';
import 'package:utility_app_flutter/screens/home/services/booking/flight_booking.dart';
import 'package:utility_app_flutter/screens/home/services/booking/hotel_booking_ui.dart';
import 'package:utility_app_flutter/screens/home/services/booking/tarin_booking_ui.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

class BookingScreen extends StatelessWidget {
  final String bookingService;
  BookingScreen({super.key, required this.bookingService});

  final controller = Get.put(BookingController());

  // Method to get initial tab index based on booking service
  int _getInitialTabIndex() {
    final service = bookingService.toLowerCase();
    if (service.contains('bus')) {
      return 0; // Bus tab
    } else if (service.contains('train')) {
      return 1; // Train tab
    } else if (service.contains('flight')) {
      return 2; // Flight tab
    } else if (service.contains('hotel')) {
      return 3; // Hotel tab
    }
    return 0; // Default to Bus
  }

  @override
  Widget build(BuildContext context) {
    // Set initial tab based on bookingService
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.changeTab(_getInitialTabIndex());
    });

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildCustomAppBar(),

          /// Tabs (images + text)
          SliverToBoxAdapter(
            child: Obx(
              () => Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.blue_shade,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(controller.tabs.length, (index) {
                    final isSelected = controller.selectedTab.value == index;
                    final tab = controller.tabs[index];
                    return GestureDetector(
                      onTap: () => controller.changeTab(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(tab["icon"]!, height: 28, width: 28),
                            const SizedBox(height: 4),
                            Text(
                              tab["title"]!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: AppColors.darkColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Selection indicator bar
                            Container(
                              height: 3,
                              width: 40,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.darkColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),

          /// Tab content - Updated to match controller tab order
          SliverFillRemaining(
            child: Obx(() {
              switch (controller.selectedTab.value) {
                case 0:
                  return BusBookingUi(); // Bus
                case 1:
                  return TarinBookingUi(); // Train
                case 2:
                  return FlightBooking(); // Flight
                case 3:
                  return HotelBookingUi(); // Hotel
                default:
                  return BusBookingUi();
              }
            }),
          ),
        ],
      ),
    );
  }

  /// Custom AppBar
  Widget _buildCustomAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 60,
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.appbarFirstColor, AppColors.appbarsecondColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                Text(
                  "Bookings",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.help_outline,
                      color: AppColors.appbarFirstColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

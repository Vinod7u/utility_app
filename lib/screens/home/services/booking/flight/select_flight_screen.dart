import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/controller/services/bookings/flight/select_flight_controller.dart';
import 'package:utility_app_flutter/utils/Constants/app_colors.dart';

// Controller

// Main Screen
class SelectFlightScreen extends StatefulWidget {
  SelectFlightScreen({Key? key}) : super(key: key);

  @override
  State<SelectFlightScreen> createState() => _SelectFlightScreenState();
}

class _SelectFlightScreenState extends State<SelectFlightScreen> {
  final SelectFlightController controller = Get.put(SelectFlightController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.off_white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildCustomAppBar(),
            SliverToBoxAdapter(child: _buildFilters()),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      _buildFlightCard(controller.flights[index]),
                  childCount: controller.flights.length,
                ),
              ),
            ),
            SliverToBoxAdapter(child: _buildBottomFilters()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      color: AppColors.blue_shade,
      child: Column(
        children: [
          // ✅ Make date row reactive
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectDate(0),
                    child: _buildDateCard(
                      'Tue 30, Sep',
                      '₹ 4800',
                      isHot: false,
                      isSelected: controller.selectedDateIndex.value == 0,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectDate(1),
                    child: _buildDateCard(
                      'Wed 01, Oct',
                      '₹ 5000',
                      isSelected: controller.selectedDateIndex.value == 1,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectDate(2),
                    child: _buildDateCard(
                      'Thu 02, Oct',
                      '₹ 5300',
                      isSelected: controller.selectedDateIndex.value == 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Cheapest', '₹ 5000'),
                const SizedBox(width: 8),
                _buildFilterChip('Discounted Price', '₹ 5000', isNew: true),
                const SizedBox(width: 8),
                _buildFilterChip('Fastest', '₹ 5200'),
                const SizedBox(width: 8),
                _buildFilterChip('Morning Flights', '₹ 4800'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateCard(
    String date,
    String price, {
    bool isHot = false,
    bool isSelected = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blue_shade : Colors.white,
        border: Border.all(
          color: isSelected ? AppColors.darkColor : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (isHot)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.darkColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const RotatedBox(
                quarterTurns: 3,
                child: Text(
                  'HOT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (isHot) const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, {bool isNew = false}) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectFilter(label),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: controller.selectedFilter.value == label
                    ? AppColors.blue_shade
                    : Colors.white,
                border: Border.all(
                  color: controller.selectedFilter.value == label
                      ? AppColors.darkColor
                      : Colors.grey.shade300,
                  width: controller.selectedFilter.value == label ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isNew)
              Positioned(
                top: -8,
                right: -8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.darkColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'New',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightCard(Flight flight) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (flight.hasVisaSeat)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                'Free seat with Visa Card',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.darkColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.flight,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      flight.airline,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          flight.departureTime,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          flight.departureCity,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          flight.duration,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          'Non Stop',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          flight.arrivalTime,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          flight.arrivalCity,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '₹ ${flight.price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Per adult',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ...flight.offers.map(
                  (offer) => Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.lime.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(offer, style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: AppColors.darkColor,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Lock this price starting from ₹ 302',
                      style: TextStyle(
                        color: AppColors.darkColor,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 8),

                    Icon(
                      Icons.arrow_right,
                      color: AppColors.darkColor,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomFilters() {
    // List of bottom filter items
    final List<Map<String, String>> filters = [
      {'label': 'Non Stop', 'value': 'Any'},
      {'label': 'Airline', 'value': 'Indigo'},
      {'label': 'Airline', 'value': 'Air India'},
      {'label': 'Departure', 'value': 'Afternoon'},
      {'label': 'Airline', 'value': 'Indigo'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.blue_shade.withOpacity(0.1),
                  border: Border.all(color: AppColors.blue_shade),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  filter['label']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.blue_shade,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Delhi to Mumbai',
                          style: TextStyle(
                            color: AppColors.darkColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '2 Oct | 1 Adult |  Economy',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 20,
                    height: 20,
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

// Usage

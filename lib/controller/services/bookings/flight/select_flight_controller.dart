import 'package:get/get.dart';

class SelectFlightController extends GetxController {
  var selectedFilter = 'Cheapest'.obs;

  // ✅ Added date selection
  var selectedDateIndex = 1.obs;

  var flights = <Flight>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFlights();
  }

  void loadFlights() {
    // Sample flight data
    flights.value = [
      Flight(
        airline: 'IndiGo',
        departureTime: '17:40',
        arrivalTime: '19:55',
        departureCity: 'Jaipur',
        arrivalCity: 'Pune',
        duration: '2h 25m',
        price: 7000,
        offers: [
          'FLAT ₹132 OFF using SEVENUNIQUE | Upto 10% OFF on HDFC Credit cards using SEVENUNIQUE'
        ],
        hasVisaSeat: true,
        isNonStop: true,
      ),
      Flight(
        airline: 'Air India',
        departureTime: '09:00',
        arrivalTime: '11:15',
        departureCity: 'Jaipur',
        arrivalCity: 'Pune',
        duration: '2h 15m',
        price: 7500,
        offers: [
          'Extra 5% OFF on Axis Bank Cards',
        ],
        hasVisaSeat: false,
        isNonStop: true,
      ),
      Flight(
        airline: 'Vistara',
        departureTime: '14:30',
        arrivalTime: '16:45',
        departureCity: 'Jaipur',
        arrivalCity: 'Pune',
        duration: '2h 15m',
        price: 7200,
        offers: [
          'Special Offer: ₹100 cashback on UPI payment',
        ],
        hasVisaSeat: true,
        isNonStop: false,
      ),
    ];
  }

  // ✅ Select filter
  void selectFilter(String filter) {
    selectedFilter.value = filter;
  }

  // ✅ Select date card
  void selectDate(int index) {
    selectedDateIndex.value = index;
  }
}

// ✅ Model class
class Flight {
  final String airline;
  final String departureTime;
  final String arrivalTime;
  final String departureCity;
  final String arrivalCity;
  final String duration;
  final double price;
  final List<String> offers;
  final bool hasVisaSeat;
  final bool isNonStop;

  Flight({
    required this.airline,
    required this.departureTime,
    required this.arrivalTime,
    required this.departureCity,
    required this.arrivalCity,
    required this.duration,
    required this.price,
    required this.offers,
    required this.hasVisaSeat,
    required this.isNonStop,
  });
}

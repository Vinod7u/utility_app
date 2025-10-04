import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/models/service_selection_model.dart';
import 'package:utility_app_flutter/utils/Constants/appimage.dart';

class ServiceProcessController extends GetxController {
  late ServiceConfig config;
  final TextEditingController searchController = TextEditingController();
  final TextEditingController inputController = TextEditingController();
  List<Map<String, String>> filteredItems = [];

  ServiceConfig getServiceConfig(String serviceName) {
    switch (serviceName.toLowerCase().trim()) {
      // FastTag Service
      case 'fasttag':
      case 'fastag':
      case 'fast tag':
        return ServiceConfig(
          title: "FastTag Recharge",
          inputHint: "Enter Vehicle Number",
          topSectionTitle: "Top FastTag Banks",
          allSectionTitle: "All FastTag Banks",
          topItems: [
            {"name": "HDFC Bank", "logo": Appimage.hdfc},
            {"name": "ICICI Bank", "logo": Appimage.icici},
            {"name": "State Bank of India", "logo": Appimage.sbi},
            {"name": "Axis Bank", "logo": Appimage.hdfc},
          ],
          allItems: [
            {"name": "HDFC Bank", "logo": Appimage.hdfc},
            {"name": "ICICI Bank", "logo": Appimage.icici},
            {"name": "State Bank of India", "logo": Appimage.sbi},
            {"name": "Axis Bank", "logo": Appimage.hdfc},
            {"name": "Kotak Mahindra Bank", "logo": Appimage.icici},
            {"name": "Yes Bank", "logo": Appimage.sbi},
            {"name": "IndusInd Bank", "logo": Appimage.hdfc},
            {"name": "Federal Bank", "logo": Appimage.icici},
          ],
          showSearchBar: false,
          showInfoCard: false,
        );

      // Electricity Bill Service
      case 'electricity':
      case 'electricity bill':
      case 'electricitybill':
        return ServiceConfig(
          title: "Electricity Bill",
          inputHint: "Search Electricity Board",
          topSectionTitle: "Billers in Rajasthan",
          allSectionTitle: "All Electricity Boards",
          topItems: [],
          allItems: [
            {
              "name": "Ajmer Vidyut Vitran Nigam Ltd (AVVNL)",
              "logo": Appimage.hdfc,
            },
            {
              "name": "Bharatpur Electricity Services Ltd (BESL)",
              "logo": Appimage.icici,
            },
            {
              "name": "Bikaner Electricity Supply Limited (BKSEL)",
              "logo": Appimage.sbi,
            },
            {
              "name": "Jaipur Vidyut Vitran Nigam Ltd (JVVNL)",
              "logo": Appimage.hdfc,
            },
            {
              "name": "Jodhpur Vidyut Vitran Nigam Ltd (JDVVNL)",
              "logo": Appimage.icici,
            },
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // DTH Service
      case 'dth':
      case 'dth recharge':
      case 'dth bill':
        return ServiceConfig(
          title: "DTH Recharge",
          inputHint: "Search DTH Provider",
          topSectionTitle: "Popular DTH Providers",
          allSectionTitle: "All DTH Providers",
          topItems: [
            {"name": "Airtel Digital TV", "logo": Appimage.hdfc},
            {"name": "Tata Play", "logo": Appimage.icici},
            {"name": "Dish TV", "logo": Appimage.sbi},
          ],
          allItems: [
            {"name": "Airtel Digital TV", "logo": Appimage.hdfc},
            {"name": "Tata Play", "logo": Appimage.icici},
            {"name": "Dish TV", "logo": Appimage.sbi},
            {"name": "Sun Direct", "logo": Appimage.hdfc},
            {"name": "Videocon d2h", "logo": Appimage.icici},
            {"name": "DD Free Dish", "logo": Appimage.sbi},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // Gas Service
      case 'gas':
      case 'gas bill':
      case 'piped gas':
        return ServiceConfig(
          title: "Gas Bill Payment",
          inputHint: "Search Gas Provider",
          topSectionTitle: "Popular Gas Providers",
          allSectionTitle: "All Gas Providers",
          topItems: [
            {"name": "Indraprastha Gas Limited", "logo": Appimage.hdfc},
            {"name": "Mahanagar Gas Limited", "logo": Appimage.icici},
            {"name": "Gujarat Gas", "logo": Appimage.sbi},
          ],
          allItems: [
            {"name": "Indraprastha Gas Limited", "logo": Appimage.hdfc},
            {"name": "Mahanagar Gas Limited", "logo": Appimage.icici},
            {"name": "Gujarat Gas", "logo": Appimage.sbi},
            {"name": "Adani Gas", "logo": Appimage.hdfc},
            {"name": "Bhagyanagar Gas Limited", "logo": Appimage.icici},
            {"name": "Central UP Gas Limited", "logo": Appimage.sbi},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // LPG Gas Service
      case 'lpg gas':
      case 'lpg':
      case 'lpg cylinder':
        return ServiceConfig(
          title: "LPG Gas Booking",
          inputHint: "Search LPG Provider",
          topSectionTitle: "LPG Providers",
          allSectionTitle: "All LPG Providers",
          topItems: [
            {"name": "Indane Gas", "logo": Appimage.hdfc},
            {"name": "HP Gas", "logo": Appimage.icici},
            {"name": "Bharat Gas", "logo": Appimage.sbi},
          ],
          allItems: [
            {"name": "Indane Gas", "logo": Appimage.hdfc},
            {"name": "HP Gas", "logo": Appimage.icici},
            {"name": "Bharat Gas", "logo": Appimage.sbi},
          ],
          showSearchBar: false,
          showInfoCard: false,
        );

      // Water Bill Service
      case 'water':
      case 'water bill':
        return ServiceConfig(
          title: "Water Bill Payment",
          inputHint: "Search Water Board",
          topSectionTitle: "Water Boards",
          allSectionTitle: "All Water Boards",
          topItems: [],
          allItems: [
            {"name": "Jaipur Water Board", "logo": Appimage.hdfc},
            {"name": "Delhi Jal Board", "logo": Appimage.icici},
            {"name": "Mumbai Municipal Corporation", "logo": Appimage.sbi},
            {"name": "Bangalore Water Supply", "logo": Appimage.hdfc},
            {"name": "Chennai Metro Water", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // Broadband Postpaid Service
      case 'broadband postpaid':
      case 'broadband':
      case 'internet':
        return ServiceConfig(
          title: "Broadband Bill Payment",
          inputHint: "Search Broadband Provider",
          topSectionTitle: "Popular Broadband Providers",
          allSectionTitle: "All Broadband Providers",
          topItems: [
            {"name": "Airtel Broadband", "logo": Appimage.hdfc},
            {"name": "Jio Fiber", "logo": Appimage.icici},
            {"name": "ACT Fibernet", "logo": Appimage.sbi},
          ],
          allItems: [
            {"name": "Airtel Broadband", "logo": Appimage.hdfc},
            {"name": "Jio Fiber", "logo": Appimage.icici},
            {"name": "ACT Fibernet", "logo": Appimage.sbi},
            {"name": "BSNL Broadband", "logo": Appimage.hdfc},
            {"name": "Hathway Broadband", "logo": Appimage.icici},
            {"name": "Tikona Broadband", "logo": Appimage.sbi},
            {"name": "YOU Broadband", "logo": Appimage.hdfc},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Cable TV Service
      case 'cable tv':
      case 'cable':
        return ServiceConfig(
          title: "Cable TV Bill Payment",
          inputHint: "Search Cable TV Provider",
          topSectionTitle: "Popular Cable TV Providers",
          allSectionTitle: "All Cable TV Providers",
          topItems: [],
          allItems: [
            {"name": "Hathway Cable", "logo": Appimage.hdfc},
            {"name": "Den Networks", "logo": Appimage.icici},
            {"name": "GTPL", "logo": Appimage.sbi},
            {"name": "Siti Cable", "logo": Appimage.hdfc},
            {"name": "InCable", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // Credit Card Service
      case 'credit cards':
      case 'credit card':
        return ServiceConfig(
          title: "Credit Card Payment",
          inputHint: "Search Bank",
          topSectionTitle: "Popular Banks",
          allSectionTitle: "All Banks",
          topItems: [
            {"name": "HDFC Bank", "logo": Appimage.hdfc},
            {"name": "ICICI Bank", "logo": Appimage.icici},
            {"name": "SBI Credit Card", "logo": Appimage.sbi},
            {"name": "Axis Bank", "logo": Appimage.hdfc},
          ],
          allItems: [
            {"name": "HDFC Bank", "logo": Appimage.hdfc},
            {"name": "ICICI Bank", "logo": Appimage.icici},
            {"name": "SBI Credit Card", "logo": Appimage.sbi},
            {"name": "Axis Bank", "logo": Appimage.hdfc},
            {"name": "Kotak Mahindra Bank", "logo": Appimage.icici},
            {"name": "IndusInd Bank", "logo": Appimage.sbi},
            {"name": "Yes Bank", "logo": Appimage.hdfc},
            {"name": "Standard Chartered", "logo": Appimage.icici},
            {"name": "Citibank", "logo": Appimage.sbi},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Insurance Service
      case 'insurance':
      case 'life insurance':
      case 'health insurance':
        return ServiceConfig(
          title: "Insurance Premium Payment",
          inputHint: "Search Insurance Provider",
          topSectionTitle: "Popular Insurance Providers",
          allSectionTitle: "All Insurance Providers",
          topItems: [
            {"name": "LIC", "logo": Appimage.hdfc},
            {"name": "HDFC Life", "logo": Appimage.icici},
            {"name": "SBI Life", "logo": Appimage.sbi},
            {"name": "ICICI Prudential", "logo": Appimage.hdfc},
          ],
          allItems: [
            {"name": "LIC", "logo": Appimage.hdfc},
            {"name": "HDFC Life", "logo": Appimage.icici},
            {"name": "SBI Life", "logo": Appimage.sbi},
            {"name": "ICICI Prudential", "logo": Appimage.hdfc},
            {"name": "Max Life Insurance", "logo": Appimage.icici},
            {"name": "Bajaj Allianz", "logo": Appimage.sbi},
            {"name": "Star Health Insurance", "logo": Appimage.hdfc},
            {"name": "Care Health Insurance", "logo": Appimage.icici},
            {"name": "Niva Bupa Health", "logo": Appimage.sbi},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Mobile Postpaid Service
      case 'mobile postpaid':
      case 'postpaid':
      case 'mobile bill':
        return ServiceConfig(
          title: "Mobile Postpaid Bill",
          inputHint: "Search Mobile Operator",
          topSectionTitle: "Popular Operators",
          allSectionTitle: "All Mobile Operators",
          topItems: [
            {"name": "Airtel", "logo": Appimage.hdfc},
            {"name": "Jio", "logo": Appimage.icici},
            {"name": "Vi (Vodafone Idea)", "logo": Appimage.sbi},
          ],
          allItems: [
            {"name": "Airtel", "logo": Appimage.hdfc},
            {"name": "Jio", "logo": Appimage.icici},
            {"name": "Vi (Vodafone Idea)", "logo": Appimage.sbi},
            {"name": "BSNL", "logo": Appimage.hdfc},
            {"name": "MTNL", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Landline Postpaid Service
      case 'landline postpaid':
      case 'landline':
      case 'landline bill':
        return ServiceConfig(
          title: "Landline Bill Payment",
          inputHint: "Search Landline Provider",
          topSectionTitle: "Landline Providers",
          allSectionTitle: "All Landline Providers",
          topItems: [],
          allItems: [
            {"name": "BSNL Landline", "logo": Appimage.hdfc},
            {"name": "MTNL Landline", "logo": Appimage.icici},
            {"name": "Airtel Landline", "logo": Appimage.sbi},
            {"name": "Jio Landline", "logo": Appimage.hdfc},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // Education Fees Service
      case 'education fees':
      case 'school fees':
      case 'college fees':
        return ServiceConfig(
          title: "Education Fees Payment",
          inputHint: "Search Institution",
          topSectionTitle: "Payment Categories",
          allSectionTitle: "All Categories",
          topItems: [],
          allItems: [
            {"name": "School Fees", "logo": Appimage.hdfc},
            {"name": "College Fees", "logo": Appimage.icici},
            {"name": "University Fees", "logo": Appimage.sbi},
            {"name": "Coaching Classes", "logo": Appimage.hdfc},
            {"name": "Online Courses", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Loan Payment Service
      case 'loan payment':
      case 'loan':
      case 'emi':
        return ServiceConfig(
          title: "Loan Payment",
          inputHint: "Search Bank/NBFC",
          topSectionTitle: "Popular Banks & NBFCs",
          allSectionTitle: "All Loan Providers",
          topItems: [
            {"name": "HDFC Bank", "logo": Appimage.hdfc},
            {"name": "ICICI Bank", "logo": Appimage.icici},
            {"name": "SBI", "logo": Appimage.sbi},
          ],
          allItems: [
            {"name": "HDFC Bank", "logo": Appimage.hdfc},
            {"name": "ICICI Bank", "logo": Appimage.icici},
            {"name": "SBI", "logo": Appimage.sbi},
            {"name": "Bajaj Finserv", "logo": Appimage.hdfc},
            {"name": "Tata Capital", "logo": Appimage.icici},
            {"name": "Axis Bank", "logo": Appimage.sbi},
            {"name": "Kotak Mahindra", "logo": Appimage.hdfc},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Housing Society Service
      case 'housing society':
      case 'society maintenance':
      case 'maintenance':
        return ServiceConfig(
          title: "Housing Society Payment",
          inputHint: "Search Society Name",
          topSectionTitle: "Society Payments",
          allSectionTitle: "Payment Options",
          topItems: [],
          allItems: [
            {"name": "Maintenance Charges", "logo": Appimage.hdfc},
            {"name": "Society Membership", "logo": Appimage.icici},
            {"name": "Parking Fees", "logo": Appimage.sbi},
            {"name": "Amenity Charges", "logo": Appimage.hdfc},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // Clubs and Association Service
      case 'clubs and association':
      case 'club membership':
      case 'association':
        return ServiceConfig(
          title: "Clubs & Association",
          inputHint: "Search Club/Association",
          topSectionTitle: "Membership Types",
          allSectionTitle: "All Memberships",
          topItems: [],
          allItems: [
            {"name": "Sports Club", "logo": Appimage.hdfc},
            {"name": "Fitness Club", "logo": Appimage.icici},
            {"name": "Golf Club", "logo": Appimage.sbi},
            {"name": "Social Club", "logo": Appimage.hdfc},
            {"name": "Professional Association", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Municipal Services
      case 'municipal services':
      case 'municipal':
        return ServiceConfig(
          title: "Municipal Services",
          inputHint: "Search Municipal Service",
          topSectionTitle: "Municipal Services",
          allSectionTitle: "All Services",
          topItems: [],
          allItems: [
            {"name": "Property Tax", "logo": Appimage.hdfc},
            {"name": "Water Charges", "logo": Appimage.icici},
            {"name": "Sewerage Charges", "logo": Appimage.sbi},
            {"name": "Birth Certificate", "logo": Appimage.hdfc},
            {"name": "Trade License", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // Municipal Taxes Service
      case 'municipal taxes':
      case 'property tax':
        return ServiceConfig(
          title: "Municipal Taxes",
          inputHint: "Search Municipality",
          topSectionTitle: "Tax Types",
          allSectionTitle: "All Municipal Taxes",
          topItems: [],
          allItems: [
            {"name": "Property Tax", "logo": Appimage.hdfc},
            {"name": "House Tax", "logo": Appimage.icici},
            {"name": "Professional Tax", "logo": Appimage.sbi},
            {"name": "Water Tax", "logo": Appimage.hdfc},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // Donation Service
      case 'donation':
      case 'charity':
        return ServiceConfig(
          title: "Donation",
          inputHint: "Search NGO/Charity",
          topSectionTitle: "Featured NGOs",
          allSectionTitle: "All Organizations",
          topItems: [],
          allItems: [
            {"name": "PM CARES Fund", "logo": Appimage.hdfc},
            {"name": "CRY - Child Rights", "logo": Appimage.icici},
            {"name": "Akshaya Patra", "logo": Appimage.sbi},
            {"name": "HelpAge India", "logo": Appimage.hdfc},
            {"name": "Goonj", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // Rental Service
      case 'rental':
      case 'rent':
      case 'house rent':
        return ServiceConfig(
          title: "Rent Payment",
          inputHint: "Enter Landlord Details",
          topSectionTitle: "Rent Payment",
          allSectionTitle: "Payment Options",
          topItems: [],
          allItems: [
            {"name": "House Rent", "logo": Appimage.hdfc},
            {"name": "Commercial Rent", "logo": Appimage.icici},
            {"name": "Flat Rent", "logo": Appimage.sbi},
          ],
          showSearchBar: false,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Subscription Service
      case 'subscription':
      case 'subscriptions':
        return ServiceConfig(
          title: "Subscription Payment",
          inputHint: "Search Subscription",
          topSectionTitle: "Popular Subscriptions",
          allSectionTitle: "All Subscriptions",
          topItems: [
            {"name": "Netflix", "logo": Appimage.hdfc},
            {"name": "Amazon Prime", "logo": Appimage.icici},
            {"name": "Disney+ Hotstar", "logo": Appimage.sbi},
          ],
          allItems: [
            {"name": "Netflix", "logo": Appimage.hdfc},
            {"name": "Amazon Prime", "logo": Appimage.icici},
            {"name": "Disney+ Hotstar", "logo": Appimage.sbi},
            {"name": "Spotify", "logo": Appimage.hdfc},
            {"name": "YouTube Premium", "logo": Appimage.icici},
            {"name": "Sony LIV", "logo": Appimage.sbi},
            {"name": "Zee5", "logo": Appimage.hdfc},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Recurring Deposit Service
      case 'recurring deposit':
      case 'rd':
        return ServiceConfig(
          title: "Recurring Deposit",
          inputHint: "Search Bank",
          topSectionTitle: "Banks Offering RD",
          allSectionTitle: "All Banks",
          topItems: [],
          allItems: [
            {"name": "HDFC Bank", "logo": Appimage.hdfc},
            {"name": "ICICI Bank", "logo": Appimage.icici},
            {"name": "SBI", "logo": Appimage.sbi},
            {"name": "Axis Bank", "logo": Appimage.hdfc},
            {"name": "Kotak Mahindra", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // NCMC (Metro Card) Service
      case 'ncmc':
      case 'metro card':
      case 'metro':
        return ServiceConfig(
          title: "Metro Card Recharge",
          inputHint: "Search Metro",
          topSectionTitle: "Metro Services",
          allSectionTitle: "All Metro Cards",
          topItems: [],
          allItems: [
            {"name": "Delhi Metro", "logo": Appimage.hdfc},
            {"name": "Mumbai Metro", "logo": Appimage.icici},
            {"name": "Bangalore Metro", "logo": Appimage.sbi},
            {"name": "Hyderabad Metro", "logo": Appimage.hdfc},
            {"name": "Chennai Metro", "logo": Appimage.icici},
            {"name": "Kolkata Metro", "logo": Appimage.sbi},
          ],
          showSearchBar: true,
          showInfoCard: false,
        );

      // NPS Service
      case 'nps':
      case 'national pension system':
        return ServiceConfig(
          title: "NPS Contribution",
          inputHint: "Enter PRAN Number",
          topSectionTitle: "NPS",
          allSectionTitle: "Contribution Options",
          topItems: [],
          allItems: [
            {"name": "Regular Contribution", "logo": Appimage.hdfc},
            {"name": "Tier I Account", "logo": Appimage.icici},
            {"name": "Tier II Account", "logo": Appimage.sbi},
          ],
          showSearchBar: false,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Prepaid Meter Service
      case 'prepaid meter':
      case 'prepaid electricity':
        return ServiceConfig(
          title: "Prepaid Meter Recharge",
          inputHint: "Enter Meter Number",
          topSectionTitle: "Prepaid Electricity Boards",
          allSectionTitle: "All Boards",
          topItems: [],
          allItems: [
            {"name": "BSES Rajdhani", "logo": Appimage.hdfc},
            {"name": "BSES Yamuna", "logo": Appimage.icici},
            {"name": "Tata Power Delhi", "logo": Appimage.sbi},
            {"name": "Adani Electricity", "logo": Appimage.hdfc},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // E-Challan Service
      case 'e- challan':
      case 'e-challan':
      case 'challan':
      case 'traffic fine':
        return ServiceConfig(
          title: "E-Challan Payment",
          inputHint: "Enter Challan Number",
          topSectionTitle: "Traffic Authorities",
          allSectionTitle: "All States",
          topItems: [],
          allItems: [
            {"name": "Delhi Traffic Police", "logo": Appimage.hdfc},
            {"name": "Mumbai Traffic Police", "logo": Appimage.icici},
            {"name": "Bangalore Traffic Police", "logo": Appimage.sbi},
            {"name": "Hyderabad Traffic Police", "logo": Appimage.hdfc},
            {"name": "Rajasthan Police", "logo": Appimage.icici},
          ],
          showSearchBar: true,
          showInfoCard: true,
          infoCardTitle: "Avoid missed bill payments and overdue charges",
          infoCardDescription:
              "Allow access to your text messages to fetch your bills and remind on time",
          infoCardButtonText: "Allow",
        );

      // Default fallback
      default:
        return ServiceConfig(
          title: serviceName,
          inputHint: "Search Provider",
          topSectionTitle: "Top Providers",
          allSectionTitle: "All Providers",
          topItems: [],
          allItems: [],
          showSearchBar: true,
          showInfoCard: false,
        );
    }
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems = config.allItems;
    } else {
      filteredItems = config.allItems
          .where(
            (item) => item['name']!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }
}

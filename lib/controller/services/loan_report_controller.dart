import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoanReportController extends GetxController{
  var loanReports = [
    {
      "id": "LN001",
      "type": "Personal Loan",
      "amount": "₹50,000",
      "status": "Approved"
    },
    {
      "id": "LN002",
      "type": "Home Loan",
      "amount": "₹10,00,000",
      "status": "Pending"
    },
    {
      "id": "LN003",
      "type": "Car Loan",
      "amount": "₹5,00,000",
      "status": "Rejected"
    },
  ].obs;
}
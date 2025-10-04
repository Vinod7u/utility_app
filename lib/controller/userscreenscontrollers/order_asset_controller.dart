import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OrderAssetController extends GetxController {
  var products = List.generate(10, (index) {
    return {
      "id": "${index + 1}",
      "name": "Aadhar Scanner ${index + 1}",
      "price": "₹${15000 + index * 500}",
      "image":
          "https://img.lovepik.com/element/40177/3459.png_1200.png", // No URL, will use placeholder
    };
  }).obs;
}

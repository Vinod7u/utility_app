import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class RechargescreenController extends GetxController {
  var contacts = <Contact>[].obs; // All contacts
  var filteredContacts = <Contact>[].obs; // Search results
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    isLoading.value = true;

    // Request permission using the plugin's wrapper
    bool permissionGranted = await FlutterContacts.requestPermission(
      readonly: true,
    );
    if (permissionGranted) {
      List<Contact> _contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      contacts.assignAll(_contacts);
      filteredContacts.assignAll(_contacts);
    } else {
      Get.snackbar(
        "Permission Denied",
        "Please allow contacts permission in settings",
      );
    }

    isLoading.value = false;
  }

  // 🔍 Search by phone number
  void searchContact(String query) {
    if (query.isEmpty) {
      filteredContacts.assignAll(contacts);
    } else {
      filteredContacts.assignAll(
        contacts
            .where(
              (c) =>
                  (c.phones?.any((p) => p.number?.contains(query) ?? false) ??
                  false),
            )
            .toList(),
      );
    }
  }
}

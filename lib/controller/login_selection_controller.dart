import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/getApirepository/get_api_repo.dart';
import 'package:utility_app_flutter/models/candidate_role.dart';

class LoginSelectionController extends GetxController {
  final GetApiRepo getApiRepo = GetApiRepo();
  var roles = <CandidateRoleData>[].obs;
  var filteredRoles = <CandidateRoleData>[].obs;

  var isLoading = false.obs;

  Future<void> loadRoles() async {
    try {
      isLoading.value = true;
      roles.value = (await getApiRepo.fetchRoles()).data ?? [];
      filteredRoles.value = roles
        .where((role) =>
            role.role?.toLowerCase() == "user" ||
            role.role?.toLowerCase() == "retailer" ||
            role.role?.toLowerCase() == "distributor")
        .toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching roles: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:utility_app_flutter/getApirepository/get_api_repo.dart';
import 'package:utility_app_flutter/models/candidate_role.dart';

class LoginSelectionController extends GetxController {
  final GetApiRepo getApiRepo = GetApiRepo();
  var roles = <CandidateRoleData>[].obs;
  var isLoading = false.obs;

  Future<void> loadRoles() async {
    try {
      isLoading.value = true;
      roles.value = (await getApiRepo.fetchRoles()).data ?? [];
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching roles: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }
}

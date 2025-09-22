import 'package:flutter/material.dart';
import 'package:utility_app_flutter/models/candidate_role.dart';
import 'package:utility_app_flutter/utils/Constants/api_url.dart';
import 'package:utility_app_flutter/utils/appServices/apiservices.dart';

class GetApiRepo {
  final Apiservices apiservices = Apiservices();

  // Get Api Repo Class
  Future<CandidateRole> fetchRoles() async {
    try {
      final response = await apiservices.getRequest(ApiUrl.getrole);
      return CandidateRole.fromJson(response.data);
    } catch (e) {
      debugPrint("❌ Failed to fetch roles: $e");
      throw Exception("Unable to fetch roles, please try again later.");
    }
  }
}

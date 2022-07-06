import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProfileRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getUserInfo() async {
      Response _response = await apiClient.get(AppConstants.profileUri);
      return _response;

  }

}

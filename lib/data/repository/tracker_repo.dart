import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/data/model/body/track_body.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';

class TrackerRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  TrackerRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> getTrackList(String id, DateTime filterDate) async {
    String startDate = '${DateFormat('yyyy-MM-dd').format(filterDate)}T00:00:00.000Z';
    String endDate = '${DateFormat('yyyy-MM-dd').format(filterDate)}T23:59:59.000Z';
    Response response = await apiClient.get('/tracks?user.id=$id&date_gte=$startDate&date_lte=$endDate');
    return response;

  }

  Future<Response> getHistoryList(String id) async {
    Response response = await apiClient.get('/track-histories?track=$id');
    return response;

  }
  Future<Response> addHistory(TrackBody trackBody) async {
      Response response = await apiClient.post(AppConstants.recordLocationUri, trackBody.toJson(),
        headers:  {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${sharedPreferences.get(AppConstants.token)}'
        },
      );
      return response;

  }

}
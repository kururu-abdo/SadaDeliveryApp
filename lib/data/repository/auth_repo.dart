import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_delivery_boy/data/api/api_client.dart';
import 'package:sixvalley_delivery_boy/data/model/response/profile_model.dart';
import 'package:sixvalley_delivery_boy/utill/app_constants.dart';


class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.apiClient, @required this.sharedPreferences});

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstants.loginUri,
        {"email": email, "password": password});
  }

  Future<Response> getProfileInfo() async {
    return await apiClient.getData(AppConstants.profileUri);
  }

  Future<Response> changePassword(ProfileModel userInfoModel, String password) async {
    return await apiClient.postData(AppConstants.updateProfileUri, {'_method': 'put', 'f_name': userInfoModel.fName,
      'l_name': userInfoModel.lName, 'email': userInfoModel.email, 'password': password, 'token': getUserToken()});
  }



  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.mainHeaders = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};
    return await sharedPreferences.setString(AppConstants.token, token);
  }




  Future<Response> updateToken() async {
    String _deviceToken;
    if (GetPlatform.isIOS) {
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
        debugPrint('=========>Device Token ======$_deviceToken');
      }
    }else {
      _deviceToken = await _saveDeviceToken();
      debugPrint('=========>Device Token ======$_deviceToken');
    }
    if(!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic('six_valley_delivery');
    }
    return await apiClient.postData(AppConstants.tokenUri,

        {"_method": "put", "fcm_token": _deviceToken},
      headers:  {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${sharedPreferences.get(AppConstants.token)}'
      },
    );
  }


  Future<String> _saveDeviceToken() async {
    String _deviceToken = '';
    if(!GetPlatform.isWeb) {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }
    if (_deviceToken != null) {
    }
    return _deviceToken;
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<bool> clearSharedData() async {
    if(!GetPlatform.isWeb) {
      apiClient.postData(AppConstants.tokenUri, {"_method": "put", "fcm_token": 'no'});
    }
    await sharedPreferences.remove(AppConstants.token);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.userPassword, password);
      await sharedPreferences.setString(AppConstants.userEmail, number);
    } catch (e) {
      rethrow;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.userEmail) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.userPassword) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.userPassword);
    return await sharedPreferences.remove(AppConstants.userEmail);
  }

}

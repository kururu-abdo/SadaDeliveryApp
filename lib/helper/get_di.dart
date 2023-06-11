import 'dart:convert';
import 'dart:developer';


import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/controller/auth_controller.dart';
import 'package:eamar_delivery/controller/language_controller.dart';
import 'package:eamar_delivery/controller/localization_controller.dart';
import 'package:eamar_delivery/controller/location_controller.dart';
import 'package:eamar_delivery/controller/order_controller.dart';
import 'package:eamar_delivery/controller/profile_controller.dart';
import 'package:eamar_delivery/controller/splash_controller.dart';
import 'package:eamar_delivery/controller/theme_controller.dart';
import 'package:eamar_delivery/controller/tracker_controller.dart';
import 'package:eamar_delivery/data/api/api_client.dart';
import 'package:eamar_delivery/data/model/response/language_model.dart';
import 'package:eamar_delivery/data/repository/auth_repo.dart';
import 'package:eamar_delivery/data/repository/language_repo.dart';
import 'package:eamar_delivery/data/repository/order_repo.dart';
import 'package:eamar_delivery/data/repository/profile_repo.dart';
import 'package:eamar_delivery/data/repository/splash_repo.dart';
import 'package:eamar_delivery/data/repository/tracker_repo.dart';
import 'package:eamar_delivery/utill/app_constants.dart';
// class MainBindings extends Bindings {
//   @override
 Future<void> dependencies() async {
// try {
  
     
// Core
SharedPreferences 
 sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences ,
  
  permanent: true
  );

  Get.put<ApiClient>( ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  ));






  // Repository
  Get.put( SplashRepo(sharedPreferences: sharedPreferences, apiClient: 
 
  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  )
  
  
  ));
  Get.put( LanguageRepo());
  Get.put( ProfileRepo(apiClient:
  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  )
   
   , sharedPreferences: 
  
  
  sharedPreferences));
  Get.put( AuthRepo(apiClient:  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  ), sharedPreferences: sharedPreferences));
  Get.put( OrderRepo(apiClient:  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  ), sharedPreferences: sharedPreferences));
  Get.put( TrackerRepo(apiClient:  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  ), sharedPreferences: sharedPreferences));
  // Get.lazyPut(() => NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
      Get.put( ThemeController(sharedPreferences: sharedPreferences));

  Get.put( SplashController(splashRepo: SplashRepo(sharedPreferences: sharedPreferences, apiClient: 
 
  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  )
  
  
  )));
  Get.put(  LocalizationController(sharedPreferences:sharedPreferences));
  Get.put( LanguageController(sharedPreferences: sharedPreferences));
  Get.put( AuthController(authRepo:AuthRepo(apiClient:  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  ), sharedPreferences: sharedPreferences)));

  Get.put( AuthRepo(apiClient:  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  ), sharedPreferences: sharedPreferences));
  Get.put( ProfileController(profileRepo: ProfileRepo(apiClient:
  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  )
   
   , sharedPreferences: 
  
  
  sharedPreferences)));
  Get.put( LocalizationController(sharedPreferences: sharedPreferences));
  Get.put( LocationController(sharedPreferences: sharedPreferences));
  Get.put( TrackerController(trackerRepo: TrackerRepo(apiClient:  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  ), sharedPreferences: sharedPreferences)));
  
Get.put(

  OrderController(orderRepo:  OrderRepo(apiClient:  ApiClient(appBaseUrl: AppConstants.baseUri, sharedPreferences: 
  sharedPreferences
  
  ), sharedPreferences:
  sharedPreferences
  ), 
  
  )


 ,permanent: true

);

  log('ALL DEPENENCIES INJECTED');
  
  // Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));

// } catch (e) {
//   log(e.toString());
  
// }

  }
  
// }
Future<Map<String, Map<String, String>>> init() async {
  
  // Retrieving localized data
  Map<String, Map<String, String>> _languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = {};
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;
}

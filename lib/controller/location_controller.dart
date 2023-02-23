import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';




class LocationController extends GetxController implements GetxService{

  final SharedPreferences sharedPreferences;
  LocationController({@required this.sharedPreferences});
  Placemark _address = Placemark();

  Placemark get address => _address;
  Position _currentLocation = Position(
    latitude: 0, longitude: 0,
    speed: 1, speedAccuracy: 1, altitude: 1, accuracy: 1, heading: 1, timestamp: DateTime.now(),
  );
  Position get currentLocation => _currentLocation;


 Future<void> checkIfLocationPermissionGranted()async {
  LocationPermission permission;
 permission = await Geolocator.checkPermission();
  while (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // // Permissions are denied, next time you could try
      // // requesting permissions again (this is also where
      // // Android's shouldShowRequestPermissionRationale 
      // // returned true. According to Android guidelines
      // // your App should show an explanatory UI now.
await Geolocator.openAppSettings();
      // return Future.error('Location permissions are denied');
     permission = await Geolocator.checkPermission();
    }
  }
  
  while (permission == LocationPermission.deniedForever) {
  await Geolocator.openAppSettings();

  permission = await Geolocator.checkPermission();
    // Permissions are denied forever, handle appropriately. 
      //  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // return Future.error(
    //   'Location permissions are permanently denied, we cannot request permissions.');
  } 
 }

  Future<Position> locateUser() async {
     
 

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future getUserLocation() async {
    _currentLocation = await locateUser();
    var currentAddresses = await placemarkFromCoordinates(_currentLocation.latitude, _currentLocation.longitude);
    _address = currentAddresses.first;
    update();
  }
}
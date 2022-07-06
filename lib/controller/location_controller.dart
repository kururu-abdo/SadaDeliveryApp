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
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
const MapQuestApiKey = "flxvxk8OeJpjj2XgUKXsHf4EoVA0FPmA";


  Future<String?> getRoutePoints(LatLng l1, LatLng l2) async {
   try {
      String url =
        "https://api.mapbox.com/directions/v5/mapbox/driving/${l1.longitude}%2C${l1.latitude}%3B${l2.longitude}%2C${l2.latitude}.json?access_token=pk.eyJ1Ijoia3VydXJ1OTUiLCJhIjoiY2xnMDJrdXQyMHY5czNmcXIwYjBrNTQ5eSJ9.7hnTg_6arvwiMYY5jOCoUg";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    print(values.toString()); 
    var waypoints = values["routes"][0]["geometry"];
    print("WAYPOINTS "+waypoints.toString());
    // var points =
    //     waypoints.map((point) => WayPoints.fromJson(point)).toList().toString();
    return waypoints;
   } catch (e) {
     print(e.toString());
   }
  }


List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  


double calculateDistance(lat1, lon1,

 lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + 
          c(lat1 * p) * c(lat2 * p) * 
          (1 - c((lon2 - lon1) * p))/2;

    var distance=
          double.parse(
           (12742 * asin(sqrt(a))).toStringAsFixed(2)
          );
    return distance;
  }




 List decodePoly(String poly) {
   dev.log(poly);
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }


class WayPoints {
  double? lat;
  double? lon;

  WayPoints.fromJson(Map<String, dynamic> jsonMap) {
    lat = jsonMap["location"][0];
    lon = jsonMap["location"][1];
  }
}
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

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

String timeUntil(DateTime date ,String locale) {
  return timeago.format(date, locale: locale, allowFromNow: true);
}

bool isTablet(BuildContext context){
  return MediaQuery.of(context).size.width>=450;
}
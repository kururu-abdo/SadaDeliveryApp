import 'package:flutter/material.dart';
import 'package:joseeder_delivery_boy/data/model/response/language_model.dart';
import 'package:joseeder_delivery_boy/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}

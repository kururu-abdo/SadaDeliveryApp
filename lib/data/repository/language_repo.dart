import 'package:flutter/material.dart';
import 'package:eamar_delivery/data/model/response/language_model.dart';
import 'package:eamar_delivery/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstants.languages;
  }
}

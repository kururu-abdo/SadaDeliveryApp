
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/data/api/api_checker.dart';
import 'package:eamar_delivery/data/model/response/userinfo_model.dart';
import 'package:eamar_delivery/data/repository/profile_repo.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileRepo? profileRepo;

  ProfileController({@required this.profileRepo});


  UserInfoModel? _userInfoModel;

  UserInfoModel get userInfoModel => _userInfoModel!;

  getUserInfo(BuildContext context) async {
    Response _response = await profileRepo!.getUserInfo();
    if (_response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(_response.body);
    } else {
      ApiChecker.checkApi(_response);
    }
    update();
  }


}
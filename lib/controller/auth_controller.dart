import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eamar_delivery/data/api/api_checker.dart';
import 'package:eamar_delivery/data/model/response/profile_model.dart';
import 'package:eamar_delivery/data/model/response/response_model.dart';
import 'package:eamar_delivery/data/model/response/userinfo_model.dart';
import 'package:eamar_delivery/data/repository/auth_repo.dart';
import 'package:eamar_delivery/view/base/custom_snackbar.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo? authRepo;
  AuthController({@required this.authRepo}) ;

  bool _isLoading = false;
  final bool _notification = true;
  UserInfoModel? _profileModel;
  XFile? _pickedFile;
  // for login section
  final String _loginErrorMessage = '';
  String get loginErrorMessage => _loginErrorMessage;


  bool get isLoading => _isLoading;
  bool get notification => _notification;
  UserInfoModel? get profileModel => _profileModel!;
   UserInfoModel?  profileModel2 ;
  XFile get pickedFile => _pickedFile!;

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo!.login(email, password);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo!.saveUserToken(response.body['token']);

      await authRepo!.updateToken();
      responseModel = ResponseModel(true, 'successful');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getProfile() async {
    Response response = await authRepo!.getProfileInfo();
    if (response.statusCode == 200) {
      _profileModel = UserInfoModel.fromJson(response.body);
      profileModel2= UserInfoModel.fromJson(response.body);
// profileModel2 =  UserInfoModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }



  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }

  Future<bool> changePassword(ProfileModel updatedUserModel, String password) async {
    _isLoading = true;
    update();
    bool isSuccess;
    Response response = await authRepo!.changePassword(updatedUserModel, password);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = response.body["message"];
      showCustomSnackBar(message, isError: false);
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
      isSuccess = false;
    }
    update();
    return isSuccess;
  }


  Future<void> updateToken() async {
    await authRepo!.updateToken();
  }


  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }


  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authRepo!.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo!.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo!.saveUserNumberAndPassword(number, password);
  }


  String getUserEmail() {
    return authRepo!.getUserEmail() ?? "";
  }

  String getUserPassword() {
    return authRepo!.getUserPassword() ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo!.clearUserNumberAndPassword();
  }


  String getUserToken() {
    return authRepo!.getUserToken();
  }


  void initData() {
    _pickedFile = null;
  }

}
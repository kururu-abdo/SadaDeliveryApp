
import 'package:get/get.dart';
import 'package:joseeder_delivery_boy/controller/splash_controller.dart';
import 'package:joseeder_delivery_boy/view/base/custom_snackbar.dart';
import 'package:joseeder_delivery_boy/view/screens/auth/login_screen.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<SplashController>().removeSharedData();
      // ignore: prefer_const_constructors
      Get.to(() => LoginScreen());
    }else {
      showCustomSnackBar(response.statusText);
    }
  }
}
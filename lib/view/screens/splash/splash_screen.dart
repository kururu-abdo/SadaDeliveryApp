import 'dart:async';
import 'dart:developer';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/controller/auth_controller.dart';
import 'package:eamar_delivery/controller/order_controller.dart';
import 'package:eamar_delivery/controller/splash_controller.dart';
import 'package:eamar_delivery/utill/app_constants.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/images.dart';
import 'package:eamar_delivery/utill/styles.dart';
import 'package:eamar_delivery/view/screens/auth/login_screen.dart';
import 'package:eamar_delivery/view/screens/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<ConnectivityResult>? _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
    bool _firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!_firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection' : 'connected',
            textAlign: TextAlign.center,
          ),
        ));
        if(!isNotConnected) {
          _route();
        }
      }
      _firstTime = false;
    });

    Get.find<SplashController>().initSharedData();
    _route();

  }

  @override
  void dispose() {
    super.dispose();

    _onConnectivityChanged!.cancel();
  }

  void _route() {
    Get.find<SplashController>().getConfigData().then((isSuccess) {
      if(isSuccess) {
        Timer(const Duration(seconds: 1), () async {
          if (Get.find<AuthController>().isLoggedIn()) {
            log('I AM LODDED');
            Get.find<AuthController>().updateToken();
            await Get.find<AuthController>().getProfile();
            Get.find<OrderController>().getAllOrders(context);
            Get.find<OrderController>().getAllOrderHistory(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const DashboardScreen(pageIndex: 0,)));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(Images.splashLogo,
            height: 200,
            
            
             width: 200),
            const SizedBox(height: Dimensions.paddingSizeDefault),
        //    Text(AppConstants.appName, style: rubikRegular.copyWith(fontSize: 25,color: Colors.white), textAlign: TextAlign.center),

          ]),
        ),
      ),
    );
  }
}
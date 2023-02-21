import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:eamar_delivery/theme/dark_theme.dart';
import 'package:eamar_delivery/theme/light_theme.dart';
import 'package:eamar_delivery/utill/app_constants.dart';
import 'package:eamar_delivery/utill/messages.dart';
import 'package:eamar_delivery/view/screens/splash/splash_screen.dart';
import 'controller/localization_controller.dart';
import 'controller/splash_controller.dart';
import 'controller/theme_controller.dart';
import 'helper/get_di.dart' as di;
import 'package:url_strategy/url_strategy.dart';
import 'helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Map<String, Map<String, String>> _languages = await di.init();
  try {
    if (GetPlatform.isMobile) {
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }catch(e) {
    debugPrint('');
  }
  runApp(MyApp(languages: _languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({Key key, @required this.languages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return  GetMaterialApp(
            title: AppConstants.appName,
             builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            theme: themeController.darkTheme ? dark : light,
            locale: localizeController.locale,
            translations: Messages(languages: languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
            // ignore: prefer_const_constructors
            home: SplashScreen(),
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),
          );
        });
      });
    });
  }
}
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:eamar_delivery/utill/locale_message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:eamar_delivery/theme/dark_theme.dart';
import 'package:eamar_delivery/theme/light_theme.dart';
import 'package:eamar_delivery/utill/app_constants.dart';
import 'package:eamar_delivery/utill/messages.dart';
import 'package:eamar_delivery/view/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/localization_controller.dart';
import 'controller/splash_controller.dart';
import 'controller/theme_controller.dart';
import 'helper/get_di.dart' as di;
import 'package:url_strategy/url_strategy.dart';
import 'helper/get_di.dart';
import 'helper/notification_helper.dart';
import 'package:timeago/timeago.dart' as timeago;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


int id = 0;

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';
// const String darwinNotificationCategoryText = 'textCategory';

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function


const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';


String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';



@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}







 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


Future<void> main() async {
  setPathUrlStrategy();
    
  WidgetsFlutterBinding.ensureInitialized();
  // await di.initDependencies();
    HttpOverrides.global = MyHttpOverrides();
    
  await Firebase.initializeApp();



  Map<String, Map<String, String>> _languages = await di.init();
  
//     var mainBindings = MainBindings();
// await mainBindings.dependencies();

await di.dependencies();
log('BINDED');
  
  timeago.setLocaleMessages('en', CustomEnMessage());
  timeago.setLocaleMessages('ar', CustomArMessage());

  
  try {
    if (GetPlatform.isMobile) {
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }catch(e) {
  log(e.toString());
  }

  // runApp(MyApp(languages: _languages));
  runApp(MyApp2(languages: _languages));
}
class MyApp2 extends StatefulWidget {
   final Map<String, Map<String, String>>? languages;
  const MyApp2({super.key, this.languages});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  log(Get.find<SharedPreferences>().getKeys().toString());

  }
  @override
  Widget build(BuildContext context) {
    return 
     GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return 
          
           GetMaterialApp(
            title: AppConstants.appName,

            
             builder: (context, child) => ResponsiveBreakpoints.builder(
         child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
            
          
          ),
           
           
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            theme: themeController.darkTheme ? dark : light,
            locale: localizeController.locale,
            translations: Messages(languages: widget.languages!),
            fallbackLocale: Locale(AppConstants.languages[1].languageCode!, AppConstants.languages[1].countryCode),
            // ignore: prefer_const_constructors
            home: SplashScreen(),
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),


            // initialBinding: di.init(),
          );
        });
      });
    });
 
  }
}
class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  const MyApp({Key? key, @required this.languages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return  GetMaterialApp(
            title: AppConstants.appName,
             builder: (context, child) => ResponsiveBreakpoints.builder(
         child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
            
          
          ),
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            theme: themeController.darkTheme ? dark : light,
            locale: localizeController.locale,
            translations: Messages(languages: languages!),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
            // ignore: prefer_const_constructors
            home: SplashScreen(),
            defaultTransition: Transition.topLevel,
            transitionDuration: const Duration(milliseconds: 500),


            // initialBinding: di.init(),
          );
        });
      });
    });
 
  }
}
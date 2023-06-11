import 'package:eamar_delivery/controller/auth_controller.dart';
import 'package:eamar_delivery/controller/splash_controller.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/images.dart';
import 'package:eamar_delivery/view/screens/auth/login_screen.dart';
import 'package:eamar_delivery/view/screens/html/html_viewer_screen.dart';
import 'package:eamar_delivery/view/screens/language/choose_language_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/controller/order_controller.dart';
import 'package:eamar_delivery/helper/notification_helper.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:eamar_delivery/view/screens/home/home_screen.dart';
import 'package:eamar_delivery/view/screens/order/order_history_screen.dart';
import 'package:eamar_delivery/view/screens/profile/profile_screen.dart';

import '../../../main.dart';

class DashboardScreen extends StatefulWidget {
  final int? pageIndex;
   const DashboardScreen({Key? key, @required this.pageIndex}) : super(key: key);
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  List<Widget>? _screens;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
Widget? mainPage;
  @override
  void initState() {
    super.initState();
    Get.find<OrderController>().currentOrders;

    mainPage= HomeScreen(
      advancedDrawerController: _advancedDrawerController,
      handleMenuePressed: _handleMenuButtonPressed,
    );
    _screens = [
      HomeScreen(),
      OrderHistoryScreen(),
      const ProfileScreen(),
    ];


    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    
    
    
    
   final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ],
  );



    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin!.initialize(initializationsSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("onMessage: ${message.data}");
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin!, false);
      Get.find<OrderController>().getAllOrders(context);
      Get.find<OrderController>().getAllOrderHistory(context);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("onMessageOpenedApp: ${message.data}");
      Get.find<OrderController>().getAllOrders(context);
      Get.find<OrderController>().getAllOrderHistory(context);
    });

  }
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
   
   
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Theme.of(context).primaryColor,
            
            
            
             Colors.blueGrey.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child:mainPage!,
      
      //  Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Advanced Drawer Example'),
      //     leading: IconButton(
      //       onPressed: _handleMenuButtonPressed,
      //       icon: ValueListenableBuilder<AdvancedDrawerValue>(
      //         valueListenable: _advancedDrawerController,
      //         builder: (_, value, __) {
      //           return AnimatedSwitcher(
      //             duration: Duration(milliseconds: 250),
      //             child: Icon(
      //               value.visible ? Icons.clear : Icons.menu,
      //               key: ValueKey<bool>(value.visible),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //   ),
      //   body: Container(),
      // ),
    
    
    
    
    
    
    
      drawer: SafeArea(
        child: Container(
          padding: 
          
          EdgeInsets.only(
            left: 15 , right: 15
          ),
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
Align(
  alignment: Alignment.centerLeft,
  child:   Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: (){
        _advancedDrawerController.hideDrawer();
      },
      child: Container(
        width: 40,height: 40 ,
    
        decoration: BoxDecoration(
    
    borderRadius: BorderRadius.circular(8),
          color:
           Theme.of(context).primaryColor,
    
    
           boxShadow: [
    
            BoxShadow(
              blurRadius: 6,
              color: Color(0xFFF000000).withOpacity(.31),
              offset: Offset(0, 1)
            )
          
           ]
        ),
    
        child: Center(
          child:Icon(
            Icons.clear,
            color: Colors.white , 
          ), 
        ),
      ),
    ),
  ),
),
                
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 128.0,
                      height: 128.0,
                      margin: const EdgeInsets.only(
                        top: 24.0,
                        bottom: 10.0,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle,
                      ),
                      child: 
                      Get.find<AuthController>().profileModel2 != null?

                      Image.network('${Get.find<SplashController>().baseUrls!.reviewImageUrl}/delivery-man/${Get.find<AuthController>().profileModel.image}')
                      :
                      Image.asset(Images.placeholder)
                      
                      
                      ,
                    ),
               Text(Get.find<AuthController>().profileModel.fName != null
               ?
                '${Get.find<AuthController>().profileModel.fName ?? ''} ${Get.find<AuthController>().profileModel.lName ?? ''}'
                    : "",
                style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: Dimensions.fontSizeDefault, color: 
                
                Colors.white
                ),

                
              )

,



           Text(Get.find<AuthController>().profileModel.phone != null
               ? '${Get.find<AuthController>().profileModel.phone ?? ''} '
                    : "",
                style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: Dimensions.fontSizeDefault, color: 
                
                Colors.white
                ),

                
              )

                  ],
                ),



SizedBox(height: 50,),

                ListTile(
                  onTap: () {


                    mainPage= HomeScreen(
      advancedDrawerController: _advancedDrawerController,
      handleMenuePressed: _handleMenuButtonPressed,
    );
setState(() {
  
});
  _advancedDrawerController.hideDrawer();

                  },
                  leading: Icon(Icons.home),
                  title: Text('home'.tr),
                ),
                ListTile(
                  onTap: () {
 mainPage= OrderHistoryScreen(
      advancedDrawerController: _advancedDrawerController,
      handleMenuePressed: _handleMenuButtonPressed,
    );
setState(() {
  
});
  _advancedDrawerController.hideDrawer();




                  },
                  leading: Icon(Icons.history),
                  title: Text(

                     'order_history'.tr,
                  ),
                ),
                ListTile(
                  onTap: () {

                    mainPage =  ChooseLanguageScreen(
                    handleMenuePressed: _handleMenuButtonPressed,
                    
                    advancedDrawerController: _advancedDrawerController!,
                    fromHomeScreen: false);
                    setState(() {
                      
                    });

                    _advancedDrawerController.hideDrawer();
                  },
                  leading: Icon(Icons.language),
                  title: Text(

                     'change_language'.tr,
                  ),
                ),
                 ListTile(
                  onTap: () {
mainPage =     HtmlViewerScreen(isPrivacyPolicy: false ,
 handleMenuePressed: _handleMenuButtonPressed,
                    
                    advancedDrawerController: _advancedDrawerController,



);
 setState(() {
                      
                    });

                    _advancedDrawerController.hideDrawer();

                      




                  },
                  leading: Icon(Icons.list),
                  title: Text('terms_and_condition'.tr),
                ),
                 ListTile(
                  onTap: () {

                    mainPage =     HtmlViewerScreen(isPrivacyPolicy: true ,
 handleMenuePressed: _handleMenuButtonPressed,
                    
                    advancedDrawerController: _advancedDrawerController,



);
 setState(() {
                      
                    });

                    _advancedDrawerController.hideDrawer();
                  },
                  leading: Icon(Icons.privacy_tip),
                  title: Text('privacy_policy'.tr),
                ),
                
               
               
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child:

                    
                    
                    
                    
                    
                    TextButton.icon(onPressed: (){
 Get.find<AuthController>().clearSharedData().then((condition) {
                          Navigator.pop(context);
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  LoginScreen()),
                           (route) => false);
                        });

                    }, icon: Icon(
                      Icons.logout ,color: Colors.white,
                    ), label: Text('logout'.tr ,
                    
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ))
                    
                    //  Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
   
   
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorResources.colorGrey,
          backgroundColor: Theme.of(context).cardColor,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Icons.home, 'home'.tr, 0),
            _barItem(Icons.history, 'order_history'.tr, 1),
            _barItem(Icons.person, 'profile'.tr, 2),
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens![index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: index == _pageIndex ? Theme.of(context).primaryColor : ColorResources.colorGrey, size: 20),
      label: label,
    );
  }
void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}

import 'dart:developer';

import 'package:eamar_delivery/view/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/controller/auth_controller.dart';
import 'package:eamar_delivery/controller/location_controller.dart';
import 'package:eamar_delivery/controller/order_controller.dart';
import 'package:eamar_delivery/controller/splash_controller.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/images.dart';
import 'package:eamar_delivery/view/screens/home/widget/order_widget.dart';
import 'package:eamar_delivery/view/screens/language/choose_language_screen.dart';

class HomeScreen extends StatelessWidget {
  final AdvancedDrawerController? advancedDrawerController;
  final Function? handleMenuePressed;
  HomeScreen({Key? key, this.advancedDrawerController, this.handleMenuePressed}) : super(key: key);
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();


  Future<void> _loadData(BuildContext context) async {
    await Get.find<OrderController>().getAllOrders(context);
        await Get.find<LocationController>().checkIfLocationPermissionGranted();
    await Get.find<LocationController>().getUserLocation();
  }


  @override
  Widget build(BuildContext context) {
    _loadData(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          // leadingWidth: 0,
        
        
          actions: [

                    
                    TextButton(onPressed: (){
 Get.find<AuthController>().clearSharedData().then((condition) {
                          Navigator.pop(context);
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  LoginScreen()),
                           (route) => false);
                        });

                    },
                    
                    child: 
                     Text('logout'.tr ,
                    
                    style: TextStyle(
                      color: Colors.white
                    ),
                    )
                    
                    ,
                    //  icon: Icon(
                    //   Icons.logout ,color: Colors.white,
                    // ), label: Text('logout'.tr ,
                    
                    // style: TextStyle(
                    //   color: Colors.white
                    // ),
                    // )
                    
                    )
                    
            // Get.find<OrderController>().currentOrders.isNotEmpty
            //       ? IconButton(
            //           icon: Icon(Icons.refresh, color: Colors.white),
            //           onPressed: () {Get.find<OrderController>().orderRefresh(context);}):const SizedBox.shrink(),

            // PopupMenuButton<String>(
            //   onSelected: (value) {
            //     switch (value) {
            //       case 'language':
            //        Navigator.of(context).push(MaterialPageRoute(builder: (_) =>  
            //         ChooseLanguageScreen(
            //         handleMenuePressed: handleMenuePressed,
                    
            //         advancedDrawerController: advancedDrawerController!,
            //         fromHomeScreen: true)
            //         )
                    
            //         );
            //     }
            //   },
            //   icon: Icon(
            //     Icons.more_vert_outlined,
            //     color: Colors.white,
            //   ),
            //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            //     PopupMenuItem<String>(
            //       value: 'language',
            //       child: Row(
            //         children: [
            //           Icon(Icons.language, color: Theme.of(context).textTheme.bodyText1!.color),
            //           const SizedBox(width: Dimensions.paddingSizeLarge),
            //           Text('change_language'.tr, style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // )
         
         
         
         
          ],
          leading: 
         
      IconButton(
            onPressed: (){
              log('PRESSED');
              handleMenuePressed!();
            },
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: advancedDrawerController!,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
         
         
      ),
          
          
          
          title:
          Text('home'.tr) , centerTitle: true,
          
          
          
          //  Get.find<AuthController>().profileModel != null
          //     ? Row(
          //   children: [
          //     Container(
          //       width: 40,
          //       height: 40,
          //       decoration: const BoxDecoration(shape: BoxShape.circle),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(20),
          //         child: FadeInImage.assetNetwork(
          //           imageErrorBuilder: (c,o,s) =>Image.asset(Images.placeholder),
          //           placeholder: Images.placeholder,

          //           fit: BoxFit.fill,
          //           image: '${Get.find<SplashController>().baseUrls!.reviewImageUrl}/delivery-man/${Get.find<AuthController>().profileModel.image}',
          //         ),
          //       ),
          //     ),
          //     const SizedBox(width: 10),
          //     Text(Get.find<AuthController>().profileModel.fName != null
          //           ? '${Get.find<AuthController>().profileModel.fName ?? ''} ${Get.find<AuthController>().profileModel.lName ?? ''}'
          //           : "",
          //       style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).textTheme.bodyText1!.color),
          //     )
          //   ],
          // )
          //     : const SizedBox.shrink(),





        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child:  GetBuilder<OrderController>(builder: (orderController) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('active_order'.tr, style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                const SizedBox(height: 10),
                Expanded(child: RefreshIndicator(
                  child:
                  
!orderController.isLoading?                  
                  //  orderController.currentOrders != null ?
                   orderController.currentOrders.isNotEmpty ?


                    ListView.builder(
                    itemCount: orderController.currentOrders.length,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (context, index) => 
                    OrderWidget(orderModel: orderController.currentOrders[index], index: index,),
                  ) : Center(child: Text('no_order_found'.tr, style: Theme.of(context).textTheme.headline3,),
                  ) 
                  : 
                  
                  
                  Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor),),



                  key: _refreshIndicatorKey,
                  displacement: 0,
                  color: ColorResources.colorWhite,
                  backgroundColor: Theme.of(context).primaryColor,
                  onRefresh: () {
                    return orderController.orderRefresh(context);
                  },
                ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }


  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // advancedDrawerController!.value = AdvancedDrawerValue.visible();

    try {
      handleMenuePressed!();
    advancedDrawerController!.showDrawer();
    log('sHOWING');
    } catch (e) {
      log(e.toString());
    }
  }
 

}

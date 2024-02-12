import 'dart:developer';

import 'package:eamar_delivery/controller/localization_controller.dart';
import 'package:eamar_delivery/utill/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/controller/order_controller.dart';
import 'package:eamar_delivery/helper/date_converter.dart';
import 'package:eamar_delivery/helper/price_converter.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/styles.dart';

import 'order_details_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
    final AdvancedDrawerController? advancedDrawerController;
  final Function? handleMenuePressed;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  OrderHistoryScreen({Key? key, this.advancedDrawerController, this.handleMenuePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   WidgetsBinding.instance.addPostFrameCallback((_){


 Get.find<OrderController>().getAllOrderHistory(context);
   });
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
        // leading: const SizedBox.shrink(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,


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
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  size: isTablet(context)? 30:24,
                  ),
                );
              },
            ),
         
         
      ),
       





        title: Text('order_history'.tr, 
        
        style:
         TextStyle(
          fontSize: isTablet(context)?24:18 ,
          color: Colors.white
        )
        //  Theme.of(context).textTheme.headline3!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color, fontSize: Dimensions.fontSizeLarge),
         
         
         
         ),
      ),
        body: GetBuilder<OrderController>(builder: (orderController) {
          return
         !orderController.isHistoryLoading?  
          
           orderController.allOrderHistory != null ?
          
           orderController.allOrderHistory.isNotEmpty
              ? 
              
              
              RefreshIndicator(
            onRefresh: () => orderController.orderRefresh(context),
            displacement: 20,
            color: ColorResources.colorWhite,
            backgroundColor: Theme.of(context).primaryColor,
            key: _refreshIndicatorKey,
            child: 
            orderController.allOrderHistory.isNotEmpty
                ?
                 ListView.builder(
                itemCount: orderController.allOrderHistory.length,
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModel: orderController.allOrderHistory[index], index: index)));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).shadowColor.withOpacity(.5), spreadRadius: 1, blurRadius: 2, offset: const Offset(0, 1))
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${'order_id'.tr} #${orderController.allOrderHistory[index].id}',
                                    style:
                                    rubikMedium.copyWith(fontSize: 
                                    
                                    isTablet(context)? 20:
                                    
                                    Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text('amount'.tr, style: rubikRegular.copyWith(
                                  fontSize:
                                  isTablet(context)? 20:  Dimensions.fontSizeSmall,
                                  
                                  
                                  color: Theme.of(context).textTheme.bodyLarge!.color)),
                              ],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Row(
                                children: [
                                  Text('status'.tr, style: rubikRegular.copyWith(
                                     fontSize:
                                  isTablet(context)? 20:  Dimensions.fontSizeSmall,
                                    
                                    
                                    color: Theme.of(context).textTheme.bodyLarge!.color)),
                                  Text(orderController.allOrderHistory[index].orderStatus!.tr,
                                      style: rubikMedium.copyWith(
                                        
                                         fontSize:
                                  isTablet(context)? 20:  Dimensions.fontSizeSmall,
                                        color: Theme.of(context).primaryColor)),
                                ],
                              ),
                              Text(PriceConverter.convertPrice(orderController.allOrderHistory[index].orderAmount!),
                                  style: rubikMedium.copyWith(color: 
                                  Colors.red,
                                  // Theme.of(context)
                                 fontSize:
                                  isTablet(context)? 20:  Dimensions.fontSizeSmall,
                                  
                                  )),
                            ]),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Row(children: [
                              Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyLarge!.color)),
                              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                              Text(
                                // '${'order_at'.tr} ${DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderController.allOrderHistory[index].updatedAt!))
                                // }'
                                
                                 '${'order_at'.tr}:   ${timeUntil(DateTime.parse(orderController.allOrderHistory[index].updatedAt!) ,
                                 
                                 Get.find<LocalizationController>().locale.languageCode)}'
                                //  ${DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderController.allOrderHistory[index].updatedAt!))
                                
                                
                                ,
                                style: rubikRegular.copyWith(fontSize: 
                                
                                
                               
                                  isTablet(context)? 20:  
                                
                                Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
                              ),
                            ]),
                          ]),
                        ),
                      ]),
                    ]),
                  ),
                ))
                : Center(child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Text('no_data_found'.tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor),),
            ),
            ),
          ) : Center(child: Text('no_history_available'.tr, style: Theme.of(context).textTheme.displaySmall,
          )) :
          
           Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
           :

                      Center(child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))


           
           
           
           ;
        }

        ));
  }
}

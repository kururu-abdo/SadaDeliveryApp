import 'dart:developer';

import 'package:eamar_delivery/utill/utils.dart';
import 'package:eamar_delivery/view/screens/track/track_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/controller/localization_controller.dart';
import 'package:eamar_delivery/controller/location_controller.dart';
import 'package:eamar_delivery/data/model/response/order_model.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/images.dart';
import 'package:eamar_delivery/view/base/custom_button.dart';
import 'package:eamar_delivery/view/screens/order/order_details_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel? orderModel;
  final int? index;
  const OrderWidget({Key? key, this.orderModel, @required this.index}) : super(key: key);


loadLocation()async{

   await Get.find<LocationController>().getUserLocation();
}
  @override
  Widget build(BuildContext context) {
    loadLocation();

    log(
    '${orderModel!.shippingAddress!.latitude   }   ${orderModel!.shippingAddress!.longitude   }'
    );
    return

 Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      
      child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(

scrollDirection: Axis.horizontal,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('order_id'.tr, style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
                      ),
                      Text(
                        ' # ${orderModel!.id.toString()}',
                        style: Theme.of(context).textTheme.headline3!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ],
                  ),
                  
                  
                   Row(
                    mainAxisSize: MainAxisSize.min,
                children: [
                      
                      
                TextButton.icon(onPressed: 
                
                (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModel: orderModel!, index: index!)));
                      
                }, icon: Icon(Icons.more_horiz ,
                
                     color: Theme.of(context).textTheme.bodyText1!.color,
                
                ), label: Text('view_details'.tr ,
                
                
                style: TextStyle(
                      
                  color: Theme.of(context).primaryColor
                ),
                
                
                ))
                
              
              
              ,
                      
                TextButton.icon(onPressed: 
                
                (){
                      
                      
                      if(orderModel!.shippingAddress!.latitude ==null
                      || orderModel!.shippingAddress!.latitude==""||
                      orderModel!.shippingAddress!.longitude ==null
                      || orderModel!.shippingAddress!.longitude==""
                      
                      
                      ){
                      
                      
                      
                      }else {
                      Navigator.of(context)

                      .push(
                        
                        MaterialPageRoute(builder: 
                        (_)=> TrackPage(
                          orderId: orderModel!.id,
title: 
orderModel!.shippingAddress!.address!, 

source: 

LatLng(
  
    Get.find<LocationController>().currentLocation.latitude ?? 23.9103 ,
        Get.find<LocationController>().currentLocation.longitude ?? 23.9103 ,


  )


 , destination:
 
 LatLng(
   double.parse(orderModel!.shippingAddress!.latitude!) ?? 23.8103,
   double.parse(orderModel!.shippingAddress!.longitude!) ?? 90.4125) , 

                        )
                        )
                      );
                      

                  //  if (GetPlatform.isIOS) {
                      
                      
                      
                      
                      
                  //                  MapUtils.openAppleMap(
                  //                   // 18.518496,73.879259,18.519513,73.868315
                  //                 double.parse(orderModel!.shippingAddress!.latitude!) ?? 23.8103,
                  //                 double.parse(orderModel!.shippingAddress!.longitude!) ?? 90.4125,
                  //                  Get.find<LocationController>().currentLocation.latitude ?? 23.9103,
                  //                 Get.find<LocationController>().currentLocation.longitude ?? 90.8125
                                  
                  //                 );
                      
                  //             }else {
                  //                  MapUtils.openMap(
                  //                 double.parse(orderModel!.shippingAddress!.latitude!) ?? 23.8103,
                  //                 double.parse(orderModel!.shippingAddress!.longitude!) ?? 90.4125,
                  //                  Get.find<LocationController>().currentLocation.latitude ?? 23.9103,
                  //                  Get.find<LocationController>().currentLocation.longitude ?? 90.8125);
                      
                  //            }
                      
                      }
                         
                      
                      
                      
                }, icon: Icon(Icons.location_on
                
                ,
                      
                     color: Theme.of(context).textTheme.bodyText1!.color,
                
                ), label: Text('direction'.tr
                
                
                ,
                      
                      
                      
                  style: TextStyle(
                      
                  color: Theme.of(context).primaryColor
                )
                
                
                
                
                ))
                
              
              
                ],
              )
               
                ],
              ),
            ),
          ),
         
         
         
          const SizedBox(height: 10),


          Row(

            children: [

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                      Image.asset(Images.location, color: Theme.of(context).textTheme.bodyText1!.color, width: 15, height: 20),
SizedBox(width: 10,),
                  Text(
                    '${'address'.tr}: '
                  )
                ],
              ) ,
SizedBox(width: 10,),


  SizedBox(
                width: 120,
                child: Text(' ${orderModel!.shippingAddress!.address ?? ''} ${orderModel!.shippingAddress!.city ?? ''   ?? ''} ${orderModel!.shippingAddress!.country ?? ''}' ?? 'Address not found',
              

              overflow: TextOverflow.ellipsis,   
                 
                 
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              )


            ],
          )





,

     
          const SizedBox(height: 10),


          Row(

            children: [

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                      SizedBox(

                        width: 15, height: 20,
                        child: Icon(Icons.near_me, 
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        // size: 20,
                        
                        ),
                      ),
SizedBox(width: 10,),
                  Text(
                    '${'distance'.tr}: '
                  )
                ],
              ) ,
SizedBox(width: 10,),


  SizedBox(
                width: 120,
                child: Text(
                orderModel==null||
                orderModel!.shippingAddress!.latitude==''||
                orderModel!.shippingAddress!.latitude==null
                ||
                
                 orderModel!.shippingAddress!.longitude==null
                ||
                 double.parse(orderModel!.shippingAddress!.longitude!)
                 .isNaN
                ?
                'unknown'.tr
                :

'${calculateDistance(

double.parse(orderModel!.shippingAddress!.latitude .toString()), 
double.parse(orderModel!.shippingAddress!.longitude .toString()), 

double.parse(Get.find<LocationController>().currentLocation.latitude .toString()),

double.parse(Get.find<LocationController>().currentLocation.longitude .toString()),

)}'+' ${'km'.tr}'
                ,
              

              overflow: TextOverflow.ellipsis,   
                 
                 
                  style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              )


            ],
          )


 ,
SizedBox(
  height: 10,
)
, 


Row(

  children: [
Row(
  mainAxisSize: MainAxisSize.min,
  children: [

                          Image.asset(
                            'assets/icon/status1.png'
                            
                            // Images.location
                          
                          
                          , 
                          color: Theme.of(context).textTheme.bodyText1!.color,
                           width: 15,
                          height: 20
                           
                           ),
SizedBox(width: 10,),
                  Text(
                    '${'status'.tr} '
                  )
  ],
)

,
SizedBox(width: 10,),


     Text(orderModel!.orderStatus!.tr, 
     
                     style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),

      
      
      ),



  ],
)


],

      ),

 );




    
     Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Theme.of(context).shadowColor.withOpacity(.5), spreadRadius: 1, blurRadius: 1, offset: const Offset(0, 1))],
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      
      
      
      child: Column(
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('order_id'.tr, style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                  Text(
                    ' # ${orderModel!.id.toString()}',
                    style: Theme.of(context).textTheme.headline3!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none, 
                children: [
                  Container(),
                  Get.find<LocalizationController>().isLtr
                      ? 
                      Positioned(
                          right:-10,
                          top: -23,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.paddingSizeSmall),
                                    bottomLeft: Radius.circular(Dimensions.paddingSizeSmall))),
                            child:
                             Text(orderModel!.orderStatus!.tr, style: Theme.of(context).textTheme.headline1!.copyWith(color: Theme.of(context).primaryColorDark, fontSize: Dimensions.fontSizeSmall),),
                          ),
                        )
                      : Positioned(
                          left: -10,
                          top: -28,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.paddingSizeSmall),
                                    bottomLeft: Radius.circular(Dimensions.paddingSizeSmall))),
                            child: Text(orderModel!.orderStatus!.tr, style: Theme.of(context).textTheme.headline1
                                  !.copyWith(color: Theme.of(context).primaryColorDark, fontSize: Dimensions.fontSizeSmall),
                            ),
                          ),
                        )
                ],
              ),
            ],
          ),
         
         
         
          const SizedBox(height: 25),
          Row(
            children: [
              Image.asset(Images.location, color: Theme.of(context).textTheme.bodyText1!.color, width: 15, height: 20),
              const SizedBox(width: 10),
              orderModel!.shippingAddress!=null?
              Expanded(
                  child: Text(' ${orderModel!.shippingAddress!.address ?? ''} ${orderModel!.shippingAddress!.city ?? ''}  ${orderModel!.shippingAddress!.zip ?? ''} ${orderModel!.shippingAddress!.country ?? ''}' ?? 'Address not found',
                style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).textTheme.bodyText1!.color),
              )):const SizedBox(),
            ],
          ),
          const SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: CustomButton(
                btnTxt: 'view_details'.tr,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModel: orderModel!, index: index!)));
                },
                isShowBorder: true,
              )),
              const SizedBox(width: 25),
              GetBuilder<LocationController>(
                builder: (locationController) => Expanded(
                    child:orderModel!.shippingAddress != null? CustomButton(
                        btnTxt: 'direction'.tr,
                        onTap: () {



                          if (GetPlatform.isIOS) {





                               MapUtils.openAppleMap(
                                // 18.518496,73.879259,18.519513,73.868315
                              double.parse(orderModel!.shippingAddress!.latitude!) ?? 23.8103,
                              double.parse(orderModel!.shippingAddress!.longitude!) ?? 90.4125,
                              locationController.currentLocation.latitude ?? 23.9103,
                              locationController.currentLocation.longitude ?? 90.8125
                              
                              );

                          }else {
                               MapUtils.openMap(
                              double.parse(orderModel!.shippingAddress!.latitude!) ?? 23.8103,
                              double.parse(orderModel!.shippingAddress!.longitude!) ?? 90.4125,
                              locationController.currentLocation.latitude ?? 23.9103,
                              locationController.currentLocation.longitude ?? 90.8125);

                         }
                       
                        }):const SizedBox()),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double destinationLatitude, double destinationLongitude, double userLatitude, double userLongitude) async {
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude'
        '&destination=$destinationLatitude,$destinationLongitude&mode=d';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

static Future<void> openAppleMap(double destinationLatitude, double destinationLongitude, double userLatitude, double userLongitude)async{
  String url = 'https://maps.apple.com/?saddr=$userLatitude,$userLongitude&daddr=$destinationLatitude,$destinationLongitude'; // I used 0,0 as latitude and longitude
if (await canLaunch(url)) {
  launch(url);
} else {
     throw 'Could not open the map.';
}
}



}

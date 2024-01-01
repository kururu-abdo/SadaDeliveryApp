import 'dart:math';
import 'dart:convert';
import 'package:eamar_delivery/controller/auth_controller.dart';
import 'package:eamar_delivery/utill/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:eamar_delivery/controller/localization_controller.dart';
import 'package:eamar_delivery/controller/order_controller.dart';
import 'package:eamar_delivery/controller/splash_controller.dart';
import 'package:eamar_delivery/controller/theme_controller.dart';
import 'package:eamar_delivery/controller/tracker_controller.dart';
import 'package:eamar_delivery/data/model/response/order_model.dart';
import 'package:eamar_delivery/helper/date_converter.dart';
import 'package:eamar_delivery/helper/price_converter.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/images.dart';
import 'package:eamar_delivery/utill/styles.dart';
import 'package:eamar_delivery/view/screens/order/widget/custom_divider.dart';
import 'package:eamar_delivery/view/screens/order/widget/delivery_dialog.dart';
import 'package:eamar_delivery/view/screens/order/widget/slider_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';


import 'order_place_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel? orderModel;
  final int? index;
  const OrderDetailsScreen({Key? key, this.orderModel, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>().getOrderDetails(orderModel!.id.toString(), context);
    double deliveryCharge = 0;
    deliveryCharge = orderModel!.shippingCost!;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon:  Icon(
            Icons.arrow_back_ios,
            color: Colors.white , 

            size: isTablet(context)?  30:24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('order_details'.tr,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            
            
            fontSize: 
            isTablet(context)? 30:
            
            Dimensions.fontSizeLarge, color: Colors.white),
        ),
      ),
      body: GetBuilder<OrderController>(
        builder: (orderController) {


          double itemsPrice = 0;
          double discount = 0;
          double tax = 0;
          if (orderController.orderDetails!=null) {
            for (var orderDetails in orderController.orderDetails!) {
              itemsPrice = itemsPrice + (orderDetails!.price * orderDetails.qty);
              discount = discount + orderDetails.discount;
              tax = tax + orderDetails.tax;
            }
          }
          double subTotal = itemsPrice + tax;
          double totalPrice = subTotal - discount + deliveryCharge - orderModel!.discountAmount!;

          return orderController.orderDetails != null
              ? 
              
              GetBuilder<AuthController>(
             
                builder: (profileController) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          children: [
                            Row(children: [
                              Expanded(
                                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('order_id'.tr, style: rubikRegular.copyWith(
                                      fontSize: isTablet(context)? 30:24,
                                      
                                      
                                      color: Theme.of(context).highlightColor)),
                                    Text(' # ${orderModel!.id}', style: rubikMedium.copyWith(
                                      
                                      fontSize: isTablet(context)? 30:24,
                                      color: Theme.of(context).highlightColor)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                     Icon(Icons.watch_later, size:isTablet(context)? 25: 17),
                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 2.0),
                                      child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderModel!.createdAt!)), maxLines: 1, overflow: TextOverflow.ellipsis, style: rubikRegular.copyWith(color: Theme.of(context).highlightColor,fontSize:
                                      isTablet(context)? 30:
                                      
                                       Dimensions.fontSizeExtraSmall)),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                            const SizedBox(height: 20),
Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Text('${'item'.tr}:', style: rubikRegular.copyWith(
                                    fontSize: isTablet(context)? 20:15,
                                    
                                    color: 
                                  Theme.of(context).highlightColor)),
                                  const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                  Text(orderController.orderDetails!.length.toString(), 
                                  style: rubikMedium.copyWith(
                                    fontSize: isTablet(context)? 20:15,
                                    
                                    color: Theme.of(context).primaryColor)),
                                ]),
                                orderModel!.orderStatus == 'processing' || orderModel!.orderStatus == 'out_for_delivery'
                                    ? Row(children: [
                                        Text('${'payment_status'.tr}:',
                                        
                                         style: rubikRegular.copyWith(
                                          fontSize: isTablet(context)? 20:15,
                                          
                                          color: Theme.of(context).highlightColor)),
                                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),




                                        Text(orderModel!.paymentStatus!.tr , style: rubikMedium.copyWith(color: 
                                        Theme.of(context).primaryColor, 

                                        fontSize: isTablet(context)? 20:15
                                        
                                        
                                        )),
                                      ])
                                    : const SizedBox.shrink(),
                              ],
                            ),
                         
                         
                         //   items
                            const Divider(height: 20),

                            SizedBox(
                              height:isTablet(context)? 300: 200,
                              
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: orderController.orderDetails!.length,
                                                              scrollDirection: Axis.horizontal,
                            
                                itemBuilder: (context, index) {
                                  return 
                                  
                            Center(
                              child:   Container(
                              margin: const EdgeInsets.all(
                                8
                              ),
                              height: 
                              isTablet(context)? 350:
                              
                              150, width:MediaQuery.of(context).size.width/3 ,
                              
                              decoration: BoxDecoration(
                              
                                border: Border.all(
                                  width: .5,color: Theme.of(context).primaryColor
                                )
                              ),

                              child: 
                              
                              Column(
                                children: [

SizedBox(
                                        height:isTablet(context)? 200: 70, width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(0),
                                          child: FadeInImage.assetNetwork(
                                            imageErrorBuilder: (c,o,s) => Image.asset(Images.placeholder,
                                            height: 70, width: double.infinity, fit: BoxFit.cover,
                                            ),
                                            placeholder: Images.placeholder,
                                            image: '${Get.find<SplashController>().baseUrls!.productThumbnailUrl}/${orderController.orderDetails![index]!.productDetails.thumbnail}',
                                            height:isTablet(context)? 200: 70, width: double.infinity, fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      Expanded(child: 
                                      
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                          SizedBox(
                                            width: double.infinity,

                                            child: Text(' ${orderController.orderDetails![index]!.productDetails.name}', 

                                            overflow: TextOverflow.ellipsis,
                                            
                                            style: rubikMedium.copyWith(
                                              color: Theme.of(context).primaryColor ,

                                              fontSize: isTablet(context)? 20:14 ,fontWeight: FontWeight.w400
                                            ),),
                                          ),

 Row(
  mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text('${'quantity'.tr}:',
                                                    style: rubikRegular.copyWith(color: Theme.of(context).highlightColor
                                                    
                                                    
                                                    ,

                                                                                                                              fontSize:
                                                                                                                              
                                                                                                                              isTablet(context)? 15:
                                                                                                                              
                                                                                                                               10,

                                                    fontWeight: FontWeight.w400
                                                    )),
                                                Text(' ${orderController.orderDetails![index]!.qty}',
                                                    style: rubikMedium.copyWith(color: Theme.of(context).primaryColor
                                                    
                                                    ,                                                fontSize: 
                                                    
                                                    isTablet(context)? 15:
                                                    10,

                                                    fontWeight:isTablet(context)? FontWeight.bold: FontWeight.w400

                                                    
                                                    ),
                                                    
                                                    
                                                    
                                                    ),
                                              ],
                                            ),

 Row(
  mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text('${'price'.tr}:',
                                                    style: rubikRegular.copyWith(color: Theme.of(context).highlightColor,
                                                                                                    fontSize:isTablet(context)? 15: 10 
                                                                                                     ,                                              fontWeight: 
                                                                                                     
                                                                                                     isTablet(context)? FontWeight.bold:
                                                                                                     FontWeight.w400

                                                    )),
                                                Text( PriceConverter.convertPrice(orderController.orderDetails![index]!.price),
                                                    style: rubikMedium.copyWith(color: Colors.red ,
                                                    
                                                    fontSize: 10  ,                                              fontWeight: 
                                                    isTablet(context)? FontWeight.bold:
                                                    
                                                    FontWeight.w400

                                                    
                                                    )),
                                              ],
                                            ),



                                          ],
                                        ),
                                      )
                                      
                                      )
                                ],
                              )
                              
                              ,
                              ),
                            );
                            
                            
                                  
                                  ListView(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    scrollDirection: Axis.vertical,
                                    
                                     children: [
                                    Row(children: [
                                      SizedBox(
                                        height: 70, width: 70,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: FadeInImage.assetNetwork(
                                            imageErrorBuilder: (c,o,s) => Image.asset(Images.placeholder),
                                            placeholder: Images.placeholder,
                                            image: '${Get.find<SplashController>().baseUrls!.productThumbnailUrl}/${orderController.orderDetails![index]!.productDetails.thumbnail}',
                                            height: 70, width: 70, fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: Dimensions.paddingSizeSmall),
                                      Expanded(
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  orderController.orderDetails![index]!.productDetails.name,
                                                  style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).highlightColor),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text('amount'.tr, style: rubikRegular.copyWith(color: Theme.of(context).highlightColor)),
                                            ],
                                          ),
                                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                            Row(
                                              children: [
                                                Text('${'quantity'.tr}:',
                                                    style: rubikRegular.copyWith(color: Theme.of(context).highlightColor)),
                                                Text(' ${orderController.orderDetails![index]!.qty}',
                                                    style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),
                                              ],
                                            ),
                                            Text(
                                              PriceConverter.convertPrice(orderController.orderDetails![index]!.price),
                                              style: rubikMedium.copyWith(color: Theme.of(context).primaryColor),
                                            ),
                                          ]),
                                          const SizedBox(height: Dimensions.paddingSizeSmall),
                                          Text(' ${orderController.orderDetails![index]!.variant}', style: rubikMedium.copyWith(),),
                                        ]),
                                      ),
                                    ]),
                                    const Divider(height: 20),
                                  ]);
                                },
                              ),
                            ),
const SizedBox(height: 20,),
                            Container(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorDark,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                                  blurRadius: 5, spreadRadius: 1,
                                )],
                              ),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text('customer'.tr, 
                                style: 
                                rubikRegular.copyWith(fontSize:
                                
                                isTablet(context)? 18:
                                 Dimensions.fontSizeExtraSmall, 
                                
                                color: Theme.of(context).highlightColor,)),
                                ListTile(
                                  leading: SizedBox(width:
                                  
                                  isTablet(context)? 120:
                                   70,height:isTablet(context)? 120: 70,
                                    child: ClipRect(
                                      child: FadeInImage.assetNetwork(
                                        imageErrorBuilder: (c,o,s) => Image.asset(Images.placeholder),
                                        placeholder: Images.placeholder,
                                        image: '${Get.find<SplashController>().baseUrls!.customerImageUrl}/${orderModel!.customer!.image ?? ''}',
                                        height:isTablet(context)? 120: 40, width: isTablet(context)? 120:40, fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '${orderModel!.customer!.fName ?? ''} ${orderModel!.customer!.lName ?? ''}',
                                    style: rubikRegular.copyWith(fontSize:
                                    
                                    isTablet(context)? 30:
                                    
                                     Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor),
                                  ),
                                  trailing: InkWell(
                                    onTap: () {launch('tel:${orderModel!.customer!.phone}');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                      decoration: const BoxDecoration(shape: BoxShape.circle, 
                                      color: Colors.green
                                      //  Theme.of(context).shadowColor
                                      
                                      ),
                                      child:  Icon(Icons.call_outlined, 
                                      
                                      size: isTablet(context)? 30:24,
                                      
                                      color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: Dimensions.paddingSizeDefault),
                                Text('${'order_note'.tr} : ${orderModel!.orderNote != null?orderModel!.orderNote ?? '': ""}', style: rubikRegular
                                .copyWith(
                                  fontSize: isTablet(context)? 20:15
                                )
                                
                                
                                ),
                                const SizedBox(height: Dimensions.paddingSizeDefault),
                                Text('${'address'.tr} : ${orderModel!.shippingAddressData != null ? orderModel!.shippingAddress!.address! : orderModel!.shippingAddress ?? ''}', style:
                                 rubikRegular.copyWith(
                                  fontSize: isTablet(context)? 20:15
                                 )
                                 
                                 ),
                                const SizedBox(height: Dimensions.paddingSizeDefault),
                                Text('${'billing_address'.tr} : ${orderModel!.billingAddress != null ? jsonDecode(orderModel!.billingAddress!)['address'] : orderModel!.billingAddress ?? ''}',
                                 style: rubikRegular.copyWith(
                                  fontSize: isTablet(context)? 20:15
                                 )),

                              ]),
                            ),
                             SizedBox(height:
                            isTablet(context)? 30:
                             20),



                            // (orderModel.orderNote != null && orderModel.orderNote.isNotEmpty) ? Container(
                            //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            //   margin: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
                            //   width: double.infinity,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10),
                            //     border: Border.all(width: 1, color: Theme.of(context).hintColor),
                            //   ),
                            //   child: Text(orderModel.orderNote, style: rubikRegular.copyWith(color: Theme.of(context).hintColor)),
                            // ) : SizedBox(),

                            // Total



   Row(children: [
                                  Text('${'order_summary'.tr} :', style: rubikRegular.copyWith(
                                    fontSize: isTablet(context)? 20:15,
                                    
                                    color: Theme.of(context).highlightColor)),
                                   SizedBox(width:
                                  isTablet(context)? 8:
                                  
                                  
                                   Dimensions.paddingSizeExtraSmall),


                                ]),



                            Container(
                              padding:  EdgeInsets.symmetric(
                                vertical: isTablet(context)? 9:5
                              ),
                              decoration: BoxDecoration(

                                border: Border(
                                  top: BorderSide(
                                    width: 1,color: Theme.of(context).primaryColor
                                  )
                                )
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text('items_price'.tr, style: rubikRegular.copyWith(fontSize:
                                isTablet(context)? 20:
                                
                                
                                 Dimensions.fontSizeLarge)),
                                Text(PriceConverter.convertPrice( itemsPrice),
                                 style: rubikRegular.copyWith(fontSize: 
                                 
                                 isTablet(context)? 20:
                                 
                                 Dimensions.fontSizeLarge)),
                              ]),
                            )
                            
                            
                            ,
                             SizedBox(height:
                            
                            isTablet(context)? 18:
                             10),

                               Container(
                              padding:  EdgeInsets.symmetric(
                                vertical:isTablet(context)? 9: 5
                              ),
                              decoration: BoxDecoration(

                                border: Border(
                                  top: BorderSide(
                                    width: 1,color: Theme.of(context).primaryColor
                                  )
                                )
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                                Text('tax'.tr, style: rubikRegular.copyWith(fontSize:
                                
                                isTablet(context)? 20:
                                 Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                                Text('(+) ${PriceConverter.convertPrice( tax)}',
                                    style: rubikRegular.copyWith(fontSize:isTablet(context)? 20: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                              ]),
                            ),
                             SizedBox(height:isTablet(context)? 18: 10),

                            // const Padding(
                            //   padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            //   child: CustomDivider(),
                            // ),

                                  Container(
                              padding:  EdgeInsets.symmetric(
                                vertical:isTablet(context)? 9: 5
                              ),
                              decoration: BoxDecoration(

                                border: Border(
                                  // bottom: BorderSide(
                                  //   width: 1,color: Theme.of(context).primaryColor
                                  // ),
                                  top: BorderSide(
                                    width: 1,color: Theme.of(context).primaryColor
                                  )
                                )
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text('subtotal'.tr, style: rubikMedium.copyWith(fontSize: 
                                isTablet(context)? 20:
                                
                                Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                                Text(PriceConverter.convertPrice( subTotal),
                                    style: rubikMedium.copyWith(fontSize:
                                    
                                    isTablet(context)? 20:
                                    
                                     Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                              ]),
                            ),
                             SizedBox(height: 
                             isTablet(context)? 18:
                             
                             10),

//  const Padding(
//                           padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
//                           child: CustomDivider(),
//                         ),


                            Container(
                               padding:  EdgeInsets.symmetric(
                                vertical:isTablet(context)? 9: 5
                              ),
                              decoration: BoxDecoration(

                                border: Border(
                                  top: BorderSide(
                                    width: 1,color: Theme.of(context).primaryColor
                                  )
                                )
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text('discount'.tr, style: rubikRegular.copyWith(fontSize: 
                                isTablet(context)? 20:
                                
                                Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                                Text('(-) ${PriceConverter.convertPrice( discount)}', style: rubikRegular.copyWith(
                                  fontSize: 
                                  
                                  isTablet(context)? 20:
                                  Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                              ]),
                            ),
                            const SizedBox(height: 10),

                            Container(

                               padding:  EdgeInsets.symmetric(
                                vertical:isTablet(context)? 9: 5
                              ),
                              decoration: BoxDecoration(

                                border: Border(
                                  top: BorderSide(
                                    width: 1,color: Theme.of(context).primaryColor
                                  )
                                )
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text('coupon_discount'.tr, style: rubikRegular.copyWith(fontSize:
                                
                                isTablet(context)? 20:
                                 Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                                Text(
                                  '(-) ${PriceConverter.convertPrice(orderModel!.discountAmount!)}',
                                  style: rubikRegular.copyWith(fontSize: 
                                  isTablet(context)? 20:
                                  
                                  Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor),
                                ),
                              ]),
                            ),
                            const SizedBox(height: 10),

                            Container(
                               padding:  EdgeInsets.symmetric(
                                vertical:isTablet(context)? 9: 5
                              ),
                              decoration: BoxDecoration(

                                border: Border(
                                  top: BorderSide(
                                    width: 1,color: Theme.of(context).primaryColor
                                  )
                                )
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text('delivery_fee'.tr, style: rubikRegular.copyWith(fontSize:
                                
                                isTablet(context)? 20:
                                 Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                                Text('(+) ${PriceConverter.convertPrice( deliveryCharge)}', style: rubikRegular.copyWith(
                                  
                                  
                                  fontSize:
                                  
                                  isTablet(context)? 20:
                                   Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                              ]),
                            ),

                            // const Padding(
                            //   padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            //   child: CustomDivider(),
                            // ),

                            Container(
                               padding:  EdgeInsets.symmetric(
                                vertical:isTablet(context)? 9: 5
                              ),
                              decoration: BoxDecoration(

                                border: Border(


                                  top: 
                                  
                                  BorderSide(
                                    width: 1, color: Theme.of(context).primaryColor
                                  )
                                  ,
                                  bottom: BorderSide(
                                    width: 1,color: Theme.of(context).primaryColor
                                  )
                                )
                              ),
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                Text('total_amount'.tr, style: rubikMedium.copyWith(fontSize:
                                
                                isTablet(context)? 20:
                                 Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor)),
                                Text(PriceConverter.convertPrice( totalPrice), style: rubikMedium.copyWith(fontSize:
                                
                                isTablet(context)? 20:
                                 Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor),
                                ),
                              ]),
                            ),
                            const SizedBox(height: 30),

                            /* //Direction Button..................................
                            orderModel.orderStatus == 'processing' || orderModel.orderStatus == 'out_for_delivery'
                                ? GetBuilder<LocationController>(
                                    builder: (locationProvider) => CustomButton(
                                        btnTxt: 'direction'.tr,
                                        onTap: () {
                                          MapUtils.openMap(
                                              23.8103,
                                              90.4125,
                                              locationProvider.currentLocation.latitude ?? 23.81,
                                              locationProvider.currentLocation.longitude ?? 90.4125);
                                        }),
                                  )
                                : const SizedBox.shrink(),


                            */
                          ],
                        ),
                      ),

                      orderModel!.orderStatus == 'processing' ? Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          border: Border.all(color: Theme.of(context).dividerColor.withOpacity(.05)),
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Transform.rotate(
                          angle: 
                          
                          0,
                          
                          //  Get.find<LocalizationController>().isLtr ? pi * 2 : pi, // in radians
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: SliderButton(
                              action: () {

                                FirebaseAnalytics.instance.logEvent(
    name: "shipping_done",
    parameters: {
          'order_id':orderModel!.id,
          'destination_lat':orderModel!.shippingAddress!.latitude,
          'destination_lng':orderModel!.shippingAddress!.longitude,

            "delivery_man_id":profileController.profileModel.id,
            'delivery_man_name': '${profileController.profileModel.fName!} ${profileController.profileModel.lName!}'
             ,
            "date":intl. DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    },
);
                                Get.find<OrderController>().updateOrderStatus(orderId: orderModel!.id, status: 'out_for_delivery',context: context);
                                Get.find<OrderController>().getAllOrders(context);
                              },

                              ///Put label over here
                              label: Text('swip_to_deliver_order'.tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor),),
                              dismissThresholds: 0.5,
                              icon:  Center(
                                  child: Icon(
                                    Icons.double_arrow_sharp,
                                    color: Colors.white,
                                    size:isTablet(context)? 30: 20.0,
                                    semanticLabel: 'Text to announce in accessibility modes',
                                  )),

                              ///Change All the color and size from here.
                              radius: 10,
                              boxShadow: const BoxShadow(blurRadius: 0.0),
                              buttonColor: Theme.of(context).primaryColor,
                              backgroundColor: Theme.of(context).colorScheme.background,
                              baseColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      )
                          : orderModel!.orderStatus != 'out_for_delivery'
                          ? Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                          border: Border.all(color: Theme.of(context).dividerColor.withOpacity(.05)),
                          color: Theme.of(context).colorScheme.background,),
                        child: Transform.rotate(
                          angle: 
                          0
                          // Get.find<LocalizationController>().isLtr ? pi * 2 : pi
                          ,
                          
                           // in radians
                          child: Directionality(
                            textDirection: TextDirection.ltr, // set it to rtl
                            child: SliderButton(
                              action: () {
                                // String token = Get.find<AuthController>().getUserToken();

                                if (orderModel!.paymentStatus == 'paid') {
                                  Get.find<OrderController>().updateOrderStatus(orderId: orderModel!.id, status: 'delivered',context: context);
                                  Get.find<TrackerController>().updateTrackStart(false);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (_) => OrderPlaceScreen(orderID: orderModel!.id.toString())));
                              
                              
                                } else {
                                  showDialog(context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                          child: DeliveryDialog(
                                            onTap: () {},
                                            index: index,
                                            totalPrice: totalPrice,
                                            orderModel: orderModel,
                                          ),
                                        );
                                      });
                                }
                              },

                              ///Put label over here
                              label: Text('swip_to_confirm_order'.tr, style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor),),
                              dismissThresholds: 0.5,
                              icon: const Center(
                                  child: Icon(
                                    Icons.double_arrow_sharp,
                                    color: Colors.white,
                                    size: 20.0,
                                    semanticLabel: 'Text to announce in accessibility modes',
                                  )),

                              ///Change All the color and size from here.
                              radius: 10,
                              boxShadow: const BoxShadow(blurRadius: 0.0),
                              buttonColor: Theme.of(context).primaryColor,
                              backgroundColor: Theme.of(context).colorScheme.background,
                              baseColor: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      )
                          : const SizedBox.shrink(),
                    ],
                  );
                }
              )
              
              
              :
              
               Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
        },
      ),
    );
  }
}

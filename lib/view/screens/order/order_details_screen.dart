import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/controller/localization_controller.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/controller/theme_controller.dart';
import 'package:sixvalley_delivery_boy/controller/tracker_controller.dart';
import 'package:sixvalley_delivery_boy/data/model/response/order_model.dart';
import 'package:sixvalley_delivery_boy/helper/date_converter.dart';
import 'package:sixvalley_delivery_boy/helper/price_converter.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/custom_divider.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/delivery_dialog.dart';
import 'package:sixvalley_delivery_boy/view/screens/order/widget/slider_button.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


import 'order_place_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel orderModel;
  final int index;
  const OrderDetailsScreen({Key key, this.orderModel, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>().getOrderDetails(orderModel.id.toString(), context);
    double deliveryCharge = 0;
    deliveryCharge = orderModel.shippingCost;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('order_details'.tr,
          style: Theme.of(context).textTheme.headline3.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1.color),
        ),
      ),
      body: GetBuilder<OrderController>(
        builder: (orderController) {
          double _itemsPrice = 0;
          double _discount = 0;
          double _tax = 0;
          if (orderController.orderDetails != null) {
            for (var orderDetails in orderController.orderDetails) {
              _itemsPrice = _itemsPrice + (orderDetails.price * orderDetails.qty);
              _discount = _discount + orderDetails.discount;
              _tax = _tax + orderDetails.tax;
            }
          }
          double _subTotal = _itemsPrice + _tax;
          double totalPrice = _subTotal - _discount + deliveryCharge - orderModel.discountAmount;

          return orderController.orderDetails != null
              ? Column(
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
                                Text('order_id'.tr, style: rubikRegular.copyWith(color: Theme.of(context).highlightColor)),
                                Text(' # ${orderModel.id}', style: rubikMedium.copyWith(color: Theme.of(context).highlightColor)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(Icons.watch_later, size: 17),
                                const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                Padding(
                                  padding: const EdgeInsets.only(right: 2.0),
                                  child: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderModel.createdAt)), maxLines: 1, overflow: TextOverflow.ellipsis, style: rubikRegular.copyWith(color: Theme.of(context).highlightColor,fontSize: Dimensions.fontSizeExtraSmall)),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
                              blurRadius: 5, spreadRadius: 1,
                            )],
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('customer'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).highlightColor,)),
                            ListTile(
                              leading: SizedBox(width: 70,height: 70,
                                child: ClipRect(
                                  child: FadeInImage.assetNetwork(
                                    imageErrorBuilder: (c,o,s) => Image.asset(Images.placeholder),
                                    placeholder: Images.placeholder,
                                    image: '${Get.find<SplashController>().baseUrls.customerImageUrl}/${orderModel.customer.image ?? ''}',
                                    height: 40, width: 40, fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                '${orderModel.customer.fName ?? ''} ${orderModel.customer.lName ?? ''}',
                                style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor),
                              ),
                              trailing: InkWell(
                                onTap: () {launch('tel:${orderModel.customer.phone}');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).shadowColor),
                                  child: const Icon(Icons.call_outlined, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                            Text('${'order_note'.tr} : ${orderModel.orderNote != null?orderModel.orderNote ?? '': ""}', style: rubikRegular),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                            Text('${'address'.tr} : ${orderModel.shippingAddressData != null ? orderModel.shippingAddress.address : orderModel.shippingAddress ?? ''}', style: rubikRegular),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                            Text('${'billing_address'.tr} : ${orderModel.billingAddress != null ? jsonDecode(orderModel.billingAddress)['address'] : orderModel.billingAddress ?? ''}', style: rubikRegular),

                          ]),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Text('${'item'.tr}:', style: rubikRegular.copyWith(color: Theme.of(context).highlightColor)),
                              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                              Text(orderController.orderDetails.length.toString(), style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),
                            ]),
                            orderModel.orderStatus == 'processing' || orderModel.orderStatus == 'out_for_delivery'
                                ? Row(children: [
                                    Text('${'payment_status'.tr}:', style: rubikRegular.copyWith(color: Theme.of(context).highlightColor)),
                                    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                    Text(orderModel.paymentStatus.tr , style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),
                                  ])
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const Divider(height: 20),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderController.orderDetails.length,
                          itemBuilder: (context, index) {
                            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(children: [
                                SizedBox(
                                  height: 70, width: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      imageErrorBuilder: (c,o,s) => Image.asset(Images.placeholder),
                                      placeholder: Images.placeholder,
                                      image: '${Get.find<SplashController>().baseUrls.productThumbnailUrl}/${orderController.orderDetails[index].productDetails.thumbnail}',
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
                                            orderController.orderDetails[index].productDetails.name,
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
                                          Text(' ${orderController.orderDetails[index].qty}',
                                              style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),
                                        ],
                                      ),
                                      Text(
                                        PriceConverter.convertPrice(orderController.orderDetails[index].price),
                                        style: rubikMedium.copyWith(color: Theme.of(context).primaryColor),
                                      ),
                                    ]),
                                    const SizedBox(height: Dimensions.paddingSizeSmall),
                                    Text(' ${orderController.orderDetails[index].variant}', style: rubikMedium.copyWith(),),
                                  ]),
                                ),
                              ]),
                              const Divider(height: 20),
                            ]);
                          },
                        ),

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
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('items_price'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                          Text(PriceConverter.convertPrice( _itemsPrice), style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        ]),
                        const SizedBox(height: 10),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('tax'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                          Text('(+) ${PriceConverter.convertPrice( _tax)}',
                              style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                        ]),
                        const SizedBox(height: 10),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: CustomDivider(),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('subtotal'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                          Text(PriceConverter.convertPrice( _subTotal),
                              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                        ]),
                        const SizedBox(height: 10),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('discount'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                          Text('(-) ${PriceConverter.convertPrice( _discount)}', style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                        ]),
                        const SizedBox(height: 10),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('coupon_discount'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                          Text(
                            '(-) ${PriceConverter.convertPrice(orderModel.discountAmount)}',
                            style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor),
                          ),
                        ]),
                        const SizedBox(height: 10),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('delivery_fee'.tr, style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                          Text('(+) ${PriceConverter.convertPrice( deliveryCharge)}', style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor)),
                        ]),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                          child: CustomDivider(),
                        ),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text('total_amount'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor)),
                          Text(PriceConverter.convertPrice( totalPrice), style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColor),
                          ),
                        ]),
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

                  orderModel.orderStatus == 'processing' ? Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      border: Border.all(color: Theme.of(context).dividerColor.withOpacity(.05)),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Transform.rotate(
                      angle: Get.find<LocalizationController>().isLtr ? pi * 2 : pi, // in radians
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: SliderButton(
                          action: () {
                            Get.find<OrderController>().updateOrderStatus(orderId: orderModel.id, status: 'out_for_delivery',context: context);
                            Get.find<OrderController>().getAllOrders(context);
                          },

                          ///Put label over here
                          label: Text('swip_to_deliver_order'.tr, style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).primaryColor),),
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
                          backgroundColor: Theme.of(context).backgroundColor,
                          baseColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                      : orderModel.orderStatus == 'out_for_delivery'
                      ? Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
                      border: Border.all(color: Theme.of(context).dividerColor.withOpacity(.05)),
                      color: Theme.of(context).backgroundColor,),
                    child: Transform.rotate(
                      angle: Get.find<LocalizationController>().isLtr ? pi * 2 : pi, // in radians
                      child: Directionality(
                        textDirection: TextDirection.ltr, // set it to rtl
                        child: SliderButton(
                          action: () {
                            // String token = Get.find<AuthController>().getUserToken();

                            if (orderModel.paymentStatus == 'paid') {
                              Get.find<OrderController>().updateOrderStatus(orderId: orderModel.id, status: 'delivered',context: context);
                              Get.find<TrackerController>().updateTrackStart(false);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (_) => OrderPlaceScreen(orderID: orderModel.id.toString())));
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
                          label: Text('swip_to_confirm_order'.tr, style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).primaryColor),),
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
                          backgroundColor: Theme.of(context).backgroundColor,
                          baseColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                      : const SizedBox.shrink(),
                ],
              )
              : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/order_controller.dart';
import 'package:sixvalley_delivery_boy/helper/date_converter.dart';
import 'package:sixvalley_delivery_boy/helper/price_converter.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';

import 'order_details_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  OrderHistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>().getAllOrderHistory(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
        leading: const SizedBox.shrink(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).cardColor,
        title: Text('order_history'.tr, style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).textTheme.bodyText1.color, fontSize: Dimensions.fontSizeLarge),),
      ),
        body: GetBuilder<OrderController>(builder: (orderController) {
          return orderController.allOrderHistory != null ? orderController.allOrderHistory.isNotEmpty
              ? RefreshIndicator(
            child: orderController.allOrderHistory.isNotEmpty
                ? ListView.builder(
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
                                    rubikMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1.color),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text('amount'.tr, style: rubikRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
                              ],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Row(
                                children: [
                                  Text('status'.tr, style: rubikRegular.copyWith(color: Theme.of(context).textTheme.bodyText1.color)),
                                  Text(orderController.allOrderHistory[index].orderStatus.tr,
                                      style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),
                                ],
                              ),
                              Text(PriceConverter.convertPrice(orderController.allOrderHistory[index].orderAmount),
                                  style: rubikMedium.copyWith(color: Theme.of(context).primaryColor)),
                            ]),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Row(children: [
                              Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyText1.color)),
                              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                              Text(
                                '${'order_at'.tr}${DateConverter.localDateToIsoStringAMPM(DateTime.parse(orderController.allOrderHistory[index].updatedAt))
                                }',
                                style: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyText1.color),
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
              child: Text('no_data_found'.tr, style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).primaryColor),),
            ),
            ),

            onRefresh: () => orderController.orderRefresh(context),
            displacement: 20,
            color: ColorResources.colorWhite,
            backgroundColor: Theme.of(context).primaryColor,
            key: _refreshIndicatorKey,
          ) : Center(child: Text('no_history_available'.tr, style: Theme.of(context).textTheme.headline3,
          )) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
        }

        ));
  }
}

import 'package:flutter/material.dart';
import 'package:eamar_delivery/controller/order_controller.dart';
import 'package:eamar_delivery/controller/tracker_controller.dart';
import 'package:eamar_delivery/data/model/response/order_model.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/helper/price_converter.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/images.dart';
import 'package:eamar_delivery/view/base/custom_button.dart';

import '../order_details_screen.dart';
import '../order_place_screen.dart';

class DeliveryDialog extends StatelessWidget {
  final Function()? onTap;
  final OrderModel? orderModel;
  final int? index;
  final double? totalPrice;

  const DeliveryDialog({Key? key, @required this.onTap, this.totalPrice, this.orderModel, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            border: Border.all(color: Theme.of(context).primaryColor, width: 0.2)),
        child: Stack(
          clipBehavior: Clip.none, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(Images.money),
                const SizedBox(height: 20),
                Center(
                    child: Text('do_you_collect_money'.tr, style: Theme.of(context).textTheme.headline3!.copyWith(color: Theme.of(context).focusColor),
                )),
                const SizedBox(height: 20),
                Center(
                    child: Text(
                  PriceConverter.convertPrice(totalPrice!),
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Theme.of(context).focusColor,fontSize: 30),
                )),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                      btnTxt: 'no'.tr,
                      isShowBorder: true,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModel: orderModel!, index: index!)));
                      },
                    )),
                    const SizedBox(width: Dimensions.paddingSizeDefault),
                    Expanded(
                        child: GetBuilder<OrderController>(
                      builder: (orderController) {
                        return !orderController.isLoading ? CustomButton(
                          btnTxt: 'yes'.tr,
                          onTap: () {
                            Get.find<TrackerController>().updateTrackStart(false);
                            Get.find<OrderController>().updateOrderStatus(
                                orderId: orderModel!.id,context: context,
                                // index: index,
                                status: 'delivered').then((value) {
                              if (value) {
                                orderController.updatePaymentStatus(orderId: orderModel!.id, status: 'paid');
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => OrderPlaceScreen(orderID: orderModel!.id.toString())));
                              }
                            });
                          },
                        ) : Center(child: CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
                      },
                    )),
                  ],
                ),
              ],
            ),
            Positioned(
              right: -20,
              top: -20,
              child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.clear, size: Dimensions.paddingSizeLarge),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => OrderDetailsScreen(orderModel: orderModel!, index: index!)));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

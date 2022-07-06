import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';

class ConfirmationDialog extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final bool hasCancel;
  const ConfirmationDialog({Key key, @required this.icon, this.title, @required this.description, @required this.onYesPressed, this.isLogOut = false, this.hasCancel = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Image.asset(icon, width: 50, height: 50),
          ),

          title != null ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
            child: Text(
              title, textAlign: TextAlign.center,
              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
            ),
          ) : const SizedBox(),

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Text(description, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),

          // GetBuilder<OrderController>(builder: (orderController) {
          //   return !orderController.isLoading ? Row(children: [
          //     hasCancel ? Expanded(child: TextButton(
          //       onPressed: () => isLogOut ? onYesPressed() : Get.back(),
          //       style: TextButton.styleFrom(
          //         backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: Size(1170, 40), padding: EdgeInsets.zero,
          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
          //       ),
          //       child: Text(
          //         isLogOut ? 'yes'.tr : 'no'.tr, textAlign: TextAlign.center,
          //         style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyText1.color),
          //       ),
          //     )) : SizedBox(),
          //     SizedBox(width: hasCancel ? Dimensions.PADDING_SIZE_LARGE : 0),
          //
          //     Expanded(child: CustomButton(
          //       buttonText: isLogOut ? 'no'.tr : hasCancel ? 'yes'.tr : 'ok'.tr,
          //       onPressed: () => isLogOut ? Get.back() : onYesPressed(),
          //       height: 40,
          //     )),
          //   ]) : Center(child: CircularProgressIndicator());
          // }),

        ]),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';

import 'custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String description;
  final Function onOkPressed;
  const CustomAlertDialog({Key key, @required this.description, @required this.onOkPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          Icon(Icons.info, size: 80, color: Theme.of(context).primaryColor),

          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: Text(
              description, textAlign: TextAlign.center,
              style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),

          CustomButton(
            btnTxt: 'ok'.tr,
            onTap: onOkPressed,
          ),

        ]),
      ),
    );
  }
}

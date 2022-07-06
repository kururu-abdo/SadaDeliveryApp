import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_button.dart';
import 'package:sixvalley_delivery_boy/view/screens/dashboard/dashboard_screen.dart';

class OrderPlaceScreen extends StatelessWidget {
  final String orderID;
  const OrderPlaceScreen({Key key, this.orderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.doneWithFullBackground,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                'Order Successfully Delivered',
                style: Theme.of(context).textTheme.headline3.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).highlightColor),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('order_id'.tr, style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).highlightColor),),
                  Text(' #$orderID', style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).highlightColor),),
                ],
              ),
              const SizedBox(height: 30),
              CustomButton(
                btnTxt: 'back_home'.tr,
                onTap: () {Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const DashboardScreen(pageIndex: 0,)), (route) => false);},
              )
            ],
          ),
        ),
      ),
    );
  }
}

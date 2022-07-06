import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sixvalley_delivery_boy/controller/theme_controller.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';

class StatusWidget extends StatefulWidget {

  const StatusWidget({Key key}) : super(key: key);

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: themeController.toggleTheme,
      child: themeController.darkTheme
          ? Container(
        width: 74,
        height: 29,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          children: [
            Expanded(
                child: Text('dark'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                    color: ColorResources.colorWhite,
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                )),
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: CircleAvatar(
                radius: 13,
                backgroundColor: ColorResources.colorWhite,
              ),
            )
          ],
        ),
      )
          : Container(
        width: 74,
        height: 29,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorResources.colorGrey,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(1.0),
              child: CircleAvatar(
                radius: 13,
                backgroundColor: ColorResources.colorWhite,
              ),
            ),
            Expanded(
                child: Text(
                  'light'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                    color: ColorResources.colorWhite,
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

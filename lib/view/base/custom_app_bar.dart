import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
  const CustomAppBar({Key key, @required this.title, this.isBackButtonExist = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: rubikMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyText1.color)),
      centerTitle: true,
      leading: isBackButtonExist ? IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: ColorResources.colorBlack),
        onPressed: () => Navigator.pop(context),
      ) : const SizedBox(),
      backgroundColor: ColorResources.colorWhite,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

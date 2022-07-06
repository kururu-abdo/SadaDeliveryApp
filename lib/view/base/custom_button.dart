import 'package:flutter/material.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String btnTxt;
  final bool isShowBorder;

  const CustomButton({Key key, this.onTap, @required this.btnTxt, this.isShowBorder = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: !isShowBorder ? Colors.grey.withOpacity(0.2) : Colors.transparent, spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isShowBorder ? ColorResources.colorGreyWhite : Colors.transparent),
          color: !isShowBorder ? Theme.of(context).primaryColor : Colors.transparent),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Text(btnTxt ?? "",
            style: Theme.of(context).textTheme.headline3.copyWith(
                color: isShowBorder ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).primaryColorDark, fontSize: Dimensions.fontSizeLarge)),
      ),
    );
  }
}

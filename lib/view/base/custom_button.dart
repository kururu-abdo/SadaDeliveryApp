import 'package:eamar_delivery/utill/utils.dart';
import 'package:flutter/material.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:eamar_delivery/utill/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? btnTxt;
  final bool? isShowBorder;

  const CustomButton({Key? key, this.onTap, @required this.btnTxt, this.isShowBorder = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  isTablet(context)? 70: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: !isShowBorder! ? Colors.grey.withOpacity(0.2) : Colors.transparent, spreadRadius: 1, blurRadius: 7, offset: const Offset(0, 1))
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isShowBorder! ? ColorResources.colorGreyWhite : Colors.transparent),
          color: !isShowBorder! ? Theme.of(context).primaryColor : Colors.transparent),
      child: TextButton(
        onPressed: onTap!,
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Text(btnTxt ?? "",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: isShowBorder! ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).primaryColorDark, fontSize: 
                isTablet(context)?30:
                
                Dimensions.fontSizeLarge)),
      ),
    );
  }
}

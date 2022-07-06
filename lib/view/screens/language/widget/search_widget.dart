import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sixvalley_delivery_boy/controller/language_controller.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';

class SearchWidget extends StatefulWidget {

  const SearchWidget({Key key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  LanguageController languageController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: Theme.of(context).primaryColor,
        onChanged: (String query) {
          languageController.searchLanguage(query, context);
        },
        style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.colorBlack, fontSize: Dimensions.fontSizeLarge),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
          isDense: true,
          hintText: 'find_language'.tr,
          fillColor: ColorResources.colorWhite,
          hintStyle: Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.fontSizeSmall, color: ColorResources.colorGreyChateau),
          filled: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
            child: Image.asset(Images.search, width: 15, height: 15),
          ),
        ),
      );
  }
}

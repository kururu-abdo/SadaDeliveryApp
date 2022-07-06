import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/view/base/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class HtmlViewerScreen extends StatelessWidget {
  final bool isPrivacyPolicy;
   // ignore: prefer_const_constructors_in_immutables
   HtmlViewerScreen({Key key, @required this.isPrivacyPolicy}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String _data = isPrivacyPolicy ? Get.find<SplashController>().configModel.privacyPolicy
        : Get.find<SplashController>().configModel.termsConditions;
    return Scaffold(
      appBar: CustomAppBar(title: isPrivacyPolicy ? 'privacy_policy' : 'terms_and_condition'.tr),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          physics: const BouncingScrollPhysics(),
          child: HtmlWidget(
            _data,
            key: Key(isPrivacyPolicy ? 'privacy_policy' : 'terms_and_condition'),
            // ignore: missing_return
            onTapUrl: (String url) {
              launch(url);
            },
          ),
        ),
      ),
    );
  }
}
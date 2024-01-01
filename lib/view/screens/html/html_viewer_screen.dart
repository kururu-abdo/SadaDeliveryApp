import 'dart:developer';

import 'package:eamar_delivery/utill/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:eamar_delivery/controller/splash_controller.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/view/base/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class HtmlViewerScreen extends StatelessWidget {
   final AdvancedDrawerController? advancedDrawerController;
  final Function? handleMenuePressed;
  final bool? isPrivacyPolicy;
   // ignore: prefer_const_constructors_in_immutables
   HtmlViewerScreen({Key? key, @required this.isPrivacyPolicy, this.advancedDrawerController, this.handleMenuePressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String data = isPrivacyPolicy! ? Get.find<SplashController>().configModel.privacyPolicy
        : Get.find<SplashController>().configModel.termsConditions;
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Theme.of(context).primaryColor,

        title: Text(
          isPrivacyPolicy! ? 'privacy_policy'.tr :
       'terms_and_condition'.tr ,
       style: TextStyle(
        fontSize: isTablet(context)? 25: 18, 
        color: Colors.white 
       ),
        ),
        centerTitle: true,


        leading: 
        
            
      IconButton(
            onPressed: (){
              log('PRESSED');
              handleMenuePressed!();
            },
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: advancedDrawerController!,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),

                    size: isTablet(context)?  30: 24,
                  ),
                );
              },
            ),
         
         
      ),
          
      
        
      )
      ,
      //  CustomAppBar(title: isPrivacyPolicy! ? 'privacy_policy' :
      //  'terms_and_condition'.tr ,
       
       
       
      //  ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          physics: const BouncingScrollPhysics(),
          child: HtmlWidget(
            data,
            key: Key(isPrivacyPolicy! ? 'privacy_policy' : 'terms_and_condition'),
            // ignore: missing_return
            onTapUrl: (String url) {
            return  launch(url);
            },
          ),
        ),
      ),
    );
  }
}
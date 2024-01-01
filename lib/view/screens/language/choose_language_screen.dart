import 'dart:developer';

import 'package:eamar_delivery/utill/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/controller/language_controller.dart';
import 'package:eamar_delivery/controller/localization_controller.dart';
import 'package:eamar_delivery/data/model/response/language_model.dart';
import 'package:eamar_delivery/utill/app_constants.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/images.dart';
import 'package:eamar_delivery/view/base/custom_button.dart';
import 'package:eamar_delivery/view/base/custom_snackbar.dart';
import 'package:eamar_delivery/view/screens/auth/login_screen.dart';


class ChooseLanguageScreen extends StatelessWidget {
  final bool? fromHomeScreen;
    final AdvancedDrawerController? advancedDrawerController;
  final Function? handleMenuePressed;
  const ChooseLanguageScreen({Key? key, this.fromHomeScreen = false, this.advancedDrawerController, this.handleMenuePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<LanguageController>().initializeAllLanguages(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
centerTitle: true, 
backgroundColor: Theme.of(context).primaryColor,
        title: Text('choose_the_language'.tr ,
        style: TextStyle(

           fontSize:
                                  isTablet(context)? 24:  18,
                                  color: Colors.white
        ),
        ),

        leading: 
        fromHomeScreen!?
IconButton(onPressed: (){

  Navigator.pop(context);
}, icon:  Icon(
  Icons.arrow_back_ios ,color: Colors.white,

  size: isTablet(context)? 30: 24,
)):

            
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
                    key: ValueKey<bool>(value.visible),  size: isTablet(context)? 30: 24,
                  ),
                );
              },
            ),
         
         
      ),
          
      
        
        
      ),
      body: SafeArea(
        child: GetBuilder<LanguageController>(
          builder: (languageController){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall),
                  child: Text('choose_the_language'.tr, 
                  
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 
                  
                     isTablet(context)? 30:
                  22, color: Theme.of(context).highlightColor),),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView.builder(
                        itemCount: languageController.languages.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => _languageWidget(
                            context: context, languageModel: languageController.languages[index], languageController: languageController, index: index))),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeLarge, bottom: Dimensions.paddingSizeLarge),
                  child: CustomButton(
                    btnTxt: 'save'.tr,
                    onTap: () {
                      if(languageController.languages.isNotEmpty && languageController.selectIndex != -1) {
                        Get.find<LocalizationController>().setLanguage(Locale(
                          AppConstants.languages[languageController.selectIndex].languageCode!,
                          AppConstants.languages[languageController.selectIndex].countryCode,
                        ));
                        // if (fromHomeScreen!) {
                          Navigator.pop(context);
                        // } else {
                        //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>  LoginScreen()));
                        // }
                      }else {
                        showCustomSnackBar('select_a_language'.tr);
                      }
                    },
                  ),
                )
              ],
            );
          },

        ),
      ),
    );
  }

  Widget _languageWidget({BuildContext? context, LanguageModel? languageModel, LanguageController? languageController, int? index}) {
    return InkWell(
      onTap: () {
        languageController.setSelectIndex(index!);
      },
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal:isTablet(context!)?40: 20),
        decoration: BoxDecoration(
          color: languageController!.selectIndex == index ? 
          Theme.of(context).primaryColor.withOpacity(.15) : null,
          border: Border(
              top: BorderSide(
                  width: languageController.selectIndex == index ? 1.0 : 0.0,
                  color: languageController.selectIndex == index ? Theme.of(context).primaryColor : Colors.transparent),
              bottom: BorderSide(
                  width: languageController.selectIndex == index ? 1.0 : 0.0,
                  color: languageController.selectIndex == index ? Theme.of(context).primaryColor : Colors.transparent)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1.0,
                    color: languageController.selectIndex == index
                        ? Colors.transparent
                        : (languageController.selectIndex - 1) == (index! - 1)
                            ? Colors.transparent
                            : Theme.of(context).dividerColor.withOpacity(.2))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(languageModel!.imageUrl!, width:
                  
                  isTablet(context)?50:
                   34, height: isTablet(context)?50:34),
                  const SizedBox(width: 30),
                  Text(
                    languageModel.languageName!,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: isTablet(context)? 30:20,
                      
                      color:
                     Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ],
              ),
              languageController.selectIndex == index
                  ? Image.asset(
                      Images.done,
                      width:isTablet(context)?30: 17,
                      height:isTablet(context)?30: 17,
                      color: Theme.of(context).primaryColorLight,
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

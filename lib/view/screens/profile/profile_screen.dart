
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixvalley_delivery_boy/controller/auth_controller.dart';
import 'package:sixvalley_delivery_boy/controller/splash_controller.dart';
import 'package:sixvalley_delivery_boy/utill/color_resources.dart';
import 'package:sixvalley_delivery_boy/utill/dimensions.dart';
import 'package:sixvalley_delivery_boy/utill/images.dart';
import 'package:sixvalley_delivery_boy/view/screens/auth/login_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/html/html_viewer_screen.dart';
import 'package:sixvalley_delivery_boy/view/screens/profile/widget/profile_button.dart';


class ProfileScreen extends StatelessWidget {
   const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: GetBuilder<AuthController>(builder: (profileController){
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  color: Theme.of(context).primaryColor,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      Text('my_profile'.tr, style: Theme.of(context).textTheme.headline3.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColorDark),),
                      const SizedBox(height: 30),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: ColorResources.colorWhite, width: 3)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: FadeInImage.assetNetwork(
                              imageErrorBuilder: (c,o,t) => Image.asset(Images.placeholder),
                              placeholder: Images.placeholder,
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                              image: '${Get.find<SplashController>().baseUrls.reviewImageUrl}/delivery-man/${profileController.profileModel.image}',

                            )),
                      ),
                      const SizedBox(height: 20),
                      Text(profileController.profileModel.fName != null ? '${profileController.profileModel.fName ?? ''} ${profileController.profileModel.lName ?? ''}' : "",
                        style: Theme.of(context).textTheme.headline3.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).primaryColorDark),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('theme_style'.tr, style: Theme.of(context).textTheme.headline3.copyWith(color: Theme.of(context).highlightColor, fontSize: Dimensions.fontSizeLarge),
                          ),
                          //Theme section.........................
                          // StatusWidget()
                        ],
                      ),
                      const SizedBox(height: 20),
                      _userInfoWidget(context: context, text: profileController.profileModel.fName),
                      const SizedBox(height: 15),
                      _userInfoWidget(context: context, text: profileController.profileModel.lName),
                      const SizedBox(height: 15),
                      _userInfoWidget(context: context, text: profileController.profileModel.phone),
                      const SizedBox(height: 20),
                      ProfileButton(icon: Icons.privacy_tip, title: 'privacy_policy'.tr, onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  HtmlViewerScreen(isPrivacyPolicy: true)));
                      }),
                      const SizedBox(height: 10),
                      ProfileButton(icon: Icons.list, title: 'terms_and_condition'.tr, onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  HtmlViewerScreen(isPrivacyPolicy: false)));
                      }),
                      const SizedBox(height: 10),
                      ProfileButton(icon: Icons.logout, title: 'logout'.tr, onTap: () {
                        Get.find<AuthController>().clearSharedData().then((condition) {
                          Navigator.pop(context);
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  LoginScreen()), (route) => false);
                        });
                      }),

                    ],
                  ),
                )
              ],
            );

          },)
        ));
  }

  Widget _userInfoWidget({String text, BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          color: Theme.of(context).cardColor,
          border: Border.all(color: ColorResources.borderColor)),
      child: Text(
        text ?? '',
        style: Theme.of(context).textTheme.headline2.copyWith(color: Theme.of(context).focusColor),
      ),
    );
  }
}

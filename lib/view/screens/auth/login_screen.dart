import 'dart:developer';

import 'package:eamar_delivery/utill/utils.dart';
import 'package:eamar_delivery/view/base/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eamar_delivery/controller/auth_controller.dart';
import 'package:eamar_delivery/helper/email_checker.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/images.dart';
import 'package:eamar_delivery/utill/phone_utils.dart';
import 'package:eamar_delivery/view/base/code_picker_widget.dart';
import 'package:eamar_delivery/view/base/custom_button.dart';
import 'package:eamar_delivery/view/base/custom_snackbar.dart';
import 'package:eamar_delivery/view/base/custom_text_field.dart';
import 'package:eamar_delivery/view/base/custom_textfield2.dart';
import 'package:eamar_delivery/view/screens/dashboard/dashboard_screen.dart';
import 'package:validate_ksa_number/validate_ksa_number.dart';

class LoginScreen extends StatefulWidget {
   // ignore: prefer_const_constructors_in_immutables
   LoginScreen({Key? key}) : super(key: key);


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController!.text = Get.find<AuthController>().getUserEmail();
    _passwordController!.text = Get.find<AuthController>().getUserPassword();
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }
  final String _countryDialCode = "+966";
  final FocusNode _emailNode = FocusNode();
    final FocusNode _passNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Form(
          key: _formKeyLogin,
          child: GetBuilder<AuthController>(
            builder: (authController){
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                    "assets/image/delivery.png",
                      height:
                      
                      isTablet(context)? MediaQuery.of(context).size.height / 4
:                       MediaQuery.of(context).size.height / 4.5,
                      fit: BoxFit.scaleDown,
                      matchTextDirection: true,
                    ),
                  ),
                  //SizedBox(height: 20),
                  Center(
                      child: Text('login'.tr, style: 
                      Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 
                             isTablet(context)?30:
                      
                      24, color: Theme.of(context).hintColor),)),
                   SizedBox(height: 
                  
                         isTablet(context)?50:
                  35),
                  Text('phone_number'.tr, style: Theme.of(context).textTheme.
                  displayMedium!.copyWith(
                    
                    fontSize:        isTablet(context)?20: 18,
                    color: Theme.of(context).highlightColor),),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  // CustomTextField(
                  //   hintText: 'demo_gmail'.tr,
                  //   isShowBorder: true,
                  //   focusNode: _emailFocus,
                  //   nextFocus: _passwordFocus,
                  //   controller: _emailController,
                  //   inputType: TextInputType.emailAddress,
                  // ),

 // for Email
          // Container(
          //   // margin: EdgeInsets.only(
          //   //     left: Dimensions.MARGIN_SIZE_LARGE,
          //   //     right: Dimensions.MARGIN_SIZE_LARGE,
          //   //     bottom: Dimensions.MARGIN_SIZE_SMALL),
          //   child: Row(
          //     children: [
          //       CodePickerWidget(
          //         onChanged: (CountryCode countryCode) {
          //           _countryDialCode = countryCode.dialCode;
          //         },
          //         initialSelection: _countryDialCode,
          //         favorite: [_countryDialCode],
          //         showDropDownButton: true,
          //         padding: EdgeInsets.zero,
          //         showFlagMain: true,
          //         textStyle: TextStyle(
          //             color: Theme.of(context).textTheme.headline1.color),
          //       ),
          //       Expanded(
          //           child: 
          //           CustomTextField(
          //         hintText: 'demo_phone'.tr,
                  
          //         focusNode: _emailNode,
          //         nextNode: _passwordFocus,
          //         controller: _emailController,
          //         isPhoneNumber: true,
          //         textInputAction: TextInputAction.next,
          //         textInputType: TextInputType.phone,
          //       )
          //       ),
          //     ],
          //   ),
          // ),
Container(
            margin: const EdgeInsets.only(
                // left: Dimensions.MARGIN_SIZE_LARGE,
                // right: Dimensions.MARGIN_SIZE_LARGE,
                bottom: Dimensions.MARGIN_SIZE_SMALL),
child: 
 PhoneField(
                  hintText: 'demo_phone'.tr,
                  
                  focusNode: _emailNode,
                  nextNode: _passwordFocus,
                  controller: _emailController,
                  fillColor:Theme.of(context).cardColor,
                  isPhoneNumber: true,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                )


,
),



                   const SizedBox(height: Dimensions.paddingSizeLarge),
                  Text('password'.tr, style: 
                  Theme.of(context).textTheme.displayMedium!.copyWith(
                    
                    fontSize:        isTablet(context)? 20:18,
                    color: Theme.of(context).highlightColor),),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  
                  PasswordField(
                    hintText: 'password_hint'.tr,
                    isShowBorder: true,
                    isPhoneNumber: false,
                    isBorder: true,
                    isPassword: true,
                    isShowSuffixIcon: true,
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                    inputAction: TextInputAction.done,
                    onTap: (){
                      log('On Tap');
                    },
                  ),
                  const SizedBox(height: 22),

                  // for remember me section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          authController.toggleRememberMe();
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  color: authController.isActiveRememberMe ? Theme.of(context).primaryColor : ColorResources.colorWhite,
                                  border:
                                  Border.all(color: authController.isActiveRememberMe ? Colors.transparent : Theme.of(context).highlightColor),
                                  borderRadius: BorderRadius.circular(3)),
                              child: authController.isActiveRememberMe
                                  ? const Icon(Icons.done, color: ColorResources.colorWhite, size: 17)
                                  : const SizedBox.shrink(),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            Text('remember_me'.tr, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).highlightColor),)
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      authController.loginErrorMessage.isNotEmpty
                          ? const CircleAvatar(backgroundColor: Colors.red, radius: 5)
                          : const SizedBox.shrink(),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          authController.loginErrorMessage ?? "",
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),

                  // for login button
                  const SizedBox(height: 10),
                  !authController.isLoading ? CustomButton(
                    btnTxt: 'login'.tr,
                    onTap: () async {
                      var ksaNumber = KsaNumber();
                      String email =_countryDialCode.trim()+
                    
                    PhoneNumberUtils.getPhoneNumberFromInputs( _emailController!.text.trim())
                    ;
                      String password = _passwordController!.text.trim();
                      log(email);
                      if (email.isEmpty) {
                        showCustomSnackBar('enter_phone_number'.tr);
                      }
                      
                      else if (!ksaNumber.isValidNumber(email)) {
                        showCustomSnackBar('enter_valid_phone'.tr);
                      }
                      
                      else if (password.isEmpty) {
                        showCustomSnackBar('enter_password'.tr);
                      }else if (password.length < 6) {
                        showCustomSnackBar('password_should_be'.tr);
                      }else {
                        authController.login(email, password).then((status) async {
                          if (status.isSuccess) {
                            if (authController.isActiveRememberMe) {
                              authController.saveUserNumberAndPassword(_emailController!.text.toString().trim(), password);
                            } else {
                              authController.clearUserEmailAndPassword();
                            }
                            await Get.find<AuthController>().getProfile();
                           // ignore: prefer_const_constructors
                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => DashboardScreen(pageIndex: 0,)));
                          }else {
                            showCustomSnackBar(status.message);
                          }
                        });
                      }
                    },
                  ) : Center(
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

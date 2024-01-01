import 'package:eamar_delivery/controller/auth_controller.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:eamar_delivery/utill/dimensions.dart';
import 'package:eamar_delivery/utill/utils.dart';
import 'package:eamar_delivery/view/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignOutConfirmationDialog extends StatelessWidget {
  const SignOutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

isTablet(context)?
Flexible(child: 
 Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
          child: Text('want_to_sign_out'.tr, style: TextStyle(

fontSize: isTablet(context)? 20: 18

          ), textAlign: TextAlign.center),
        )
):
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
          child: Text('want_to_sign_out'.tr
          
          
          
          , textAlign: TextAlign.center),
        ),

        const Divider(height: 0, color: ColorResources.colorHint),
        Row(children: [

          Expanded(child: InkWell(
            onTap: () {
              // Provider.of<AuthProvider>(context, listen: false).clearSharedData().then((condition) {
              //   Navigator.pop(context);
              //   Provider.of<ProfileProvider>(context,listen: false).clearHomeAddress();
              //   Provider.of<ProfileProvider>(context,listen: false).clearOfficeAddress();
              //   Provider.of<AuthProvider>(context,listen: false).clearSharedData();
              //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthScreen()), (route) => false);
              // });

 Get.find<AuthController>().clearSharedData().then((condition) {
                          Navigator.pop(context);
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>  LoginScreen()),
                           (route) => false);
                        });





            },
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text('YES'.tr, style: 
              
              
              TextStyle(
                
                fontSize: isTablet(context)?20: 18,
                color: Theme.of(context).primaryColor)),
            ),
          )),

          Expanded(child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: ColorResources.colorNigherRider,
               borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))),
              child: Text('NO'.tr, style: TextStyle(
                
                 fontSize: isTablet(context)?20: 18,
                color: ColorResources.colorWhite)),
            ),
          )),

        ]),
      ]),
    );
  }
}

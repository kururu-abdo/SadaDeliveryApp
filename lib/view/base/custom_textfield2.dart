import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:eamar_delivery/utill/dimensions.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class PhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool? isPhoneNumber;
  final bool? isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization?capitalization;
  final bool? isBorder;

  PhoneField(
      {this.controller,
      this.hintText,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator=false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.isBorder = false,
      });

  @override
  Widget build(context) {
    var isRtl = Directionality.of(context)==TextDirection.rtl;
    return Container(
       height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          color: Theme.of(context).cardColor,
          border: Border.all(
            color:
            // widget.isShowBorder ?
           ColorResources.colorMap[200] !
          //  : 
          //  Colors.transparent
           
           )),
      // decoration: BoxDecoration(
      //   border: isBorder? Border.all(width: .8,color: Theme.of(context).hintColor):null,
      //   color: Theme.of(context).highlightColor,
      //   borderRadius: isPhoneNumber ? BorderRadius.only(topRight: Radius.circular(6), bottomRight: Radius.circular(6)) : BorderRadius.circular(6),
      //   boxShadow: [
      //     BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1)) // changes position of shadow
      //   ],
      // ),
      child: TextFormField(
        textAlign: 
        
        // isBorder? TextAlign.center:
        isRtl?TextAlign.end:
        TextAlign.start
        
        ,
      
        controller: controller,
        maxLines: maxLine ?? 1,
        textCapitalization: capitalization!,
        maxLength: isPhoneNumber! ? 10 : null,
        focusNode: focusNode,
        keyboardType: textInputType ?? TextInputType.text,
        //keyboardType: TextInputType.number,
        initialValue: null,
        textInputAction: textInputAction ?? TextInputAction.next,


        
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(nextNode);
        },
        //autovalidate: true,
        inputFormatters: [isPhoneNumber! ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter],
        validator: (input){
          if(input!.isEmpty){
            if(isValidator!){
              return validatorMessage??"";
            }
          }
          return null;

        },
        decoration: InputDecoration(
hintTextDirection: TextDirection.ltr,
          hintText: hintText ?? '',
          filled: fillColor != null,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          counterText: '',
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                   hintStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: Dimensions.fontSizeSmall, color: ColorResources.colorGreyChateau),

          errorStyle: TextStyle(height: 1.5),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,

          prefixIcon:isRtl?null: Container(
            padding: EdgeInsets.zero,
            width: 30,
            child: Center(
              child: Text(
                     '966',
                  // showFlagMain: true,
                      style: TextStyle(
                          // color: Colors.black
                          
                   color:       Theme.of(context).textTheme.headline1!.color ,
                   fontWeight: FontWeight.bold
                          
                          ),
                    ),
            ),
          ),
 suffixIcon:isRtl? Container(
            padding: EdgeInsets.zero,
            width: 30,
            child: Center(
              child: Text(
                     '966',
                  // showFlagMain: true,
                      style: TextStyle(
                          // color: Colors.black
                          
                   color:       Theme.of(context).textTheme.headline1!.color ,
                   fontWeight: FontWeight.bold
                          
                          ),
                    ),
            ),
          ):null,

//           prefix:  Flex(
//           direction: Axis.horizontal,
//           mainAxisSize: MainAxisSize.min,
// children: [
//    Flexible(
//                 fit: isRtl ? FlexFit.tight : FlexFit.loose,
//                 child: Text(
//                  '966',
//               // showFlagMain: true,
//                   style: TextStyle(
//                       color: Colors.black
                      
//                       // Theme.of(context).textTheme.headline1.color
                      
//                       ),
//                 ),
//                   // overflow: widget.textOverflow,
                
//               ),
// ],
//           )
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:eamar_delivery/utill/color_resources.dart';
import 'package:eamar_delivery/utill/dimensions.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Color? fillColor;
  final int? maxLines;
  final bool? isPassword;
  final bool? isCountryPicker;
  final bool? isShowBorder;
  final bool? isIcon;
  final bool?isShowSuffixIcon;
  final bool? isShowPrefixIcon;
  final Function()? onTap;
  final String? suffixIconUrl;
  final String? prefixIconUrl;
  final bool? isSearch;


  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool? isPhoneNumber;
  final bool? isValidator;
  final String? validatorMessage;
  final TextCapitalization? capitalization;
  final bool? isBorder;
  const CustomTextField(
      {Key? key, this.hintText = 'Write something...',
      this.controller,
      this.focusNode,
      this.nextFocus,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.fillColor,
      this.isCountryPicker = false,
      this.isShowBorder = false,
      this.isShowSuffixIcon = false,
      this.isShowPrefixIcon = false,
      this.onTap,
      this.isIcon = false,
      this.isPassword = false,
      this.suffixIconUrl,
      this.prefixIconUrl,
      this.isSearch = false, this.textInputType, this.maxLine, this.nextNode, this.textInputAction, this.isPhoneNumber, this.isValidator, this.validatorMessage, this.capitalization, this.isBorder}) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget 
  
  
  build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
          color: Theme.of(context).cardColor,
          border: Border.all(color: widget.isShowBorder! ? 
          ColorResources.colorMap[200]! :
           Colors.transparent)),
      child: TextFormField(

        
               maxLines: widget.isPassword! ?
               1:
               widget.maxLine ,

        controller: widget.controller,
        focusNode: widget.focusNode,
        style: Theme.of(context).textTheme.headline2!.copyWith(color: Theme.of(context).highlightColor, fontSize: Dimensions.fontSizeLarge),
        textInputAction: widget.inputAction,
        // keyboardType: widget.inputType,
        cursorColor: Theme.of(context).primaryColor,
        //onChanged: widget.isSearch ? widget.languageProvider.searchLanguage : null,
        obscureText: widget.isPassword! ? _obscureText : false,

  maxLength: widget.isPhoneNumber! ? 9 : null,
     
        keyboardType: widget.textInputType ?? TextInputType.text,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(widget.nextNode);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(style: BorderStyle.none, width: 0),
          ),
          isDense: true,
          helperText: null,
          hintText: widget.hintText,
          fillColor: widget.fillColor ?? Theme.of(context).cardColor,
          hintStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: Dimensions.fontSizeSmall, color: ColorResources.colorGreyChateau),
          filled: true,
           counterText: '',
          prefixIcon: widget.isShowPrefixIcon!
              ? Padding(
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
                  child: Image.asset(widget.prefixIconUrl!),
                )
              : const SizedBox.shrink(),
          prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),
          suffixIcon: widget.isShowSuffixIcon!
              ? widget.isPassword!
                  ? IconButton(
                      icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility , color: Theme.of(context).hintColor.withOpacity(.3)),
                      onPressed: _toggle)
                  : widget.isIcon!
                      ? Padding(
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge, right: Dimensions.paddingSizeSmall),
                          child: Image.asset(
                            widget.suffixIconUrl!,
                            width: 15,
                            height: 15,
                          ),
                        )
                      : null
              : null,
        ),
        onTap:(){
widget.onTap!();
        } 
        // onSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

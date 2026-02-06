import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ozon/presentation/resources/color_manager.dart';
//ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.padding,
      this.shape,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.keyboardType,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines,
      this.hintText,
      this.labelText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.onFieldSubmitted,
      this.suffixConstraints,
      this.validator,
        this.isEditable= true
      });

  TextFormFieldPadding? padding;

  TextFormFieldShape? shape;
  bool? isEditable;

  TextFormFieldVariant? variant;

  TextFormFieldFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;
  TextInputType?keyboardType;

  FocusNode? focusNode;

  bool? isObscureText;

  TextInputAction? textInputAction;

  int? maxLines;
  String? labelText;

  String? hintText;

  Widget? prefix;
void Function(String)? onFieldSubmitted;
  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return _buildTextFormFieldWidget(context);
  }

  _buildTextFormFieldWidget(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: maxLines != null? 200.w:40.w,


      child: TextFormField(
        controller: controller,
        enabled: isEditable,
        onFieldSubmitted:onFieldSubmitted ,
        keyboardType: keyboardType??TextInputType.text,
        focusNode: focusNode,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: ColorManager.secondaryBlack,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.normal

        ),
        
        // style:TextStyle(
        //   color: ColorManager.black900,
        //   fontSize: getFontSize(
        //     12,
        //   ),
        //   fontFamily: 'Poppins',
        //   fontWeight: FontWeight.w400,
        // ) ,
        
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(context),
        validator: validator,
      ),
    );
  }

  _buildDecoration(BuildContext context) {
    return InputDecoration(
      hintText: hintText ?? "",
      labelText: labelText,
      
      hintStyle: _setFontStyle(context),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      labelStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
          color: ColorManager.gray800,
          fontSize: ScreenUtil().setSp(12),
          fontWeight: FontWeight.w400

      ),



      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,

    );
  }

  _setFontStyle(BuildContext context) {
    switch (fontStyle) {
      case TextFormFieldFontStyle.PoppinsRegular12:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
    color: ColorManager.gray401,
    fontSize: ScreenUtil().setSp(12),
    fontWeight: FontWeight.w400

    );

      case TextFormFieldFontStyle.SourceSansProRegular14:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color: ColorManager.gray500,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.w400

        );

      case TextFormFieldFontStyle.PoppinsRegular12primary:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color: ColorManager.primary,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.w400

        );

      default:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color: ColorManager.gray403,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.w400

        );


    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.RoundedBorder20:
        return BorderRadius.circular(
          20.w
        );
      default:
        return BorderRadius.circular(
          15.w
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.FillWhiteA700:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.OutlineBluegray50033:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      default:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.gray300,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case TextFormFieldVariant.FillWhiteA700:
        return ColorManager.whiteA700;
      case TextFormFieldVariant.OutlineBluegray50033:
        return ColorManager.whiteA700;
      default:
        return null;
    }
  }

  _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.UnderLineGray300:
        return false;
      case TextFormFieldVariant.FillWhiteA700:
        return true;
      case TextFormFieldVariant.OutlineBluegray50033:
        return true;
      default:
        return false;
    }
  }

  _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingAll20:
      return  EdgeInsets.all(20.w);
      case TextFormFieldPadding.PaddingAll10:
        return  EdgeInsets.all(0.w);

      default:
        return EdgeInsets.all(15.w);
    }
  }
}

enum TextFormFieldPadding {
  PaddingAll15,
  PaddingAll20,
  PaddingAll10,
}
enum TextFormFieldShape {
  RoundedBorder20,
  RoundedBorder15,
}
enum TextFormFieldVariant {
  UnderLineGray300,
  FillWhiteA700,
  OutlineBluegray50033,
}
enum TextFormFieldFontStyle {
  PoppinsRegular10,
  PoppinsRegular12,
  SourceSansProRegular14,
  PoppinsRegular12primary,
}

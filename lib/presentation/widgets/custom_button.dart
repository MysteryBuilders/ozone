import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ozon/presentation/resources/color_manager.dart';
//ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton(
      {this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.onTap,
      this.width,
      this.margin,
      this.prefixWidget,
      this.suffixWidget,
      this.text});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  VoidCallback? onTap;

  double? width;

  EdgeInsetsGeometry? margin;

  Widget? prefixWidget;

  Widget? suffixWidget;

  String? text;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildButtonWidget(context),
          )
        : _buildButtonWidget(context);
  }

  _buildButtonWidget(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: margin,
        padding: _setPadding(),
        decoration: _buildDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixWidget ?? SizedBox(),
            Text(
              text ?? "",
              textAlign: TextAlign.center,
              style: _setFontStyle(context),
            ),
            suffixWidget ?? SizedBox(),
          ],
        ),
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      borderRadius: _setBorderRadius(),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll10:
        return EdgeInsets.all(10.w);
      case ButtonPadding.PaddingAll4:
        return EdgeInsets.all(4.w);
      case ButtonPadding.PaddingAll20:
          return EdgeInsets.all(20.w);
      default:
        return EdgeInsets.all(14.w);
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillWhiteA700:
        return ColorManager.whiteA700;
      case ButtonVariant.FillGray102:
        return ColorManager.gray102;
      case ButtonVariant.FillBlueA200:
        return ColorManager.blueA200;
      case ButtonVariant.FillGreen801:
        return ColorManager.green801;
      case ButtonVariant.FillBlack900:
        return ColorManager.primary;
      case ButtonVariant.FillAmber900:
        return ColorManager.amber900;
      case ButtonVariant.FillGrayDark:
        return ColorManager.gray400;
      case ButtonVariant.FillAmber90063:
        return ColorManager.amber90063.withOpacity(.2);
      default:
        return ColorManager.black;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.RoundedBorder10:
        return BorderRadius.circular(
          10.w
        );
      case ButtonShape.CircleBorder15:
        return BorderRadius.circular(
          15.w
        );
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          20.w
        );
    }
  }

  _setFontStyle(BuildContext context) {
    switch (fontStyle) {
      case ButtonFontStyle.PoppinsRegular12:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.whiteA700,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.w400
        );

      case ButtonFontStyle.PoppinsMedium12:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.whiteA700,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.w500
        );

      case ButtonFontStyle.PoppinsMedium14:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.primary,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w500
        );

      case ButtonFontStyle.PoppinsMedium14RedA700:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.redA700,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w500
        );

      case ButtonFontStyle.PoppinsSemiBold14BlueA400:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.blueA400,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600
        );


      case ButtonFontStyle.PoppinsSemiBold14RedA700:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.redA700,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600
        );

      case ButtonFontStyle.PoppinsSemiBold14primary:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.primary,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600
        );

      case ButtonFontStyle.PoppinsRegular14:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.whiteA700,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w400
        );

      case ButtonFontStyle.PoppinsRegular14primary:

        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.primary,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w400
        );

      case ButtonFontStyle.PoppinsRegular12Amber900:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.amber900,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.w400
        );

      case ButtonFontStyle.PoppinsMedium14WhiteA700:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.whiteA700,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w500
        );

      case ButtonFontStyle.PoppinsSemiBold14Amber900:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.amber900,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600
        );

      case ButtonFontStyle.PoppinsSemiBold12:

        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.whiteA700,
            fontSize: ScreenUtil().setSp(12),
            fontWeight: FontWeight.w600
        );
      case ButtonFontStyle.blackSemiBold:

        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.black,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600
        );
      case ButtonFontStyle.whiteSemiBold:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.whiteA700,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600
        );
      default:
        return Theme.of(context).textTheme.displayMedium!.copyWith(
            color:  ColorManager.whiteA700,
            fontSize: ScreenUtil().setSp(14),
            fontWeight: FontWeight.w600
        );

    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder20,
  RoundedBorder10,
  CircleBorder15,
}
enum ButtonPadding {
  PaddingAll14,
  PaddingAll10,
  PaddingAll4,
  PaddingAll20,
}
enum ButtonVariant {
  Fillprimary,
  FillWhiteA700,
  FillGray102,
  FillBlueA200,
  FillGreen801,
  FillBlack900,
  FillAmber900,
  FillAmber90063,
  FillGrayDark,
}
enum ButtonFontStyle {
  PoppinsSemiBold14,
  PoppinsRegular12,
  PoppinsMedium12,
  PoppinsMedium14,
  PoppinsMedium14RedA700,
  PoppinsSemiBold14BlueA400,
  PoppinsSemiBold14RedA700,
  PoppinsSemiBold14primary,
  PoppinsRegular14,
  PoppinsRegular14primary,
  PoppinsRegular12Amber900,
  PoppinsMedium14WhiteA700,
  PoppinsSemiBold14Amber900,
  PoppinsSemiBold12,
  blackSemiBold,
  whiteSemiBold
}

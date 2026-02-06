import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ozon/presentation/resources/color_manager.dart';
//ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.height,
      this.width,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? height;

  double? width;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        constraints: BoxConstraints(
          minHeight: height??0,
          minWidth: width??0,
        ),
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width:  height??0,
          height: width??0,
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      border: _setBorder(),
      borderRadius: _setBorderRadius(),
      boxShadow: _setBoxShadow(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll12:
        return EdgeInsets.all(12.w);
      default:
        return EdgeInsets.all(8.w);
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.Fillprimary63:
        return ColorManager.primary63.withOpacity(0.2);
      case IconButtonVariant.FillAmber90063:
        return ColorManager.amber90063.withOpacity(0.2);
      case IconButtonVariant.FillGray40075:
        return ColorManager.gray40075;
      case IconButtonVariant.OutlineRed4004c:
        return ColorManager.primary6c;
      case IconButtonVariant.OutlineRed100:
        return null;
      default:
        return ColorManager.whiteA70075;
    }
  }

  _setBorder() {
    switch (variant) {
      case IconButtonVariant.OutlineRed100:
        return Border.all(
          color: ColorManager.red100,
          width: 2.w,
        );
      case IconButtonVariant.FillWhiteA70075:
      case IconButtonVariant.Fillprimary63:
      case IconButtonVariant.FillAmber90063:
      case IconButtonVariant.FillGray40075:
      case IconButtonVariant.OutlineRed4004c:
        return null;
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.CircleBorder25:
        return BorderRadius.circular(
         25.w,
        );
      case IconButtonShape.CircleBorder25:
        return BorderRadius.circular(
          45.w,
        );
      case IconButtonShape.RoundedBorder15:
        return BorderRadius.circular(
          15.w,
        );
      default:
        return BorderRadius.circular(
         20.w,
        );
    }
  }

  _setBoxShadow() {
    switch (variant) {
      case IconButtonVariant.OutlineRed4004c:
        return [
          BoxShadow(
            color: ColorManager.red4004c,
            spreadRadius: 0.0,
            blurRadius:10.w,
            offset: Offset(
              0,
              4,
            ),
          )
        ];
      case IconButtonVariant.FillWhiteA70075:
      case IconButtonVariant.OutlineRed100:
      case IconButtonVariant.Fillprimary63:
      case IconButtonVariant.FillAmber90063:
      case IconButtonVariant.FillGray40075:
        return null;
      default:
        return null;
    }
  }
}

enum IconButtonShape {
  CircleBorder20,
  CircleBorder25,
  RoundedBorder15,
  CircleBorder40,
}
enum IconButtonPadding {
  PaddingAll8,
  PaddingAll12,
}
enum IconButtonVariant {
  FillWhiteA70075,
  OutlineRed100,
  Fillprimary63,
  FillAmber90063,
  FillGray40075,
  OutlineRed4004c,
}

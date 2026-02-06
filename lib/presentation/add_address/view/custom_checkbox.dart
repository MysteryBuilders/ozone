import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ozon/app/app.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
//ignore: must_be_immutable
class CustomCheckbox extends StatelessWidget {
  CustomCheckbox(
      {this.shape,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.padding,
      this.iconSize,
      this.value,
      this.onChange,
      this.text});

  CheckboxShape? shape;

  CheckboxVariant? variant;

  CheckboxFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? padding;

  double? iconSize;

  bool? value;

  Function(bool)? onChange;

  String? text;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildCheckboxWidget(context),
          )
        : _buildCheckboxWidget(context);
  }

  _buildCheckboxWidget(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          value = !(value!);
          onChange!(value!);
        },
        child: Row(
          children: [
            SizedBox(
              height: iconSize!.h,
              width: iconSize!.w,
              child: Container(
                 decoration: BoxDecoration(color:variant== CheckboxVariant.FillAmber900? ColorManager.amber900.withOpacity(.2):Colors.transparent,
                                            borderRadius: BorderRadius.circular(5)
                                            ),
                
                child: Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    
                 side: BorderSide(width: 1,
                 color:variant== CheckboxVariant.FillAmber900?Colors.transparent: ColorManager.gray800, ),
                    shape: _setShape(),
                    
                    activeColor:variant== CheckboxVariant.FillAmber900?
                     Colors.transparent:Color(0xFFFF7400),
                    checkColor: variant== CheckboxVariant.FillAmber900?ColorManager.primary:
                    Colors.white,
                    value: value ?? false,
                    onChanged: (value) {
                      onChange!(value!);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              // padding: getPadding(
              //   left: 10,
              // ),
              padding: EdgeInsetsDirectional.only(start: 10.w),
              child: Text(
                text ?? "",
                textAlign: TextAlign.center,
                style:  Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorManager.secondaryBlack,
                    fontSize: ScreenUtil().setSp(12),
                    fontWeight: FontWeight.normal


                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(
          3.w,
        );
    }
  }

  _setShape() {
    switch (variant) {
      case CheckboxVariant.FillAmber900:
        return RoundedRectangleBorder(
          
          borderRadius: _setOutlineBorderRadius(),
        );
      case CheckboxVariant.OutlineGray800:
        return RoundedRectangleBorder(
          side: BorderSide(
            color: ColorManager.gray800,
            width: 1.5,
          ),
          borderRadius: _setOutlineBorderRadius(),
        );
      default:
        return RoundedRectangleBorder(
          side: BorderSide(
            color: ColorManager.gray403,
            width: 0.5,
          ),
          borderRadius: _setOutlineBorderRadius(),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      default:
        return TextStyle(
          color: ColorManager.gray800,
          fontSize: 12.sp,

          fontWeight: FontWeight.w400,
        );
    }
  }
}

enum CheckboxShape { RoundedBorder7 }
enum CheckboxVariant { OutlineGray403, FillAmber900, OutlineGray800 }
enum CheckboxFontStyle { PoppinsRegular12 }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/presentation/resources/color_manager.dart';

import '../resources/langauge_manager.dart';


// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {required this.height,
      this.styleType,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions});

  double height;

  Style? styleType;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  bool? centerTitle;

  List<Widget>? actions;
  bool isRtl(BuildContext context) {
    return context.locale == ARABIC_LOCAL;
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading:isRtl(context)? RotatedBox(
        quarterTurns: 2,
        child: leading):leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        ScreenUtil().screenWidth,
        height,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgFillWhiteA700:
        return Container(
          height: 113.h,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: ColorManager.whiteA700,
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFillWhiteA700,
}

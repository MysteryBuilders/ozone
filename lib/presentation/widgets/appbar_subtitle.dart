import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/presentation/resources/color_manager.dart';


// ignore: must_be_immutable
class AppbarSubtitle extends StatelessWidget {
  AppbarSubtitle({required this.text, this.margin, this.onTap});

  String text;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          // style: AppStyle.txtPoppinsMedium18.copyWith(
          //   color: ColorManager.black900,
          // ),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: ColorManager.black900,
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w500

          ),
        ),
      ),
    );
  }
}

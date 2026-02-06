

import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/presentation/resources/styles_manager.dart';
import 'package:ozon/presentation/resources/values_manager.dart';


import 'color_manager.dart';
import 'font_manager.dart';
class CustomStyles  {
  static TextStyle display5(BuildContext context) {
   return  TextStyle(decoration: TextDecoration.underline,
        decorationColor: ColorManager.yellow,
        fontSize: ScreenUtil().setSp(17),
        color: ColorManager.yellow,
        fontWeight: FontWeight.w500);
  }
}
ThemeData getApplicationTheme() {
  return ThemeData(

    // main colors
    fontFamily: 'Montserrat',

    primaryColor: ColorManager.primary,

    primaryColorLight: ColorManager.primary,
    primaryColorDark: ColorManager.primary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    scaffoldBackgroundColor: ColorManager.primary,

    // ripple effect color
    // cardview theme
    cardTheme: CardThemeData(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),

    // app bar theme
    appBarTheme: AppBarTheme(


        centerTitle: true,
        color: ColorManager.primary,


        shadowColor: ColorManager.lightPrimary,
        iconTheme: IconThemeData(

          color: Colors.black,

          size: 30.w// Set the color of the back button
        ),
        titleTextStyle:
            getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)),

    // button theme

    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.yellow,
        splashColor: ColorManager.lightPrimary),


    // elevated button them
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.primary, fontSize: ScreenUtil().setSp(18)),

            backgroundColor: ColorManager.primary,
            foregroundColor: ColorManager.primary,


            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.w)))),

    textTheme: TextTheme(

        displayLarge: getSemiBoldStyle(
            color: ColorManager.white, fontSize: ScreenUtil().setSp(16)),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.primary, fontSize:ScreenUtil().setSp(16)),
        headlineMedium: getRegularStyle(
            color: ColorManager.yellow, fontSize: ScreenUtil().setSp(14)),
        titleMedium:
            getMediumStyle(color: ColorManager.yellow, fontSize: ScreenUtil().setSp(16)),
        titleSmall:
            getRegularStyle(color: ColorManager.white, fontSize: ScreenUtil().setSp(16)),
        bodyLarge: getRegularStyle(color: ColorManager.white,fontSize: ScreenUtil().setSp(20)),
        bodySmall: getRegularStyle(color: ColorManager.white,fontSize: ScreenUtil().setSp(16)),
        bodyMedium: getRegularStyle(color: ColorManager.white, fontSize: ScreenUtil().setSp(16)),
        labelSmall:
            getLightStyle(color: ColorManager.white, fontSize: ScreenUtil().setSp(16))),


    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(

        // content padding
        contentPadding:  EdgeInsets.all(10.w),
        // hint style
        hintStyle:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s14),
        labelStyle:
            getMediumStyle(color: ColorManager.white, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error,fontSize: FontSize.s12),


        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.white, width: AppSize.s0),
            borderRadius:  BorderRadius.all(Radius.circular(AppSize.s2))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.white, width: AppSize.s0),
            borderRadius:  BorderRadius.all(Radius.circular(AppSize.s2))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius:  BorderRadius.all(Radius.circular(AppSize.s2))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.white, width: AppSize.s0),
            borderRadius:  BorderRadius.all(Radius.circular(AppSize.s2)))),
    // label style
  );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../../app/constants.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/app_decoration.dart';
class ProfileGuestView extends StatelessWidget {
  const ProfileGuestView({super.key});

  @override
  Widget build(BuildContext context) {
    final InAppReview _inAppReview = InAppReview.instance;

    return Container(
      margin: EdgeInsets.all(20.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.symmetric(vertical: 20.w),
            alignment: AlignmentDirectional.centerStart,
            child: Text('${AppStrings.welcomeCrane.tr()}',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(18)
              ),),
          ),
          SizedBox(height: 20.h,),
          Expanded(
              flex:1,
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: AppDecoration
                    .fillWhiteA700
                    .copyWith(
                    borderRadius:
                    BorderRadiusStyle
                        .roundedBorder30),
                child: Column(
                  children: [
                    Container(
                        height:
                        1.h,
                        width: 40.w,
                        margin: EdgeInsets.only(top: 15.h),

                        decoration: BoxDecoration(
                            color: ColorManager
                                .gray80063)),
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(height: 10.h,),





                        Container(
                            height: 50.w,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: AlignmentDirectional.center,
                            child: Stack(
                              children: [
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  top: 0,
                                  bottom: 0,
                                  start: 0,
                                  end: 0,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                              Container(
                                                height: ScreenUtil().screenHeight,
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Icon(
                                                  Icons.contact_mail_outlined,
                                                  size: 24.w,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),
                                              Container(
                                                height: ScreenUtil().screenHeight,
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Text(

                                                    AppStrings.contactUs.tr(),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign
                                                        .center,
                                                    style:
                                                    Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                      color: ColorManager.mainBlack,
                                                      fontSize: 14.sp,

                                                      fontWeight: FontWeight.normal,
                                                    )),
                                              )
                                            ]),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                          size: 18.w,
                                          color: ColorManager.primary,
                                        ),

                                      ]),
                                ),
                                Positioned.directional(textDirection: Directionality.of(context),
                                    top: 0,
                                    start: 0,
                                    end: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: (){
                                        Map<String,dynamic> map ={};
                                        map ['title']= AppStrings.contactUs.tr();


                                        // Navigator.pushNamed(context, Routes.contactUsRoute);
                                        Navigator.pushNamed(context, Routes.contactUsRoute,arguments: map);
                                      },
                                      child: Container(
                                        color: Color(0x00FFFFFF),

                                      ),
                                    ))
                              ],
                            )),
                        SizedBox(height: 5.h,),
                        Container(
                            height:
                            0.5,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                                color: ColorManager
                                    .gray300)),
                        SizedBox(height: 5.h,),
                        Container(
                            height: 50.w,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: AlignmentDirectional.center,
                            child: Stack(
                              children: [
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  top: 0,
                                  bottom: 0,
                                  start: 0,
                                  end: 0,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                              Container(
                                                height: ScreenUtil().screenHeight,
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Icon(
                                                  Icons.privacy_tip_outlined,
                                                  size: 24.w,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),
                                              Container(
                                                height: ScreenUtil().screenHeight,
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Text(

                                                    AppStrings.privacy.tr(),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign
                                                        .center,
                                                    style:
                                                    Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                      color: ColorManager.mainBlack,
                                                      fontSize: 14.sp,

                                                      fontWeight: FontWeight.normal,
                                                    )),
                                              )
                                            ]),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                          size: 18.w,
                                          color: ColorManager.primary,
                                        ),

                                      ]),
                                ),
                                Positioned.directional(textDirection: Directionality.of(context),
                                    top: 0,
                                    start: 0,
                                    end: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: (){
                                        Map<String,dynamic> map ={};
                                        map['url'] = Constants.privacyUrl;
                                        map ['title']= AppStrings.privacy.tr();
                                        Navigator.pushNamed(context, Routes.privacyRoute,arguments: map);

                                      },
                                      child: Container(
                                        color: Color(0x00FFFFFF),

                                      ),
                                    ))
                              ],
                            )),
                        SizedBox(height: 5.h,),
                        Container(
                            height:
                            0.5,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                                color: ColorManager
                                    .gray300)),
                        SizedBox(height: 5.h,),
                        Container(
                            height: 50.w,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: AlignmentDirectional.center,
                            child: Stack(
                              children: [
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  top: 0,
                                  bottom: 0,
                                  start: 0,
                                  end: 0,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                              Container(
                                                height: ScreenUtil().screenHeight,
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Icon(
                                                  Icons.star_rate_outlined,
                                                  size: 24.w,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),
                                              Container(
                                                height: ScreenUtil().screenHeight,
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Text(

                                                    AppStrings.rate.tr(),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign
                                                        .center,
                                                    style:
                                                    Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                      color: ColorManager.mainBlack,
                                                      fontSize: 14.sp,

                                                      fontWeight: FontWeight.normal,
                                                    )),
                                              )
                                            ]),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                          size: 18.w,
                                          color: ColorManager.primary,
                                        ),

                                      ]),
                                ),
                                Positioned.directional(textDirection: Directionality.of(context),
                                    top: 0,
                                    start: 0,
                                    end: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: ()async{
                                        final isAvailable = await _inAppReview.isAvailable();
                                        if (isAvailable) {
                                          _inAppReview.requestReview();
                                        }   },
                                      child: Container(
                                        color: Color(0x00FFFFFF),

                                      ),
                                    ))
                              ],
                            )),
                        SizedBox(height: 5.h,),
                        Container(
                            height:
                            0.5,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                                color: ColorManager
                                    .gray300)),

                        SizedBox(height: 5.h,),
                        Container(
                            height: 50.w,
                            width: ScreenUtil().screenWidth,
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            alignment: AlignmentDirectional.center,
                            child: Stack(
                              children: [
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  top: 0,
                                  bottom: 0,
                                  start: 0,
                                  end: 0,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [
                                              Container(
                                                height: ScreenUtil().screenHeight,
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Icon(
                                                  Icons.login_outlined,
                                                  size: 24.w,
                                                  color: ColorManager.primary,
                                                ),
                                              ),
                                              SizedBox(width: 10.w,),
                                              Container(
                                                height: ScreenUtil().screenHeight,
                                                alignment: AlignmentDirectional.centerStart,
                                                child: Text(

                                                    AppStrings.login.tr(),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    textAlign: TextAlign
                                                        .center,
                                                    style:
                                                    Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                      color: ColorManager.mainBlack,
                                                      fontSize: 14.sp,

                                                      fontWeight: FontWeight.normal,
                                                    )),
                                              )
                                            ]),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                          size: 18.w,
                                          color: ColorManager.primary,
                                        ),

                                      ]),
                                ),
                                Positioned.directional(textDirection: Directionality.of(context),
                                    top: 0,
                                    start: 0,
                                    end: 0,
                                    bottom: 0,
                                    child: GestureDetector(
                                      onTap: ()async{
                                        print("login");
                                    Navigator.of(context,rootNavigator: true).pushNamed( Routes.loginRoute);

                                      },
                                      child: Container(
                                        color: Color(0x00FFFFFF),

                                      ),
                                    ))
                              ],
                            )),





                      ],
                    )


                  ],
                ),

              ))


        ],

      ),
    );
  }
}

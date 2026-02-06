import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/main/bloc/delete_account_bloc/delete_account_bloc.dart';
import 'package:ozon/presentation/main/bloc/user_bloc/user_bloc.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../../app/app_prefrences.dart';
import '../../../../app/user_prefrences.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/common_image_view.dart';
import '../../../widgets/app_decoration.dart';

class ProfileUserView extends StatelessWidget {
  const ProfileUserView({super.key});


  @override
  Widget build(BuildContext context) {
    final InAppReview _inAppReview = InAppReview.instance;
    UserBloc userBloc = GetIt.I<UserBloc>();
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();
    AppPreferences appPreferences = instance<AppPreferences>();
    DeleteAccountBloc deleteAccountBloc = instance<DeleteAccountBloc>();
    String? userToken="";
    return BlocBuilder<UserBloc, UserState>(
      bloc: userBloc..add(UserInfoFetched(userPreferences.userToken!)),
      builder: (context, state) {
       if(state is UserLoading){
         return Container(
           alignment: AlignmentDirectional.center,
           child:    SizedBox(
               height: 150.w,
               width: 150.w,
               child: Lottie.asset(ImageAssets.loadingView)),

         );
       }else if(state is UserFailure){
         return Container(
           color: Colors.white,
           alignment: AlignmentDirectional.center,
           child: Text(state.message,
             style: Theme.of(context).textTheme.titleLarge!.copyWith(
                 color: Colors.black,
                 fontSize: ScreenUtil().setSp(18),
                 fontWeight: FontWeight.w500

             ),),
         );

       }else if(state is UserSuccess){
         return
           Container(
             margin: EdgeInsets.all(20.w),
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsetsDirectional.symmetric(vertical: 20.w),
                   alignment: AlignmentDirectional.centerStart,
                   child: Text('${AppStrings.welcomeCrane.tr()} ${state.userInfoModel.firstname} ${state.userInfoModel.lastname}',
                     textAlign: TextAlign.start,
                     style: Theme.of(context).textTheme.displayMedium!.copyWith(
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                     fontSize: ScreenUtil().setSp(18)
                   ),),
                 ),
                 SizedBox(height: 20.h,),
                 Expanded(
                    
                     child: Container(
                       color: ColorManager.white,


                       child: Column(
                         children: [
                           Container(
                               height:
                               0.5,
                               width: 40.w,
                               margin: EdgeInsets.only(top: 15.h),

                               decoration: BoxDecoration(
                                   color: ColorManager
                                       .gray300)),
                           Expanded(
                             child: 
                             Container(
                               child: SingleChildScrollView(
                                 physics: AlwaysScrollableScrollPhysics(),
                                 child: Column(
                               
                               
                                   children: [
                                     SizedBox(height: 10.h,),
                                     Container(
                                        height: 40.w,
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
                                                                 Icons.person_outlined,
                                                             size: 24.w,
                                                               color: ColorManager.primary,
                                                             ),
                                                           ),
                                                           SizedBox(width: 10.w,),
                                                           Container(
                                                             height: ScreenUtil().screenHeight,
                                                             alignment: AlignmentDirectional.centerStart,
                                                             child: Text(
                               
                                                                 AppStrings.profile.tr(),
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
                                                     print("ma,,,e");
                                                     Map<String,dynamic> map ={};
                                                     map['userInfoModel'] = state.userInfoModel;
                                                     // map['title']= AppStrings.profile.tr();
                                                     // Navigator.pushNamed(context, Routes.userProfileRoute,arguments: map);
                                                     Navigator.pushNamed( context,Routes.userProfileRoute,arguments: map);
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
                                                               Icons.password_outlined,
                                                               size: 24.w,
                                                               color: ColorManager.primary,
                                                             ),
                                                           ),
                                                           SizedBox(width: 10.w,),
                                                           Container(
                                                             height: ScreenUtil().screenHeight,
                                                             alignment: AlignmentDirectional.centerStart,
                                                             child: Text(
                               
                                                                 AppStrings.resetPassword.tr(),
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
                                                     map['userInfoModel'] = state.userInfoModel;
                                                     map['title']= AppStrings.resetPassword.tr();
                                                     // Routes.navigateTo( Routes.setNewPasswordRoute,arguments: map);
                                                   Navigator.pushNamed(context, Routes.setNewPasswordRoute,arguments: map);
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
                                     //
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
                                                               Icons.shopping_cart_outlined,
                                                               size: 24.w,
                                                               color: ColorManager.primary,
                                                             ),
                                                           ),
                                                           SizedBox(width: 10.w,),
                                                           Container(
                                                             height: ScreenUtil().screenHeight,
                                                             alignment: AlignmentDirectional.centerStart,
                                                             child: Text(

                                                                 AppStrings.orders.tr(),
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
                                                     Map<String,dynamic> map = {};
                                                     map['fromCart'] = false;
                                                     map['title']= AppStrings.orders.tr();
                                                     // Routes.navigateTo( Routes.myOrdersRoute,arguments: map);
                                                      Navigator.pushNamed(context, Routes.myOrdersRoute);
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
                                     //
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
                                                               Icons.pin_drop_outlined,
                                                               size: 24.w,
                                                               color: ColorManager.primary,
                                                             ),
                                                           ),
                                                           SizedBox(width: 10.w,),
                                                           Container(
                                                             height: ScreenUtil().screenHeight,
                                                             alignment: AlignmentDirectional.centerStart,
                                                             child: Text(
                               
                                                                 AppStrings.addresses.tr(),
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
                                                     Map<String,dynamic> map = {};
                                                     map['fromCart'] = false;
                                                     map['title']= AppStrings.addresses.tr();
                                                     // Routes.navigateTo( Routes.addressRoute,arguments: map);
                                                     Navigator.pushNamed(context, Routes.addressRoute,arguments: map);
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
                                     //
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
                                                               Icons.favorite_border_outlined,
                                                               size: 24.w,
                                                               color: ColorManager.primary,
                                                             ),
                                                           ),
                                                           SizedBox(width: 10.w,),
                                                           Container(
                                                             height: ScreenUtil().screenHeight,
                                                             alignment: AlignmentDirectional.centerStart,
                                                             child: Text(
                               
                                                                 AppStrings.favorite.tr(),
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
                                                     map['title']= AppStrings.wishList.tr();
                                                     // Routes.navigateTo( Routes.wishListRoute,arguments: map);
                                                     Navigator.pushNamed(context, Routes.wishListRoute);
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
                                     //
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
                                                     map['title']= AppStrings.contactUs.tr();
                                                     // Routes.navigateTo( Routes.contactUsRoute,arguments: map);
                                                    Navigator.pushNamed(context, Routes.contactUsRoute);
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
                                                     map['title']= AppStrings.privacy.tr();
                                                     Navigator.pushNamed(context, Routes.privacyRoute,arguments: map);
                                                   // Navigator.pushNamed(context, Routes.privacyRoute);
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
                                                               Icons.logout_outlined,
                                                               size: 24.w,
                                                               color: ColorManager.primary,
                                                             ),
                                                           ),
                                                           SizedBox(width: 10.w,),
                                                           Container(
                                                             height: ScreenUtil().screenHeight,
                                                             alignment: AlignmentDirectional.centerStart,
                                                             child: Text(
                               
                                                                 AppStrings.logout.tr(),
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
                                                     _showLogoutBottomSheet(context, appPreferences, userPreferences);
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
                                                               Icons.delete,
                                                               size: 24.w,
                                                               color: ColorManager.primary,
                                                             ),
                                                           ),
                                                           SizedBox(width: 10.w,),
                                                           Container(
                                                             height: ScreenUtil().screenHeight,
                                                             alignment: AlignmentDirectional.centerStart,
                                                             child: Text(
                               
                                                                 AppStrings.deleteAccount.tr(),
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
                                                     _showDeleteBottomSheet(context,state.userInfoModel!.id!,appPreferences,userPreferences,deleteAccountBloc);
                                                   },
                                                   child: Container(
                                                     color: Color(0x00FFFFFF),
                               
                                                   ),
                                                 ))
                                           ],
                                         )),
                                     Container(height: 80.w,)
                               
                                   ],
                                 ),
                               ),
                             ),
                           )


                         ],
                       ),

                     ))


               ],

             ),
           );

       }else{
         return Container();
       }
      },
    );
  }
  Future<void> _showLogoutDialog(BuildContext context,AppPreferences appPreferences,UserPreferences userPreferences) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          content: Container(
            height: 50.h,
            alignment: AlignmentDirectional.center,
            child: Text(AppStrings.logoutMessage.tr(),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w500,

              ),),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text(AppStrings.yes.tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Color(0xFF5CB852),
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(18),

                ),),
              onPressed: () {
                appPreferences.setUserToken("");
                userPreferences.userToken = "";
                appPreferences.setEmail("");

             Navigator.of(context,rootNavigator: true).pushReplacementNamed( Routes.mainRoute);

                // Navigator.pushReplacementNamed(context, Routes.mainRoute);


              },
            ),
            TextButton(
              child:  Text(AppStrings.no.tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Color(0xFFDB3562),
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(18),

                ),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showDeleteAccountDialog(BuildContext context,int userId,AppPreferences appPreferences,UserPreferences userPreferences,DeleteAccountBloc deleteAccountBloc ) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return

          AlertDialog(

            content: BlocListener<DeleteAccountBloc, DeleteAccountState>(
              bloc: deleteAccountBloc,
  listener: (context, state) {
                if(state is DeleteAccountLoading){
                  showLoadingDialog(context);
                }else if(state is DeleteAccountFailure){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }else if(state is DeleteAccountSuccess){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  appPreferences.setUserToken("");
                  userPreferences.userToken = "";
                  appPreferences.setEmail("");

                 Navigator.of(context,rootNavigator: true).pushReplacementNamed( Routes.mainRoute);

                }
    // TODO: implement listener
  },
  child: Container(
              height: 50.h,
              alignment: AlignmentDirectional.center,
              child: Text(AppStrings.deleteMessage.tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w500,

                ),),
            ),
),
            actions: <Widget>[
              TextButton(
                child:  Text(AppStrings.yes.tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Color(0xFF5CB852),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(18),

                  ),),
                onPressed: () {
                  deleteAccountBloc.add(DeleteAccountButtonPressed(userId: userId,authorization:Constants.headerValue));

                },
              ),
              TextButton(
                child:  Text(AppStrings.no.tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Color(0xFFDB3562),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(18),

                  ),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
      },
    );
  }


  void _showLogoutBottomSheet(BuildContext context,AppPreferences appPreferences,UserPreferences userPreferences){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Important for wrap content behavior
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context){
          return Wrap(
            children: [
              Container(height: 40.w,
                width: ScreenUtil().screenWidth,
                alignment: Alignment.center,

                child: Text(AppStrings.logout.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal
                  ),),),
              Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),


              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
                child: Text(AppStrings.logoutMessage.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: ColorManager.secondaryBlack,
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.normal,

                  ),),
              ),
              SizedBox(height: 20.w,),
              Container(height: 40.w,
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(flex:1,child: InkWell(
                      onTap: (){

                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: ColorManager.primary,
                                width: 1
                            )
                        ),
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.no.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.primary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal
                          ),),
                      ),
                    )),
                    SizedBox(width: 20.w,),
                    Expanded(flex:1,child: InkWell(
                      onTap: (){
                        appPreferences.setUserToken("");
                        userPreferences.userToken = "";
                        appPreferences.setEmail("");

                        Navigator.of(context,rootNavigator: true).pushReplacementNamed( Routes.mainRoute);



                      },
                      child: Container(
                        color: ColorManager.primary,
                        alignment: AlignmentDirectional.center,
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.yes.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal
                          ),),
                      ),
                    )),


                  ],
                ),),
              Container(height: 30.w,
                color: Color(0x00000000),)


            ],
          );
        }
    );


  }
  void _showDeleteBottomSheet(BuildContext context,int userId,AppPreferences appPreferences,UserPreferences userPreferences,DeleteAccountBloc _deleteAccountBloc ){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Important for wrap content behavior
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context){
          return Wrap(
            children: [
              Container(height: 40.w,
                width: ScreenUtil().screenWidth,
                alignment: Alignment.center,

                child: Text(AppStrings.deleteAccount.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal
                  ),),),
              Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),


              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
                child: Text(AppStrings.deleteMessage.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: ColorManager.secondaryBlack,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.normal,

                  ),),
              ),
              SizedBox(height: 20.w,),
              Container(height: 40.w,
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(flex:1,child: InkWell(
                      onTap: (){

                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: ColorManager.primary,
                                width: 1
                            )
                        ),
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.no.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.primary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal
                          ),),
                      ),
                    )),
                    SizedBox(width: 20.w,),
                    Expanded(flex:1,child: InkWell(
                      onTap: (){
                        _deleteAccountBloc.add(DeleteAccountButtonPressed(userId: userId,authorization:Constants.headerValue));


                      },
                      child: BlocListener<DeleteAccountBloc, DeleteAccountState>(
                        bloc: _deleteAccountBloc,
                        listener: (context, state) {
                          if(state is DeleteAccountLoading){
                            showLoadingDialog(context);
                          }else if(state is DeleteAccountFailure){
                            Navigator.pop(context);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }else if(state is DeleteAccountSuccess){
                            Navigator.pop(context);
                            Navigator.pop(context);
                            appPreferences.setUserToken("");
                            userPreferences.userToken = "";
                            appPreferences.setEmail("");

                            Navigator.of(context,rootNavigator: true).pushReplacementNamed( Routes.mainRoute);

                          }
                          // TODO: implement listener
                        },
                        child: Container(
                          color: ColorManager.primary,
                          alignment: AlignmentDirectional.center,
                          height: ScreenUtil().screenHeight,
                          child: Text(AppStrings.yes.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal
                            ),),
                        ),
                      ),
                    )),


                  ],
                ),),
              Container(height: 30.w,
                color: Color(0x00000000),)


            ],
          );
        }
    );


  }
}

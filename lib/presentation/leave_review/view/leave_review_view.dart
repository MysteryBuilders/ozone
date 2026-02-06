import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/leave_review/bloc/leave_review_bloc/leave_review_bloc.dart';
import 'package:ozon/presentation/leave_review/bloc/rating_bloc/rating_bloc.dart';
import 'package:ozon/presentation/leave_review/bloc/rating_bloc/rating_state.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/user_prefrences.dart';
import '../../../domain/model/my_orders_model.dart';
import '../../edit_profile/bloc/select_image/select_image_bloc.dart';
import '../../edit_profile/bloc/select_image/select_image_event.dart';
import '../../edit_profile/bloc/select_image/select_image_state.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/loading_view.dart';
import '../bloc/rating_bloc/rating_event.dart';


class LeaveReviewView extends StatefulWidget {
  final ProductMyItemModel myItemModel;
  const LeaveReviewView({super.key,required this.myItemModel});

  @override
  State<LeaveReviewView> createState() => _LeaveReviewViewState();
}

class _LeaveReviewViewState extends State<LeaveReviewView> {
  RatingBloc _ratingBloc = instance<RatingBloc>();
  ImagePickerBloc _imagePickerBloc = instance<ImagePickerBloc>();
  LeaveReviewBloc _leaveReviewBloc = instance<LeaveReviewBloc>();
  UserBloc userBloc = GetIt.I<UserBloc>();
  bool isUpdate = false;
  File?  userImageFile;
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  AppPreferences appPreferences = instance<AppPreferences>();
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.w,
        title: AppbarTitle(
          text: AppStrings.leaveReview.tr(),
        ),
        leading:

        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.all(4.w),
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
                color: ColorManager.white,
                shape: BoxShape.circle,
                
                border: Border.all(color: ColorManager.grey)
            ),
            child: Center(
              child: Icon(Icons.arrow_back_outlined,
                color: ColorManager.titleColor,
                size: 20.w,),
            ),
          ),
        ),


      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: userBloc..add(UserInfoFetched(userPreferences.userToken!)),
  builder: (context, userState) {
          if(userState is UserLoading){
            return Container(
              alignment: AlignmentDirectional.center,
              child:    SizedBox(
                  height: 150.w,
                  width: 150.w,
                  child: Lottie.asset(ImageAssets.loadingView)),

            );
          }else if(userState is UserFailure){
            return Container(
              color: Colors.white,
              alignment: AlignmentDirectional.center,
              child: Text(userState.message,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w500

                ),),
            );
          }else if(userState is UserSuccess) {
            return Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.w, horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            width: ScreenUtil().screenWidth,
                            height: 84.w,


                            child: Row(

                              children: [
                                Container(
                                  width: 84.w,
                                  height: 84.w,
                                  child: CachedNetworkImage(
                                    width: 84.w,
                                    height: 84.w,

                                    fit: BoxFit.fill,
                                    imageUrl: widget.myItemModel.imageExtension
                                        .product_image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                            width: ScreenUtil().screenWidth,


                                            decoration: BoxDecoration(


                                              image: DecorationImage(


                                                  fit: BoxFit.fill,
                                                  image: imageProvider),
                                            )
                                        ),
                                    placeholder: (context, url) =>
                                        Container(
                                          height: 30,
                                          width: 30,
                                          child: LinearProgressIndicator(
                                            color: Colors.grey.shade200,
                                            backgroundColor: Colors.grey
                                                .shade100,
                                          ),
                                        ),


                                    errorWidget: (context, url, error) =>
                                        SizedBox(
                                          width: 30.w,
                                          height: 30.w,
                                          child: Image.asset(
                                            'assets/images/image_not_found.png',
                                            height: 30.w,
                                            width: 30.w,

                                          ),
                                        ),

                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: ScreenUtil().screenHeight,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Text('${limitWithEllipsis(
                                                        widget.myItemModel
                                                            .name)}',
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .displayMedium!
                                                          .copyWith(
                                                          color: Color(
                                                              0xFF000000),
                                                          fontWeight: FontWeight
                                                              .normal,
                                                          fontSize: 14.sp
                                                      ),),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${AppStrings.quantity
                                                      .tr()} ${widget
                                                      .myItemModel
                                                      .qty_ordered}',
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                      color: ColorManager
                                                          .secondaryBlack,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      fontSize: 12.sp
                                                  ),),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  ' ${widget.myItemModel
                                                      .price} ${AppStrings.kd
                                                      .tr()}',
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                      color: ColorManager
                                                          .mainBlack,
                                                      fontWeight: FontWeight
                                                          .w500,
                                                      fontSize: 14.sp
                                                  ),),
                                              ),
                                            ],
                                          ),

                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20.w,),
                          Container(
                            width: ScreenUtil().screenWidth,
                            height: 0.5,
                            color: ColorManager.seperatorColor,
                          ),
                          Container(
                            alignment: AlignmentDirectional.center,
                            padding: EdgeInsets.symmetric(vertical: 30.w),
                            child: Text(AppStrings.howOrder.tr(),
                              textAlign: TextAlign.center,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                  color: ColorManager.mainBlack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24.sp

                              ),),
                          ),
                          Container(
                            width: ScreenUtil().screenWidth,
                            height: 0.5,
                            color: ColorManager.seperatorColor,
                          ),

                          Container(
                              padding: EdgeInsets.symmetric(vertical: 30.w),
                              child: Column(
                                children: [
                                  Text(AppStrings.yourRatring.tr(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                        color: ColorManager.mainBlack,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp

                                    ),),
                                  SizedBox(height: 20.w,),
                                  BlocBuilder<RatingBloc, RatingState>(
                                    bloc: _ratingBloc,
                                    builder: (context, state) {
                                      return StarRating(
                                        size: 50.w,
                                        rating: state.rating,
                                        color: Color(0xFFFCAF23),
                                        borderColor: ColorManager
                                            .secondaryBlack,
                                        allowHalfRating: true,
                                        starCount: 5,
                                        onRatingChanged: (rating) {
                                          _ratingBloc.add(
                                              RatingChanged(rating));
                                        },
                                      );
                                    },
                                  ),

                                ],
                              )
                          ),
                          Container(
                            width: ScreenUtil().screenWidth,
                            height: 0.5,
                            color: ColorManager.seperatorColor,
                          ),
                          SizedBox(height: 30.w,),
                          Text(

                            AppStrings.addDetailed.tr(),
                            textAlign: TextAlign.start,
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                color: ColorManager.mainBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500

                            ),),
                          SizedBox(height: 10.w,),
                          Container(
                            height: 120.w,
                            width: ScreenUtil().screenWidth,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ColorManager.seperatorColor,
                                    width: 0.5
                                ), borderRadius: BorderRadius.circular(5.w)

                            ),
                            child: TextField(
                              controller: _contentController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.done,
                              maxLines: 20,
                              minLines: 10,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                  color: ColorManager.secondaryBlack,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.normal

                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppStrings.enterHere.tr(),
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                    color: ColorManager.secondaryBlack,
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.normal

                                ),
                              ),

                            ),
                          ),
                          SizedBox(height: 20.w,),
                          // Row(
                          //   children: [
                          //     Icon(Icons.camera_alt_outlined,color: ColorManager.primary,
                          //       size: 20.w,
                          //     ),
                          //     SizedBox(width: 10.w,),
                          //     Text(AppStrings.addPhoto.tr(),
                          //     style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          //       color: ColorManager.primary,
                          //       fontWeight: FontWeight.w500,
                          //       fontSize: 12.sp
                          //     ),)
                          //
                          //   ],
                          // ),
                          // SizedBox(height: 20.w,),
                          // InkWell(
                          //   onTap: (){
                          //
                          //     _showDialogBottomSheet(context);
                          //   },
                          //   child: Container(
                          //     alignment: AlignmentDirectional.center,
                          //     child: BlocConsumer<ImagePickerBloc, ImagePickerState>(
                          //       bloc: _imagePickerBloc,
                          //       listener: (context, imagePickerState) {
                          //
                          //         // TODO: implement listener
                          //       },
                          //       builder: (context, imagePickerState) {
                          //         if(imagePickerState is ImagePickerLoading){
                          //           if(userImageFile!= null){
                          //             return Container(
                          //               height: 150.w,
                          //               width: 150.w,
                          //               alignment: AlignmentDirectional.center,
                          //               child: Stack(
                          //
                          //
                          //                 children: [
                          //                   Positioned.fill(child:
                          //                   Container(
                          //                     height: 150.w,
                          //                     width: 150.w,
                          //                     decoration: BoxDecoration(
                          //
                          //                       image: DecorationImage(
                          //                           image: Image
                          //                               .file(
                          //                               File(
                          //                                   userImageFile!
                          //                                       .path))
                          //                               .image,
                          //                           fit: BoxFit
                          //                               .fill),
                          //                     ),
                          //                   )),
                          //
                          //
                          //                 ],
                          //               ),
                          //
                          //             );
                          //           }else{
                          //             return Container(
                          //               height: 90.w,
                          //               width: 90.w,
                          //               alignment: AlignmentDirectional.center,
                          //               child: Stack(
                          //
                          //
                          //                 children: [
                          //                   Positioned.fill(child:
                          //                   Container(
                          //                     width: 90.w,
                          //                     height: 90.w,
                          //                     decoration: BoxDecoration(
                          //                       color: Colors.white,
                          //                       border: Border.all(
                          //                         width: 0.5,
                          //                         color: ColorManager.seperatorColor
                          //                       )
                          //                     ),
                          //                     child: Center(
                          //                       child: Icon(Icons.add_a_photo_outlined,
                          //                       color: ColorManager.primary,
                          //                       size: 40.w,),
                          //                     ),
                          //                   )),
                          //
                          //
                          //                 ],
                          //               ),
                          //
                          //             );
                          //           }
                          //         }
                          //         else if(imagePickerState is ImagePickerFailure){
                          //           if(userImageFile!= null){
                          //             return Container(
                          //               height: 150.w,
                          //               width: 150.w,
                          //               alignment: AlignmentDirectional.center,
                          //               child: Stack(
                          //
                          //
                          //                 children: [
                          //                   Positioned.directional(
                          //                       textDirection: Directionality.of(context),
                          //                       top:0,
                          //                       bottom:0,
                          //                       start:0,
                          //                       end:0,child:
                          //                   Container(
                          //                     height: 150.w,
                          //                     width: 150.w,
                          //                     alignment: AlignmentDirectional.center,
                          //                     child: Container(
                          //                       alignment: AlignmentDirectional.center,
                          //                       height: 150.w,
                          //                       width: 150.w,
                          //                       decoration: BoxDecoration(
                          //
                          //                         image: DecorationImage(
                          //                             image: Image
                          //                                 .file(
                          //                                 File(
                          //                                     userImageFile!
                          //                                         .path))
                          //                                 .image,
                          //                             fit: BoxFit
                          //                                 .fill),
                          //                       ),
                          //                     ),
                          //                   )),
                          //
                          //
                          //                 ],
                          //               ),
                          //
                          //             );
                          //           }else{
                          //             return Container(
                          //               height: 150.w,
                          //               width: 150.w,
                          //               alignment: AlignmentDirectional.center,
                          //               child: Stack(
                          //
                          //
                          //                 children: [
                          //                   Positioned.fill(child:
                          //                   Container(
                          //                     height: 150.w,
                          //                     width: 150.w,
                          //                     alignment: AlignmentDirectional.center,
                          //                     child: Container(
                          //                       alignment: AlignmentDirectional.center,
                          //                       height: 150.w,
                          //                       width: 150.w,
                          //                       decoration: BoxDecoration(
                          //
                          //                         image: DecorationImage(
                          //                             image: Image
                          //                                 .file(
                          //                                 File(
                          //                                     userImageFile!
                          //                                         .path))
                          //                                 .image,
                          //                             fit: BoxFit
                          //                                 .fill),
                          //                       ),
                          //                     ),
                          //                   )),
                          //
                          //
                          //                 ],
                          //               ),
                          //
                          //             );
                          //           }
                          //
                          //         }else if(imagePickerState is ImagePickerSuccess){
                          //           userImageFile =
                          //               imagePickerState.image;
                          //           return Container(
                          //             height: 150.w,
                          //             width: 150.w,
                          //             alignment: AlignmentDirectional.center,
                          //             child: Stack(
                          //
                          //
                          //               children: [
                          //                 Positioned.fill(child:
                          //                 Container(
                          //                   height: 150.w,
                          //                   width: 150.w,
                          //                   decoration: BoxDecoration(
                          //
                          //                     image: DecorationImage(
                          //                         image: Image
                          //                             .file(
                          //                             File(
                          //                                 imagePickerState
                          //                                     .image
                          //                                     .path))
                          //                             .image,
                          //                         fit: BoxFit
                          //                             .fill),
                          //                   ),
                          //                 )),
                          //
                          //
                          //               ],
                          //             ),
                          //
                          //           );
                          //         }else {
                          //           if(userImageFile!= null){
                          //             return Container(
                          //               height: 150.w,
                          //               width: 150.w,
                          //               alignment: AlignmentDirectional.center,
                          //               child: Stack(
                          //
                          //
                          //                 children: [
                          //                   Positioned.fill(child:
                          //                   Container(
                          //                     height: 150.w,
                          //                     width: 150.w,
                          //                     decoration: BoxDecoration(
                          //
                          //                       image: DecorationImage(
                          //                           image: Image
                          //                               .file(
                          //                               File(
                          //                                   userImageFile!
                          //                                       .path))
                          //                               .image,
                          //                           fit: BoxFit
                          //                               .fill),
                          //                     ),
                          //                   )),
                          //
                          //
                          //                 ],
                          //               ),
                          //
                          //             );
                          //           }else{
                          //             return Container(
                          //               height: 90.w,
                          //               width: 90.w,
                          //               alignment: AlignmentDirectional.center,
                          //               child: Stack(
                          //
                          //
                          //                 children: [
                          //                   Positioned.fill(child:
                          //                   Container(
                          //                     width: 90.w,
                          //                     height: 90.w,
                          //                     decoration: BoxDecoration(
                          //                         color: Colors.white,
                          //                         border: Border.all(
                          //                             width: 0.5,
                          //                             color: ColorManager.seperatorColor
                          //                         )
                          //                     ),
                          //                     child: Center(
                          //                       child: Icon(Icons.add_a_photo_outlined,
                          //                         color: ColorManager.primary,
                          //                         size: 40.w,),
                          //                     ),
                          //                   )),
                          //
                          //
                          //                 ],
                          //               ),
                          //
                          //             );
                          //           }
                          //         }
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 100.w,)


                        ],
                      ),

                    ),
                  ),
                ),
                Positioned.directional(
                    textDirection: Directionality.of(context),
                    bottom: 0,
                    start: 0,
                    end: 0,
                    child: Container(
                      height: 100.w,
                      child: Card(
                        color: ColorManager.white,
                        elevation: 3.w,

                        child: Container(
                          width: ScreenUtil().screenWidth,
                          height: ScreenUtil().screenHeight,
                          alignment: AlignmentDirectional.center,
                          child: Container(
                              alignment: AlignmentDirectional.center,
                              height: 40.w,
                              width: ScreenUtil().screenWidth,
                              margin: EdgeInsets.symmetric(horizontal: 30.w),
                              child: Row(
                                children: [
                                  Expanded(flex: 1,
                                      child: BlocListener<
                                          LeaveReviewBloc,
                                          LeaveReviewState>(
                                        bloc: _leaveReviewBloc,
                                        listener: (context, state) {
                                          if (state is LeaveReviewLoading) {
                                            showLoadingDialog(context);
                                          } else
                                          if (state is LeaveReviewFailure) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger
                                                .of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(state.message)),
                                            );
                                          } else
                                          if (state is LeaveReviewSuccess) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger
                                                .of(context)
                                                .showSnackBar(
                                              SnackBar(content: Text(
                                                  AppStrings.leaveReviewSuccess
                                                      .tr())),
                                            );
                                            Navigator.pop(context);
                                          }
                                          // TODO: implement listener
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            String? review = _contentController
                                                .text;
                                            if (review!.isEmpty) {
                                              ScaffoldMessenger
                                                  .of(context)
                                                  .showSnackBar(
                                                SnackBar(content: Text(
                                                    AppStrings
                                                        .enterDetailedReview
                                                        .tr())),
                                              );
                                            } else
                                            if (_ratingBloc.state.rating == 0) {
                                              ScaffoldMessenger
                                                  .of(context)
                                                  .showSnackBar(
                                                SnackBar(content: Text(
                                                    AppStrings.enterReview
                                                        .tr())),
                                              );
                                            } else {
                                              Map<String, dynamic> map = {};
                                              map['rating_name'] = "rate";
                                              map['value'] =
                                                  _ratingBloc.state.rating.toInt();
                                              List<Map<String,
                                                  dynamic>> ratingList = [];
                                              ratingList.add(map);
                                              List<int> stores = [

                                                7,
                                                8
                                              ];
                                              Map<String, dynamic> mapReview = {
                                              };
                                              mapReview['title'] =
                                              "Product Review";
                                              mapReview['detail'] = review;
                                              mapReview['nickname'] = '${userState.userInfoModel!.firstname} ${userState.userInfoModel.lastname}';
                                              mapReview['customer_id'] = userState.userInfoModel!.id;
                                              mapReview['review_entity'] = "product";
                                              mapReview['review_type'] = 1;
                                              mapReview['ratings'] =ratingList;

                                              mapReview['entity_pk_value'] = widget.myItemModel.product_id;
                                              mapReview['stores'] =stores;

                                              Map<String, dynamic> mapReviews = {
                                              };
                                              mapReviews['review']= mapReview;
                                              print(mapReviews);
                                              _leaveReviewBloc.add(LeaveReviewButtonPressed(authorization:Constants.headerValue, map: mapReviews));

                                            }
                                          },
                                          child: Container(
                                            height: ScreenUtil().screenHeight,
                                            alignment: AlignmentDirectional
                                                .center,
                                            decoration: BoxDecoration(
                                              color: ColorManager.primary,
                                              borderRadius: BorderRadius
                                                  .circular(20.w),


                                            ),
                                            child: Text(AppStrings.submit.tr(),
                                              textAlign: TextAlign.center,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                  color: ColorManager.white,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500
                                              ),),

                                          ),
                                        ),
                                      )),
                                  SizedBox(width: 20.w,),
                                  Expanded(flex: 1,
                                      child: Container(
                                        height: ScreenUtil().screenHeight,
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                          color: ColorManager.grey,
                                          borderRadius: BorderRadius.circular(
                                              20.w),


                                        ),
                                        child: Text(
                                          AppStrings.cancelString.tr(),
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                              color: ColorManager.primary,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500
                                          ),),

                                      )),


                                ],
                              )),
                        ),
                      ),

                    ))

              ],
            );
          }else{
            return Container();
          }
  },
),


    );
  }
  String limitWithEllipsis(String text, {int maxLength = 30}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
  void _showDialogBottomSheet(BuildContext context){
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
              Container(height: 70.w,
                width: ScreenUtil().screenWidth,
                alignment: Alignment.center,

                child: Text(AppStrings.selectImage.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal
                  ),),),
              Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),

              SizedBox(height: 20.w,),
              Container(height: 40.w,
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(flex:1,child: InkWell(
                      onTap: (){
                        _imagePickerBloc.add(PickImage(fromCamera: true));
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        color: ColorManager.gray300,
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.camera.tr(),
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
                        _imagePickerBloc.add(PickImage(fromCamera: false));
                        Navigator.pop(context);

                      },
                      child: Container(
                        color: ColorManager.primary,
                        alignment: AlignmentDirectional.center,
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.gallery.tr(),
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
                color: Color(0x00000000),),


            ],
          );
        }
    );


  }
}

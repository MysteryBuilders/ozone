import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/state_model.dart';
import 'package:ozon/presentation/main/bloc/user_bloc/user_bloc.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../../app/user_prefrences.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';


class MainAppBarWidget extends StatelessWidget {
  CountryModel? countryModel;
  StateModel? stateModel;
  final UserBloc userBloc = instance<UserBloc>();
   MainAppBarWidget({super.key,required this.countryModel,required this.stateModel});

String userToken ="";
  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences = GetIt.I<UserPreferences>();
    if (userPreferences.userToken!.isEmpty) {
      userToken = "";
    } else {
      userToken = userPreferences.userToken!;



      // GetIt.I<CartBloc>().add(CartFetched(userToken!));
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      alignment: AlignmentDirectional.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.location.tr(),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: ColorManager.secondaryBlack,
                fontSize: 12.sp,
                fontWeight: FontWeight.normal


              ),),
              SizedBox(height: 5.w,),
              InkWell(
                onTap: (){
                  String type = "";
                  String id ="";

                  Map<String,dynamic> map ={};
                  map['type']= type;
                  map['id']=id;
                  Navigator.pushNamed(context, Routes.locationRoute,arguments: map);

                },
                child: Row(
                  children: [
                    Icon(Icons.location_on_rounded,
                    color: ColorManager.primary,
                    size: 20.w,),
                    SizedBox(width: 3.w,),
                    Text('${stateModel!.name!}, ${countryModel!.fullNameLocale!}',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: ColorManager.mainBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp
                    ),),
                    SizedBox(width: 2.w,),
                    Icon(Icons.keyboard_arrow_down_outlined,size: 16.w,color: ColorManager.mainBlack,)


                  ],
                ),
              )



            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (userToken!.trim().isNotEmpty) {
                   userBloc.add(UserInfoFetched(userPreferences.userToken!));
                  } else {

                    Navigator.of(context,rootNavigator: true).pushNamed( Routes.loginRoute);
                  }
                },
                child: BlocListener<UserBloc, UserState>(
                  bloc: userBloc,
  listener: (context, state) {
   if(state is UserLoading){
     showLoadingDialog(context);
   }else if(state is UserFailure){
     Navigator.pop(context);

   }else if(state is UserSuccess){
     Navigator.pop(context);
     Map<String,dynamic> map={};
     map['title']= AppStrings.cart.tr();
     Navigator.pushNamed(context, Routes.cartRoute,arguments: map);

   }
  },
  child: Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                      color: ColorManager.circlebg,
                      shape: BoxShape.circle
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Image.asset(ImageAssets.imgCarthHome,width: 25.w,
                          height: 25.w,),
                        Positioned.directional(textDirection: Directionality.of(context),
                          top:0,
                          start:0,child:userPreferences.userToken!.isEmpty?
                          Container():
                          BlocBuilder<CartBloc, CartState>(
                            bloc:  GetIt.I<CartBloc>()..add(CartFetched(userToken!)),
                            builder: (context, state) {
                              print("deletecart");

                              if(state is CartSuccess){
                                print("33333");
                                return state.orderModel.items.length ==0?
                                SizedBox.shrink():Container(
                                  alignment: AlignmentDirectional.center,
                                  width: 12.w, // Set the width
                                  height: 12.w, // Set the height
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary, // Set the color to red
                                    shape: BoxShape.circle, // Make it a circle
                                  ),
                                  child: Center(
                                    child: Text(state.orderModel!.items!.length.toString(),
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(8),
                                          fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                );
                              }else{
                                print("deletecart22");
                                return SizedBox.shrink();
                              }

                            },
                          ),)
                      ],
                    ),
                  ),
                ),
),
              ),
              // SizedBox(width: 5.w,),
              // Container(
              //   width: 36.w,
              //   height: 36.w,
              //   decoration: BoxDecoration(
              //       color: ColorManager.circlebg,
              //       shape: BoxShape.circle
              //   ),
              //   alignment: AlignmentDirectional.center,
              //   child: Container(
              //     height: 23.41.w,
              //     width: 23.41.w,
              //
              //     child: Stack(
              //       children: [
              //         Positioned.directional(
              //           textDirection: Directionality.of(context),
              //           top:0,
              //           bottom: 0,
              //           start: 0,
              //           end: 0,
              //           child: Icon(Icons.notifications_rounded,color: ColorManager.mainBlack,
              //             size: 23.w,),
              //         ),
              //         Positioned.directional(textDirection: Directionality.of(context),
              //             top: 3.w,
              //             start: 3.w,
              //
              //             child: Container(
              //               width: 6.w,
              //               height: 6.w,
              //               decoration: BoxDecoration(
              //                   color: ColorManager.redNotification,
              //                   shape: BoxShape.circle
              //               ),
              //
              //
              //             ))
              //       ],
              //     ),
              //   ),
              // ),


            ],
          )


        ],
      ),
    );
  }
}

import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_local/cart_local_bloc.dart';
import 'package:ozon/presentation/main/bloc/check_cart/check_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/offers_bloc/load_more_state.dart';
import 'package:ozon/presentation/main/view/widgets/cart_widget.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';

import '../../../app/user_prefrences.dart';
import '../../check_out/delete_coupoun_bloc/delete_coupoun_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../bloc/apply_coupon_bloc/apply_coupon_bloc.dart';


 class CartView extends StatefulWidget  {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  final TextEditingController _voucherController = TextEditingController();
  UserPreferences userPreferences = GetIt.I<UserPreferences>();
  CheckCartBloc checkCartBloc = instance<CheckCartBloc>();
  final ApplyCouponBloc applyCouponBloc = instance<ApplyCouponBloc>();
  final DeleteCoupounBloc deleteCoupounBloc = instance<DeleteCoupounBloc>();
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String userLoginToken = userPreferences.userToken!;
    checkCartBloc.add(CheckCartFetched(userLoginToken));
    // init();
  }
  void init()async{
    await Future.delayed(Duration.zero);

  }
  @override
  Widget build(BuildContext context) {



    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.w,
              title: AppbarTitle(
                text: AppStrings.cart.tr(),
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

              backgroundColor: ColorManager.white,
              body: BlocBuilder<CheckCartBloc, CheckCartState>(
                bloc:   checkCartBloc,
                builder: (context, state) {
                  if (state is CheckCartLoading) {
                    return Container(
                      alignment: AlignmentDirectional.center,
                      child: SizedBox(
                          height: 150.w,
                          width: 150.w,
                          child: Lottie.asset(ImageAssets.loadingView)),

                    );
                  }
                  else if (state is CheckCartFailure) {
                    return Container(
                      color: Colors.white,
                      alignment: AlignmentDirectional.center,
                      child: Text(AppStrings.emptyCart.tr(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(
                            color: ColorManager.mainBlack,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w500

                        ),),
                    );
                  }
                  else if (state is CheckCartSuccess) {
                    if(state.orderModel.itemsCount!>0){

                      return Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              margin: EdgeInsets.all(10.w),
                              child:  SingleChildScrollView(
                                physics:AlwaysScrollableScrollPhysics(),

                                child: Column(
                                  children: [
                                    ListView.separated(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.orderModel.items.length
                                        ,
                                        itemBuilder: (context, index) {

                                          return CartWidget(state.orderModel.items[index],index: index,currency: state.orderModel.currency!.baseCurrencyCode.toString(),checkCartBloc: checkCartBloc,);
                                        }, separatorBuilder: (BuildContext context, int index) {
                                      return Container(height:0.5,width: ScreenUtil().screenWidth,
                                        color: ColorManager.gray300,);
                                    },
                                    ),
                                    SizedBox(height: 120.w,)


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
                              child:  Container(
                                width: ScreenUtil().screenWidth,

                                height: 100.w,

                                child: Card(
                                  color: Colors.white,


                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20.w), // Top corners radius
                                    ),
                                  ),
                                  elevation: 4, // Set elevation

                                  surfaceTintColor: Colors.white,
                                  child: Container(
                                    width: ScreenUtil().screenWidth,
                                    height: ScreenUtil().screenHeight,
                                    alignment: AlignmentDirectional.center,
                                    child:
                                    InkWell(
                                      onTap: (){
                                              Map<String,dynamic> map ={};
                                              map['title']= AppStrings.addresses.tr();
                                              Navigator.pushNamed(context, Routes.selectAddressRoute,arguments: map);

                                      },
                                      child: Container(
                                        height: 50.w,
                                        width: ScreenUtil().screenWidth,
                                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                                        decoration: BoxDecoration(
                                          color: ColorManager.primary,
                                          borderRadius: BorderRadius.circular(25.w)
                                        ),
                                        alignment: AlignmentDirectional.center,
                                        child: Text(AppStrings.continueString.tr(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                          color: ColorManager.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal
                                        ),),

                                      ),
                                    ),
                                    // child: CustomButton(
                                    //     width: ScreenUtil().screenWidth,
                                    //     text: AppStrings.continueString.tr(),
                                    //     margin:EdgeInsetsDirectional.only(start: 20.w,end: 20.w,top: 38.h),
                                    //     //getMargin(left: 20, top: 38, right: 20),
                                    //     onTap: (){
                                    //       Map<String,dynamic> map ={};
                                    //       map['title']= AppStrings.addresses.tr();
                                    //       Navigator.pushNamed(context, Routes.selectAddressRoute,arguments: map);
                                    //       // Navigator.pushNamed(context, Routes.selectAddressRoute);
                                    //     },
                                    //
                                    //     alignment: Alignment.center),
                                  ),
                                ),
                              ),)

                        ],
                      );

                    }else{
                      return Container(
                        color: Colors.white,
                        alignment: AlignmentDirectional.center,
                        child: Text(AppStrings.emptyCart.tr(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                              color: ColorManager.mainBlack,
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.w500

                          ),),
                      );
                    }

                  } else {
                    return Container();
                  }
                }
              )
          ),
      ),
    );
  }
}

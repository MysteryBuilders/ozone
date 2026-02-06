import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/domain/model/my_orders_model.dart';
import 'package:ozon/domain/model/status_model.dart';
import 'package:ozon/presentation/my_orders/bloc/cancel_order_bloc/cancel_order_bloc.dart';
import 'package:ozon/presentation/my_orders/bloc/my_orders_bloc.dart';
import 'package:ozon/presentation/my_orders/bloc/status_bloc/status_bloc.dart';
import 'package:ozon/presentation/my_orders/view/widget/listforward1_item_widget.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';


import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../../data/network/helper_query.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';

class MyOrdersView extends StatefulWidget {
  const MyOrdersView({super.key});

  @override
  State<MyOrdersView> createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  MyOrdersBloc _myOrdersBloc = instance<MyOrdersBloc>();
  CancelOrderBloc _cancelOrderBloc = instance<CancelOrderBloc>();
  StatusBloc _statusBloc = instance<StatusBloc>();
  UserBloc userBloc =  instance<UserBloc>();
  Map<String,dynamic> map ={};
  List<StatusModel> statusList =[];
  String userToken="";
  HelperQuery helperQuery = HelperQuery();
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();
    print(userPreferences.userToken!);
    userBloc.add(UserInfoFetched(userPreferences.userToken!));

  }
  @override
  Widget build(BuildContext context) {

    // if(userPreferences.userToken!.isEmpty){


    // }else{
    //   userToken = userPreferences.userToken!;
    // }

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.w,
            title: AppbarTitle(
              text: AppStrings.orders.tr(),
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
            bloc: userBloc,
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
                return Container();

              }
              else if(userState is UserSuccess){
                map=    helperQuery.buildFilterQueryParams(userid: userState.userInfoModel.id );
                _myOrdersBloc.add(MyOrdersFetched(map, Constants.headerValue));
                return Container(
                  child:
                  BlocBuilder<MyOrdersBloc, MyOrdersState>(
                    bloc: _myOrdersBloc,
                    builder: (context, state) {
                      if(state is MyOrdersLoading){
                        return Container(
                          alignment: AlignmentDirectional.center,
                          child:    SizedBox(
                              height: 150.w,
                              width: 150.w,
                              child: Lottie.asset(ImageAssets.loadingView)),

                        );
                      }
                      else if(state is MyOrdersFailure){
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
                      }else if(state is MyOrdersSuccess){
                        return Container(

                          child: Column(
                            children: [
                              Container(
                                height: 50.w,
                                child: BlocBuilder<StatusBloc, StatusState>(
                                  bloc: _statusBloc,
                                  builder: (context, statusState) {
                                    print(statusState.statusList);
                                    return ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context,index){
                                          final status = statusState.statusList[index];
                                          final isSelected = index == statusState.currentIndex;

                                          return InkWell(
                                            onTap: (){
                                              print(index);
                                              _statusBloc.add(StatusChanged(index));
                                              if(index == 0){

                                                // myOrdersBloc.add(FetchOrders(userPreferences.userToken!, isRtl() ? "ar" : "en", "filter", "","",0));
                                              }else{
                                                // selectedIndex =  (index-1).toString();
                                                // myOrdersBloc.add(FetchOrders(userPreferences.userToken!, isRtl() ? "ar" : "en", "filter", (index-1).toString(),"",0));
                                              }

                                            },
                                            child: Container(
                                              width: 120.w,
                                              height: 50.w,
                                              alignment: AlignmentDirectional.center,

                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(bottom: BorderSide(
                                                      color: isSelected?ColorManager.primary:ColorManager.seperatorColor,
                                                      width: isSelected?1:0.5
                                                  ))
                                              ),
                                              child: Text(statusState.statusList[index].statusString,style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                  color:isSelected?ColorManager.primary: ColorManager.secondaryBlack,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ),
                                          );
                                        }, separatorBuilder: (context,index){
                                      return              Container();
                                    }, itemCount: statusState.statusList.length);
                                  },
                                ),
                              ),
                              BlocBuilder<StatusBloc, StatusState>(
                                bloc: _statusBloc,

                                builder: (context, mState) {
                                  List<MyItemModel> items = state.myOrdersModel.orders.where((item) => item.state == mState.statusList[mState.currentIndex].statusKey).toList();

                                  return Expanded(
                                    flex: 1,
                                    child:
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10.w,horizontal: 20.w),
                                      child:
                                      items.isEmpty?
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(AppStrings.noItems.tr(),
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color: ColorManager.mainBlack,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500
                                          ),),
                                      ):
                                      ListView.separated(itemBuilder: (context,index){
                                        return InkWell(
                                            onTap: (){
                                              Map<String,dynamic> map = {};
                                              map['myItemModel']= items[index];
                                              map['title']= AppStrings.orderDetails.tr();
                                              // Navigator.pushNamed(context, Routes.orderDetailsRoute,arguments: map);
                                              // onTapOrderdetails();
                                              Navigator.pushNamed( context,Routes.orderDetailsRoute,arguments: map);

                                              // onTapImgOverflowmenu(items[index]);
                                            },
                                            child: Listforward1ItemWidget(items[index]));
                                      }, separatorBuilder: (context,index){
                                        return Column(
                                          children: [
                                            Container(height: 10.w,
                                            ),
                                            Container(width: ScreenUtil().screenWidth,
                                              height: 1,
                                              color: ColorManager.seperatorColor,),
                                            Container(height: 10.w,
                                            ),
                                          ],
                                        );
                                      }, itemCount: items.length),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }else {
                        return Container();

                      }
                    },
                  ),
                );
              }else{
                return Container();
              }

  },
),


        ),
      ),
    );
  }
 void onTapImgOverflowmenu(MyItemModel myItemModel) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc){
          return SingleChildScrollView(
              child: Container(
                  width: double.infinity,
                  decoration: AppDecoration.fillWhiteA700
                      .copyWith(borderRadius: BorderRadius.vertical(top: Radius.circular(35))),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                              // padding: getPadding(left: 25, top: 30, right: 25),
                                padding: EdgeInsetsDirectional.only(start: 25.w,top: 30.h,end:25.w ),
                                child: CommonImageView(
                                    svgPath: ImageAssets.imgVector23,
                                    height: 3.h,
                                    width: 42.w))),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Map<String,dynamic> map = {};
                              map['myItemModel']= myItemModel;
                              map['title']= AppStrings.orderDetails.tr();
                              // Navigator.pushNamed(context, Routes.orderDetailsRoute,arguments: map);
                              // onTapOrderdetails();
                              Navigator.pushNamed( context,Routes.orderDetailsRoute,arguments: map);
                            },
                            child: Padding(
                                padding: EdgeInsetsDirectional.only(start: 25.w,top: 30.h,end:25.w ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CommonImageView(
                                          svgPath: ImageAssets.imgInfo,
                                          height:24.w,
                                          width:24.w),
                                      Padding(
                                        // padding:
                                        // getPadding(left: 12, top: 2, bottom: 3),
                                          padding: EdgeInsetsDirectional.only(start: 12.w,top: 2.h,bottom: 3.h),
                                          child: Text(AppStrings.orderInfo.tr(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: ColorManager.gray800,
                                                fontSize: 12.sp,

                                                fontWeight: FontWeight.w400,
                                              )))
                                    ]))),
                        Container(
                          child: myItemModel.status == "canceled"?
                          Container():InkWell(
                            onTap: (){
                              _cancelOrderBloc.add(CancelOrderButtonPressed(orderId: myItemModel.increment_id, authorization: userToken));
                            },
                            child: BlocListener<CancelOrderBloc, CancelOrderState>(
                              bloc:_cancelOrderBloc ,
  listener: (context, cancelOrderState) {
if(cancelOrderState is CancelOrderLoading){
  showLoadingDialog(context);
}else if(cancelOrderState is CancelOrderFailure){
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(cancelOrderState.message)),
  );
}else if(cancelOrderState is CancelOrderSuccess){
  Navigator.pop(context);
  Navigator.pop(context);

  if(cancelOrderState.success){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppStrings.orderCanceled.tr())),
    );
  }else{
   Navigator.pop(context);
   Navigator.pop(context);
   if(cancelOrderState.success){
   ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(content: Text(AppStrings.orderCanceled.tr())),
   );
  }

}
  }
  },
  child: Padding(
                                padding: EdgeInsetsDirectional.only(start: 25.w,top: 30.h,end:25.w ),
                            
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CommonImageView(
                                          svgPath: ImageAssets.imgBag,
                                          height: 24.w,
                                          width: 24.w),
                                      Padding(
                                          padding: EdgeInsetsDirectional.only(start: 12.w,top: 2.h,bottom: 3.h),
                                          child: Text(AppStrings.cancelOrders.tr(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: ColorManager.gray800,
                                                fontSize: 12.sp,
                            
                                                fontWeight: FontWeight.w400,
                                              )))
                                    ])),
),
                          ),
                        ),
                        Container(
                          child:myItemModel.status == "pending"||
                              myItemModel.status == "holded"||
                              myItemModel.status == "payment_review"?Container(): Padding(
                              padding: EdgeInsetsDirectional.only(start: 25.w,top: 25.h,end:25.w ,bottom: 70.h),

                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CommonImageView(
                                        svgPath: ImageAssets.imgRefresh,
                                        height: 24.w,
                                        width: 24.w),
                                    Padding(
                                        padding: EdgeInsetsDirectional.only(start: 12.w,top: 2.h,bottom: 3.h),
                                        child: Text(AppStrings.reOrder.tr(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: ColorManager.gray800,
                                              fontSize: 12.sp,

                                              fontWeight: FontWeight.w400,
                                            )))
                                  ])),
                        )
                      ])));
        }
    );

  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/data/response/address_response.dart';
import 'package:ozon/presentation/add_address/bloc/add_address_bloc/add_address_bloc.dart';
import 'package:ozon/presentation/addresses/bloc/addresses_bloc.dart';
import 'package:ozon/presentation/addresses/bloc/delete_address_bloc/delete_address_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/offers_bloc/load_more_state.dart';
import 'package:ozon/presentation/main/bloc/user_bloc/user_bloc.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../app/user_prefrences.dart';
import '../../../domain/model/adresses_model.dart';
import '../../main/bloc/shipping_information/shipping_information_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/loading_view.dart';

class AddressesView extends StatefulWidget {
  final bool fromCart;
  const AddressesView({super.key,required this.fromCart});

  @override
  State<AddressesView> createState() => _AddressesViewState();
}

class _AddressesViewState extends State<AddressesView> with SingleTickerProviderStateMixin{
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  late SlidableController _slidableController;
  @override
  void initState() {
    _slidableController = SlidableController(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _slidableController.dispose(); // Dispose controller to avoid memory leaks
    super.dispose();
  }
  void _triggerSlideEffect() {
    Future.delayed(Duration(milliseconds: 1000), () {
      if (mounted) _slidableController.openStartActionPane();
    });

    Future.delayed(Duration(milliseconds: 2000), () {
      if (mounted)  _slidableController.openEndActionPane();
    });

    Future.delayed(Duration(milliseconds: 3000), () {
      if (mounted) _slidableController.close();
    });
  }
  final AddAddressBloc addAddressBloc = instance<AddAddressBloc>();
AddressesBloc addressesBloc =  GetIt.I<AddressesBloc>();
  ShippingInformationBloc shippingInformationBloc = instance<ShippingInformationBloc>();
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  DeleteAddressBloc deleteAddressBloc = instance<DeleteAddressBloc>();
  UserBloc userBloc = GetIt.I<UserBloc>();
  CartBloc cartBloc = GetIt.I<CartBloc>();
  bool isSelectedItem = false;
  @override
  Widget build(BuildContext context) {
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
              text: AppStrings.addresses.tr(),
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
          body: BlocBuilder<AddressesBloc, AddressesState>(
            bloc: addressesBloc..add(AddressesFetched(userPreferences.userToken!,0)),
            builder: (context, state) {
              if(state is AddressesLoading){
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              }else if(state is AddressesFailure){
                return Container(
                    color: ColorManager.white,
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight,
                    alignment: AlignmentDirectional.center,
                    child: Stack(
                      children: [
                        Positioned.directional(textDirection: Directionality.of(context),
                            bottom: 0,
                            start: 0,
                            end: 0,
                            child: Container(
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


                                  margin: EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.w),
                                  child:   GestureDetector(
                                    onTap: ()async{
                                      Map<String,dynamic> map={};

                                      map['title']= AppStrings.addAddress.tr();
                                      Navigator.pushNamed(context, Routes.addAddressRoute,arguments: map);

                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      child: Container(
                                        height: 40.w,
                                        alignment: AlignmentDirectional.center,
                                        width: ScreenUtil().screenWidth,
                                        decoration: BoxDecoration(
                                          color: ColorManager.primary,

                                        ),

                                        child: Text(AppStrings.addAddress.tr(),
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color: ColorManager.white,
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.normal
                                          ),),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )
                );
              }else if(state is AddressesSuccess){

                  // _triggerSlideEffect();

                return Container(
                  child:state.customerDomain.addresses.isEmpty?
                  Container(
                      color: ColorManager.white,
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight,
                      alignment: AlignmentDirectional.center,
                      child: Stack(
                        children: [
                          Positioned.directional(textDirection: Directionality.of(context),
                              bottom: 0,
                              start: 0,
                              end: 0,
                              child: Container(
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


                                    margin: EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.w),
                                    child:   GestureDetector(
                                      onTap: ()async{
                                        Map<String,dynamic> map={};

                                        map['title']= AppStrings.addAddress.tr();
                                        Navigator.pushNamed(context, Routes.addAddressRoute,arguments: map);

                                      },
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Container(
                                          height: 40.w,
                                          alignment: AlignmentDirectional.center,
                                          width: ScreenUtil().screenWidth,
                                          decoration: BoxDecoration(
                                            color: ColorManager.primary,

                                          ),

                                          child: Text(AppStrings.addAddress.tr(),
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                color: ColorManager.white,
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.normal
                                            ),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      )
                  ):Stack(
                    children: [

                      Positioned.fill(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20.w),
                            child: Column(
                              children: [
                                SlidableAutoCloseBehavior(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                            
                                      itemBuilder: (context,index){
                                        if (index == 0){
                                          return Slidable(
                                             controller: _slidableController,
                                            key:  ValueKey(state.customerDomain.addresses[index]),
                                            startActionPane: ActionPane(
                                                dragDismissible: true,
                                                extentRatio: 0.22,
                                                motion: BehindMotion(), children: [
                                              InkWell(
                                                onTap: ()async{
                                                  Map<String,dynamic> map ={};
                                                  map['addressDomain']= state.customerDomain.addresses[index];
                            
                            
                                                  map['title']= AppStrings.editAddress.tr();
                                                  Navigator.pushNamed(context, Routes.addressDetailsRoute,arguments: map);
                            
                                                },
                                                child: Container(
                                                  width: 0.2*ScreenUtil().screenWidth,
                                                  color: ColorManager.primary22,
                                                  child: Center(
                                                    child: Icon(Icons.edit,color: Colors.white,
                                                      size: 30.w,),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            endActionPane: ActionPane(
                                                dragDismissible: true,
                                                extentRatio: 0.22,
                                                motion: BehindMotion(), children: [
                                              InkWell(
                                                onTap: (){
                                                  Slidable.of(context)?.close();
                                                  _showDeleteAddressDialog(context, state.customerDomain.addresses[index].id, Constants.headerValue);
                                                },
                                                child: Container(
                                                  width: 0.2*ScreenUtil().screenWidth,
                                                  color: Color(0xFFfbd8d9),
                                                  child: Center(
                                                    child: Icon(Icons.delete,color: Colors.red,
                                                      size: 30.w,),
                                                  ),
                                                ),
                                              ),
                                            ]),
                            
                                            child: Container(
                                              width: ScreenUtil().screenWidth,
                            
                                              height: 50.w,
                                              child: Container(
                                                width: ScreenUtil().screenWidth,
                                                height: ScreenUtil().screenHeight,
                            
                                                child:
                                                Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Container(
                                                        width: ScreenUtil().screenWidth,
                                                        height: ScreenUtil().screenHeight,
                                                        child: Row(
                            
                                                          children: [
                                                            Container(
                                                                height: 50.w,
                                                                width: 50.w,
                            
                                                                child: Container(
                            
                                                                    child: Icon(Icons.pin_drop_outlined,color: ColorManager.primary22,size: 30.w,))),
                                                            Expanded(flex:1,child: Container(
                                                              margin: EdgeInsetsDirectional.only(start: 10.w),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(flex:1,child: Container(
                                                                    alignment: AlignmentDirectional.centerStart,
                            
                                                                    child: Text('${state.customerDomain.addresses[index].defaultShipping?AppStrings.defaultAddress.tr():AppStrings.notDefaultAddress.tr()}'
                                                                      ,
                                                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                                          color: ColorManager.mainBlack,
                                                                          fontWeight: FontWeight.normal,
                                                                          fontSize: ScreenUtil().setSp(14)
                            
                                                                      ),),
                                                                  )),
                                                                  Expanded(flex:2,child: Container(
                                                                    alignment: AlignmentDirectional.centerStart,
                                                                    child: Text('${state.customerDomain.addresses[index].countryId} , ${state.customerDomain.addresses[index].city} , ${AppStrings.streetNo.tr()} ${state.customerDomain.addresses[index].street[0]}'
                                                                      ,
                                                                      maxLines: 3
                                                                      ,
                                                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                                          color: ColorManager.secondaryBlack,
                            
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: ScreenUtil().setSp(12)
                            
                                                                      ),),
                                                                  )),
                            
                            
                                                                ],
                                                              ),
                                                            ))
                                                          ],
                            
                                                        ),
                                                      ),
                                                    ),
                            
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }else{
                                          return Slidable(
                            
                                            key:  ValueKey(state.customerDomain.addresses[index]),
                                            startActionPane: ActionPane(
                                                dragDismissible: true,
                                                extentRatio: 0.22,
                                                motion: BehindMotion(), children: [
                                              InkWell(
                                                onTap: ()async{
                                                  Map<String,dynamic> map ={};
                                                  map['addressDomain']= state.customerDomain.addresses[index];
                            
                            
                                                  map['title']= AppStrings.editAddress.tr();
                                                  Navigator.pushNamed(context, Routes.addressDetailsRoute,arguments: map);
                            
                                                },
                                                child: Container(
                                                  width: 0.2*ScreenUtil().screenWidth,
                                                  color: ColorManager.primary22,
                                                  child: Center(
                                                    child: Icon(Icons.edit,color: Colors.white,
                                                      size: 30.w,),
                                                  ),
                                                ),
                                              ),
                                            ]),
                                            endActionPane: ActionPane(
                                                dragDismissible: true,
                                                extentRatio: 0.22,
                                                motion: BehindMotion(), children: [
                                              InkWell(
                                                onTap: (){
                                                  Slidable.of(context)?.close();
                                                  _showDeleteAddressDialog(context, state.customerDomain.addresses[index].id, Constants.headerValue);
                                                },
                                                child: Container(
                                                  width: 0.2*ScreenUtil().screenWidth,
                                                  color: Color(0xFFfbd8d9),
                                                  child: Center(
                                                    child: Icon(Icons.delete,color: Colors.red,
                                                      size: 30.w,),
                                                  ),
                                                ),
                                              ),
                                            ]),
                            
                                            child: Container(
                                              width: ScreenUtil().screenWidth,
                            
                                              height: 50.w,
                                              child: Container(
                                                width: ScreenUtil().screenWidth,
                                                height: ScreenUtil().screenHeight,
                            
                                                child:
                                                Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: Container(
                                                        width: ScreenUtil().screenWidth,
                                                        height: ScreenUtil().screenHeight,
                                                        child: Row(
                            
                                                          children: [
                                                            Container(
                                                                height: 50.w,
                                                                width: 50.w,
                            
                                                                child: Container(
                            
                                                                    child: Icon(Icons.pin_drop_outlined,color: ColorManager.primary22,size: 30.w,))),
                                                            Expanded(flex:1,child: Container(
                                                              margin: EdgeInsetsDirectional.only(start: 10.w),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(flex:1,child: Container(
                                                                    alignment: AlignmentDirectional.centerStart,
                            
                                                                    child: Text('${state.customerDomain.addresses[index].defaultShipping?AppStrings.defaultAddress.tr():AppStrings.notDefaultAddress.tr()}'
                            
                                                                      ,
                                                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                                          color: ColorManager.mainBlack,
                                                                          fontWeight: FontWeight.normal,
                                                                          fontSize: ScreenUtil().setSp(14)
                            
                                                                      ),),
                                                                  )),
                                                                  Expanded(flex:2,child: Container(
                                                                    alignment: AlignmentDirectional.centerStart,
                                                                    child: Text('${state.customerDomain.addresses[index].countryId} , ${state.customerDomain.addresses[index].city} , ${AppStrings.streetNo.tr()} ${state.customerDomain.addresses[index].street[0]}'
                                                                        ,
                                                                      maxLines: 3
                                                                      ,
                                                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                                          color: ColorManager.secondaryBlack,
                            
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: ScreenUtil().setSp(12)
                            
                                                                      ),),
                                                                  )),
                            
                            
                                                                ],
                                                              ),
                                                            ))
                                                          ],
                            
                                                        ),
                                                      ),
                                                    ),
                            
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    // return InkWell(
                                    //   onTap: (){
                                    //     Map<String,dynamic> map ={};
                                    //     map['addressDomain']= state.customerDomain.addresses[index];
                                    //
                                    //
                                    //     map['title']= AppStrings.editAddress.tr();
                                    //     Routes.navigateTo( Routes.addressDetailsRoute,arguments: map);
                                    //
                                    //
                                    //   },
                                    //
                                    //   child: Container(height: 110.h,
                                    //   margin: EdgeInsets.all(20.w),
                                    //   width: ScreenUtil().screenWidth,
                                    //   decoration: BoxDecoration(
                                    //     color: state.customerDomain.addresses[index].defaultShipping?
                                    //         Colors.white:Colors.transparent,
                                    //     borderRadius: BorderRadius.circular(5.w)
                                    //
                                    //   ),
                                    //   child: Container(
                                    //     margin: EdgeInsets.all(10.w),
                                    //     child: Row(
                                    //       children: [
                                    //         Expanded(flex:1,child: Container(
                                    //           alignment: AlignmentDirectional.topCenter,
                                    //           child: Stack(
                                    //             children: [
                                    //               Container(
                                    //                 width: 55,
                                    //                 height: 55,
                                    //                 child: Center(
                                    //                   child: Container(
                                    //                     width: 48,
                                    //                     height: 48,
                                    //                     decoration: BoxDecoration(
                                    //                       color: state.customerDomain.addresses[index].defaultShipping? ColorManager.amber90063.withOpacity(0.2):ColorManager.primary63.withOpacity(0.2),
                                    //                       borderRadius: BorderRadius.circular(5.w)
                                    //
                                    //                     ),
                                    //                     child: Container(
                                    //                       child: Center(
                                    //                         child: SvgPicture.asset(
                                    //                           ImageAssets.address1,
                                    //                           color: state.customerDomain.addresses[index].defaultShipping?ColorManager.amber900:ColorManager.primary,
                                    //                         )
                                    //                         ,
                                    //                       ),
                                    //                     )
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               Positioned.directional(
                                    //                 textDirection: Directionality.of(context),
                                    //                 top: 0,
                                    //                 start: 0,
                                    //
                                    //                 child: Container(
                                    //                   child: state.customerDomain.addresses[index].defaultShipping?
                                    //                   Align(
                                    //                       alignment: AlignmentDirectional.topEnd,
                                    //                       child: Container(
                                    //                         // margin: getMargin(
                                    //                         //     right: 4,
                                    //                         //     top: 8
                                    //                         // ),
                                    //                         // margin: EdgeInsetsDirectional.only(end: 4.w,top: 8.h),
                                    //                           height: 17.w,
                                    //                           width: 17.w,
                                    //                           decoration: AppDecoration
                                    //                               .fillAmber900
                                    //                               .copyWith(
                                    //                               borderRadius:
                                    //                               BorderRadiusStyle
                                    //                                   .roundedBorder8),
                                    //                           child: Align(
                                    //                               alignment: Alignment
                                    //                                   .center,
                                    //                               child: CommonImageView(
                                    //                                   svgPath:
                                    //                                   ImageAssets
                                    //                                       .imgCheckmark,
                                    //                                   height:
                                    //                                   8.w,
                                    //                                   width: 8.w))))
                                    //                       :SizedBox(),
                                    //                 ),
                                    //               )
                                    //             ],
                                    //           ),
                                    //         )),
                                    //         SizedBox(width: 10.w,),
                                    //         Expanded(flex:5,child: Container(
                                    //           child: Column(children: [
                                    //             Expanded(flex:1,child: Container(
                                    //               child: Row(
                                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                                    //                 children: [
                                    //               Text( '${AppStrings.address.tr() } ${index+1}',
                                    //                                                     overflow: TextOverflow
                                    //                                                         .ellipsis,
                                    //                                                     textAlign:
                                    //                                                     TextAlign.start,
                                    //                                                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    //                                                       color: ColorManager.black,
                                    //                                                       fontSize: 14.sp,
                                    //
                                    //                                                       fontWeight: FontWeight.w500,
                                    //                                                     )),
                                    //                   SizedBox(width: 5.w,),
                                    //                   Container(
                                    //                     child: state.customerDomain.addresses[index].defaultShipping?
                                    //                         Container(
                                    //
                                    //
                                    //                             padding: EdgeInsetsDirectional.only(
                                    //                                                                       start: 14.w,
                                    //                                                                       top: 2.h,
                                    //                                                                       end: 14.w,
                                    //                                                                       bottom: 2.h
                                    //                                                                     ),
                                    //                                                                     decoration: AppDecoration
                                    //                                                                         .txtFillAmber9006c
                                    //                                                                         .copyWith(
                                    //                                                                         borderRadius:
                                    //                                                                         BorderRadiusStyle
                                    //                                                                             .txtRoundedBorder8),
                                    //                                                                     child: Text(
                                    //                                                                         AppStrings.defaultString.tr(),
                                    //                                                                         overflow:
                                    //                                                                         TextOverflow
                                    //                                                                             .ellipsis,
                                    //                                                                         textAlign:
                                    //                                                                         TextAlign.start,
                                    //                                                                         style:
                                    //                                                                     Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    //                                                                       color: ColorManager.amber900,
                                    //                                                                       fontSize: 10.sp,
                                    //
                                    //                                                                       fontWeight: FontWeight.w400,
                                    //                                                                     )))
                                    //
                                    //
                                    //                     :Container(),
                                    //                   )
                                    //
                                    //                 ],
                                    //               ),
                                    //             )),
                                    //             Expanded(flex:1,child: Container(
                                    //               alignment: AlignmentDirectional.centerStart,
                                    //               child: Text(
                                    //
                                    //
                                    //                                                 '${state.customerDomain.addresses[index].firstname} ${state.customerDomain.addresses[index].lastname}',
                                    //                                                 overflow:
                                    //                                                 TextOverflow.ellipsis,
                                    //                                                 textAlign: TextAlign.start,
                                    //                                                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    //                                                   color: ColorManager.black,
                                    //                                                   fontSize: 12.sp,
                                    //
                                    //                                                   fontWeight: FontWeight.w500,
                                    //                                                 )),
                                    //             )),
                                    //             Expanded(flex:1,child: Container(
                                    //               alignment: AlignmentDirectional.centerStart,
                                    //               child: Text(
                                    //                                                 state.customerDomain.addresses[index].telephone,
                                    //                                                 overflow:
                                    //                                                 TextOverflow.ellipsis,
                                    //                                                 textAlign: TextAlign.start,
                                    //                                                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    //                                                   color: ColorManager.gray800,
                                    //                                                   fontSize: 12.sp,
                                    //
                                    //                                                   fontWeight: FontWeight.w400,
                                    //                                                 )),
                                    //             )),
                                    //             Expanded(flex:1,child: Container(
                                    //               alignment: AlignmentDirectional.centerStart,
                                    //               child: Text(
                                    //                   state.customerDomain.addresses[index].region.region,
                                    //                   overflow:
                                    //                   TextOverflow.ellipsis,
                                    //                   textAlign: TextAlign.start,
                                    //                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    //                     color: ColorManager.gray800,
                                    //                     fontSize: 12.sp,
                                    //
                                    //                     fontWeight: FontWeight.w400,
                                    //                   )),
                                    //             )),
                                    //           ],),
                                    //         )),
                                    //         Expanded(flex:1,child: Column(
                                    //           children: [
                                    //             Expanded(
                                    //               flex:1,
                                    //               child: Container(
                                    //                 alignment: AlignmentDirectional.topEnd,
                                    //                 child: GestureDetector(
                                    //                   onTap: (){
                                    //                     _showDeleteAddressDialog(context, state.customerDomain.addresses[index].id, Constants.headerValue);
                                    //                   },
                                    //                   child: Padding(
                                    //                     padding: EdgeInsets.all(10.w),
                                    //                     child: Icon(Icons.delete,color: ColorManager.primary,
                                    //                     size: 20.w,),
                                    //                   ),
                                    //                 )
                                    //               ),
                                    //             ),
                                    //
                                    //           ],
                                    //         ))
                                    //       ],
                                    //     ),
                                    //   ),),
                                    // );
                            
                                  }, separatorBuilder: (context,index){
                                    return Column(
                                      children: [
                                        Container(height:0.5,
                                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                                          width: ScreenUtil().screenWidth,
                                          color: ColorManager.gray300,),
                                        SizedBox(height: 10.w,)
                                      ],
                                    );
                                  }, itemCount: state.customerDomain.addresses.length),
                                ),
                                SizedBox(height: 20.w,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned.directional(textDirection: Directionality.of(context),
                          bottom: 0,
                          start: 0,
                          end: 0,
                          child: Container(
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


                                margin: EdgeInsets.symmetric(horizontal: 20.h,vertical: 10.w),
                                child:   GestureDetector(
                                  onTap: ()async{
                                    Map<String,dynamic> map={};

                                    map['title']= AppStrings.addAddress.tr();
                                    Navigator.pushNamed(context, Routes.addAddressRoute,arguments: map);


                                  },
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: Container(
                                      height: 40.w,
                                      alignment: AlignmentDirectional.center,
                                      width: ScreenUtil().screenWidth,
                                      decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(20.w)

                                      ),

                                      child: Text(AppStrings.addAddress.tr(),
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.white,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.normal
                                        ),),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
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

  Future<void> _showDeleteAddressDialog(BuildContext context,int id,String authorization) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return

          BlocListener<DeleteAddressBloc, DeleteAddressState>(
            bloc: deleteAddressBloc,
            listener: (context, state) {

              if(state is DeleteAddressLoading){
                showLoadingDialog(context);
              }else if(state is DeleteAddressFailure){
               dismissLoadingDialog();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }else if(state is DeleteAddressSuccess){
                dismissLoadingDialog();
                Navigator.pop(context);
                addressesBloc.add(AddressesFetched(userPreferences.userToken!,0));



              }
            },
            child: BlocListener<CartBloc, CartState>(
              bloc: cartBloc,
  listener: (context, state) {
    if(state is CartSuccess){
      if((cartBloc.state as CartSuccess).orderModel.extensionAttributes!.shippingAssignments!.isNotEmpty){
        bool isShipping = false;
        bool isBilling = false;
        if(id == (cartBloc.state as CartSuccess).orderModel.extensionAttributes!.shippingAssignments![0].shippingsModel!.address!.id){
          isShipping = true;
        }
        if(id == (cartBloc.state as CartSuccess).orderModel.billingAddress!.id){
          isBilling = true;
        }
        if(isShipping&&isBilling){
          Map<String,dynamic> map ={};
          Map<String,dynamic> informationMap ={};
          informationMap['shipping_address'] = null;
          informationMap['billing_address'] = null;
          informationMap['shipping_carrier_code'] = null;
          informationMap['shipping_method_code'] = null;
          map['addressInformation'] = informationMap;
          shippingInformationBloc.add(ShippingInformationFetched(userPreferences.userToken!, map));
        }else if(!isShipping&&isBilling){
          Map<String,dynamic> map ={};
          Map<String,dynamic> informationMap ={};

          informationMap['billing_address'] = null;
          informationMap['shipping_carrier_code'] = null;
          informationMap['shipping_method_code'] = null;
          map['addressInformation'] = informationMap;
          shippingInformationBloc.add(ShippingInformationFetched(userPreferences.userToken!, map));

        }

        else if(isShipping&&!isBilling){
          Map<String,dynamic> map ={};
          Map<String,dynamic> informationMap ={};
          informationMap['shipping_address'] = null;

          informationMap['shipping_carrier_code'] = null;
          informationMap['shipping_method_code'] = null;
          map['addressInformation'] = informationMap;
          shippingInformationBloc.add(ShippingInformationFetched(userPreferences.userToken!, map));

        }else if(!isShipping&&!isBilling){

        }
      }else{

      }
    }
    else if(state is CartFailure){
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
    else if(state is CartLoading){}
    // TODO: implement listener
  },
  child: BlocListener<ShippingInformationBloc, ShippingInformationState>(
              bloc: shippingInformationBloc,
  listener: (context, state) {
   if(state is ShippingInformationLoading){

   }else if(state is ShippingInformationFailure){
     Navigator.pop(context);
     Navigator.pop(context);
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(state.message)),
     );
   }else if(state is ShippingInformationSuccess){
     Navigator.pop(context);
     Navigator.pop(context);
     addressesBloc.add(AddressesFetched(userPreferences.userToken!,0));

   }
  },
  child: AlertDialog(

              content: Container(
                height: 50.h,
                alignment: AlignmentDirectional.center,
                child: Text(AppStrings.deleteAddress.tr(),
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
                    deleteAddressBloc.add(DeleteAddressButtonPressed(itemId: id, authorization: authorization));

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
            ),
),
),
          );
      },
    );
  }

  }

import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/presentation/check_out/check_out_bloc/check_out_bloc.dart';
import 'package:ozon/presentation/check_out/delete_coupoun_bloc/delete_coupoun_bloc.dart';
import 'package:ozon/presentation/check_out/generate_invoice_bloc/generate_invoice_bloc.dart';
import 'package:ozon/presentation/check_out/widgets/cart_item_widget.dart';
import 'package:ozon/presentation/main/bloc/apply_coupon_bloc/apply_coupon_bloc.dart';
import 'package:ozon/presentation/main/bloc/create_cart_bloc/create_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/estimate_method_bloc/estimate_method_bloc.dart';
import 'package:ozon/presentation/main/bloc/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:ozon/presentation/payment_method_view/bloc/set_payment_information_bloc.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../../domain/model/estimate_shipping_method.dart';
import '../../../domain/model/order_model.dart';
import '../../../domain/model/shipping_information_model.dart';
import '../../../domain/model/state_model.dart';
import '../../main/bloc/cart_bloc/cart_bloc.dart';
import '../../main/bloc/cart_local/cart_local_bloc.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../main/view/widgets/cart_widget.dart';
import '../../payment/order_bloc/order_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../widgets/forward_arrow.dart';
class CheckOutView extends StatefulWidget {
 final  EstimateShippingMethod estimatedShippingMethod;
 final  ShippingInformationModel shippingInformationMethod;
 final AddressDomain addressDomain;
  const CheckOutView({super.key,required this.estimatedShippingMethod,required this.shippingInformationMethod,required this.addressDomain});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  OrderBloc orderBloc = instance<OrderBloc>();
  final TextEditingController _voucherController = TextEditingController();
  CartBloc cartBloc =GetIt.I<CartBloc>();
  int defaultAddressIndex =0;
  AddressModel ? addressModel;
  final UserBloc userBloc =  GetIt.I<UserBloc>();
  final CartLocalBloc cartLocalBloc = instance<CartLocalBloc>();
  final GenerateInvoiceBloc generateInvoiceBloc = instance<GenerateInvoiceBloc>();
  final ApplyCouponBloc applyCouponBloc = instance<ApplyCouponBloc>();
  UserPreferences userPreferences = GetIt.I<UserPreferences>();
  final DeleteCoupounBloc deleteCoupounBloc = instance<DeleteCoupounBloc>();
  CheckOutBloc checkOutBloc = instance<CheckOutBloc>();
  CheckOutBloc checkOutBloc2 = instance<CheckOutBloc>();

  Map<String,dynamic>  createMap(AddressShippingModel address) {
    // Check if the addresses list is null or empty
    Map<String,dynamic> estimatedMap ={};


    bool isDefaultAddressExists = false;




      Map<String,dynamic> map ={};
      map['region'] =address.region;
      map['region_id'] = address.regionId;
      map['region_code'] = "";
      map['country_id'] = address.countryId;
      map['street'] = address.countryId;
    map["street"]=[address.street![0]];
      map['telephone'] = address.telephone;
      map['firstname'] = address.firstname;
      map['lastname'] = address.lastname;
      map['email'] = userPreferences.email;
      estimatedMap['address'] = map;


    return estimatedMap; // Return null if no default address is found
  }
  String voucherCode ="";
  String userLoginToken ="";
  SetPaymentInformationBloc _setPaymentInformationBloc = instance<SetPaymentInformationBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
     }
  StateModel ?  mStateModel;
  Map<String,dynamic> map ={};
  void initView()async{
    await Future.delayed(Duration.zero);
    mStateModel= await GetIt.I<AppPreferences>().getState();
    voucherCode = widget.shippingInformationMethod.checkOutModel.coupounCode!;
    if( voucherCode.isNotEmpty){
      _voucherController.text = widget.shippingInformationMethod.checkOutModel.coupounCode.toString();

    }

    userLoginToken = userPreferences.userToken!;

    Map<String,dynamic> paymentMethodMap ={};
    String lastPart = widget.shippingInformationMethod.paymentMethods[0].code.split('_').last;

    paymentMethodMap['method'] = widget.shippingInformationMethod.paymentMethods[0].code;
    map['paymentMethod'] = paymentMethodMap;
    Map<String,dynamic> billingAddressMap ={};
    billingAddressMap['region'] =mStateModel!.name;
    billingAddressMap['region_id'] = mStateModel!.stateId;
    billingAddressMap['region_code'] =mStateModel!.stateId;
    billingAddressMap['country_id'] = widget.addressDomain!.countryId;
    billingAddressMap['city'] = widget.addressDomain!.region.region;
    List<String> streets =[];

    for(int j=0;j<widget.addressDomain!.street.length;j++){
      streets.add(widget.addressDomain!.street[j]);


    }
    billingAddressMap["street"] =streets;
    billingAddressMap['postcode']= widget.addressDomain.postalCode;
    billingAddressMap['telephone'] =widget. addressDomain.telephone;
    billingAddressMap['firstname'] =widget. addressDomain.firstname;
    billingAddressMap['lastname'] = widget.addressDomain.lastname;
    billingAddressMap['email'] = userPreferences.email.toString().trim();
    billingAddressMap['postcode'] =widget.addressDomain.postalCode;
    map['billing_address'] = billingAddressMap;
    cartBloc.add(CartFetched(userLoginToken));


  }
  int selectedPaymentIndex =0;
  @override
  Widget build(BuildContext context) {

    String userLoginToken = userPreferences.userToken!;
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
              text: AppStrings.checkOut.tr(),
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


          body: BlocConsumer<CartBloc, CartState>(
            bloc: cartBloc,
            builder: (context, cartState) {
              if (cartState is CartLoading) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              } else if (cartState is CartFailure) {
                return Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.center,
                  child: Text(cartState.message,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w500

                    ),),
                );
              } else if (cartState is CartSuccess) {
                _setPaymentInformationBloc.add(setPaymentInformationFetched(userPreferences.userToken!,map,0));


                 return BlocBuilder<SetPaymentInformationBloc, SetPaymentInformationState>(
                   bloc: _setPaymentInformationBloc,
  builder: (context, setPaymentInformationState) {
    if(setPaymentInformationState is SetPaymentInformationLoading){
      return Container(
        alignment: AlignmentDirectional.center,
        child: SizedBox(
            height: 150.w,
            width: 150.w,
            child: Lottie.asset(ImageAssets.loadingView)),

      );
    }else if(setPaymentInformationState is SetPaymentInformationFailure){
      return Container(
        color: Colors.white,
        alignment: AlignmentDirectional.center,
        child: Text(setPaymentInformationState.message,
          style: Theme
              .of(context)
              .textTheme
              .titleLarge!
              .copyWith(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.w500

          ),),
      );
    }else if(setPaymentInformationState is SetPaymentInformationSuccess){
      checkOutBloc.add(CheckOutFetched(authorization: userLoginToken));
      return Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),

              child: Container(
                margin: EdgeInsets.all(10.w),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Container(

                      child: Text(AppStrings.shippingAddress.tr(),
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w500,



                        ),),
                    ),
                    SizedBox(height: 10.w,),


                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },

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

                                              child: Text('${AppStrings.defaultAddress.tr()}'
                                                ,
                                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                    color: ColorManager.mainBlack,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: ScreenUtil().setSp(14)

                                                ),),
                                            )),
                                            Expanded(flex:2,child: Container(
                                              alignment: AlignmentDirectional.centerStart,
                                              child: Text('${cartState.orderModel.extensionAttributes!.shippingAssignments![0].shippingsModel!.address!.countryId} , ${cartState.orderModel.extensionAttributes!.shippingAssignments![0].shippingsModel!.address!.city} , ${AppStrings.streetNo.tr()} ${cartState.orderModel.extensionAttributes!.shippingAssignments![0].shippingsModel!.address!.street![0]}'
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
                              Positioned.directional(textDirection: Directionality.of(context),
                                  top:0,
                                  bottom:0,
                                  end:20.w,
                                  child: Center(
                                    child: Container(
                                      height: 25.w,
                                      width: 80.w,
                                      alignment: AlignmentDirectional.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: ColorManager.primary.withAlpha(60),width: 0.5),
                                          borderRadius: BorderRadius.circular(12.w)
                                      ),
                                      child: Text(AppStrings.change.tr(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.primary,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp
                                        ),),
                                    ),
                                  ))

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.w,),
                    Container(height: 0.5,
                      width: ScreenUtil().screenWidth,
                      color: ColorManager.seperatorColor,),
                    SizedBox(height: 20.w,),
                    Container(

                      child: Text(AppStrings.paymentMethod.tr(),
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w500,



                        ),),
                    ),
                    SizedBox(height: 10.w,),

                    InkWell(
                      onTap: ()async{
                        Map<String,dynamic> map ={};
                        map['paymentMethods'] = widget.shippingInformationMethod.paymentMethods;
                        map['title']= AppStrings.paymentMethod.tr();
                        map['addressDomain']= widget.addressDomain;
                        var result = await      Navigator.pushNamed(context, Routes.paymentMethodRoute,arguments: map);
                        if(result != null){
                          selectedPaymentIndex = int.parse(result.toString());
                          setState(() {

                          });
                        }


                      },
                      child: Container(
                          height: 50.w,

                          width: ScreenUtil().screenWidth,
                          color: ColorManager.white,
                          child: Container(
                            height: ScreenUtil().screenHeight,
                            width: ScreenUtil().screenWidth,

                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            height: 50.w,
                                            width: 50.w,
                                            alignment: AlignmentDirectional.center,

                                            child: widget.shippingInformationMethod.paymentMethods[selectedPaymentIndex].code =="cashondelivery"?
                                            CommonImageView(
                                              height: 40.w,
                                              width: 40.w,
                                              svgPath:
                                              ImageAssets.cash ,

                                            ):
                                            CommonImageView(
                                                height: 40.w,
                                                width: 40.w,
                                                imagePath:ImageAssets
                                                    .imgMastercard)),

                                        SizedBox(width: 10.w,),
                                        Text(
                                            widget.shippingInformationMethod.paymentMethods[selectedPaymentIndex].title.contains("MyFatoorah")?"MyFatoorah":widget.shippingInformationMethod.paymentMethods[selectedPaymentIndex].title  ,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                            textAlign:
                                            TextAlign
                                                .left,
                                            style:Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color:
                                              ColorManager.mainBlack,
                                              fontSize: 14.sp,

                                              fontWeight: FontWeight.w500,
                                            ))
                                      ]),
                                ),
                                Positioned.directional(textDirection: Directionality.of(context),
                                    top:0,
                                    bottom:0,
                                    end:20.w,
                                    child: Center(
                                      child: Container(
                                        height: 25.w,
                                        width: 80.w,
                                        alignment: AlignmentDirectional.center,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: ColorManager.primary.withAlpha(60),width: 0.5),
                                            borderRadius: BorderRadius.circular(12.w)
                                        ),
                                        child: Text(AppStrings.change.tr(),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color: ColorManager.primary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp
                                          ),),
                                      ),
                                    ))
                              ],
                            ),
                          )),
                    ),
                    SizedBox(height: 20.w,),
                    Container(height: 0.5,
                      width: ScreenUtil().screenWidth,
                      color: ColorManager.seperatorColor,),
                    SizedBox(height: 20.w,),

                    //
                    Container(
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(

                              child: Text(AppStrings.shippingMethods.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: ColorManager.mainBlack,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w500,


                                ),),
                            ),
                            SizedBox(height: 10.w,),
                            InkWell(
                              onTap: () {

                              },
                              child: Container(
                                  height: 50.w,

                                  width: ScreenUtil().screenWidth,
                                  color: ColorManager.white,
                                  child: Container(
                                    height: ScreenUtil().screenHeight,
                                    width: ScreenUtil().screenWidth,

                                    child:  Row(

                                        children: [

                                          Container(
                                            height: 50.w,
                                            width: 50.w,
                                            alignment: Alignment.center,
                                            child: CustomIconButton(
                                                height: 40.w,
                                                width: 40.w,

                                                child: CommonImageView(
                                                    imagePath: ImageAssets
                                                        .imgDelivery)),
                                          ),
                                          Expanded(
                                            flex:1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [

                                                Text(
                                                    widget.estimatedShippingMethod.carrierTitle! ,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                    textAlign:
                                                    TextAlign
                                                        .left,
                                                    style:Theme.of(context).textTheme.displayMedium!.copyWith(
                                                      color:
                                                      ColorManager.mainBlack,
                                                      fontSize: 14.sp,

                                                      fontWeight: FontWeight.w500,
                                                    )),

                                                Text(
                                                    '${widget.estimatedShippingMethod.priceInclTax!} ${AppStrings.KD.tr()}' ,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                    textAlign:
                                                    TextAlign
                                                        .left,
                                                    style:Theme.of(context).textTheme.displayMedium!.copyWith(
                                                      color:
                                                      ColorManager.primary,
                                                      fontSize: 14.sp,

                                                      fontWeight: FontWeight.w500,
                                                    )),
                                              ],
                                            ),
                                          )
                                        ]),

                                  )),
                            ),
                          ],
                        )
                    ),
                    SizedBox(height: 20.w,),
                    Container(height: 0.5,
                      width: ScreenUtil().screenWidth,
                      color: ColorManager.seperatorColor,),
                    SizedBox(height: 20.w,),
                    Container(

                      child: Text(AppStrings.orderList.tr(),
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w500,



                        ),),
                    ),

                    Container(

                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.shippingInformationMethod.checkOutModel.list!.length
                        ,
                        itemBuilder: (context, index) {

                          return CartItemWidget(cartListItem: widget.shippingInformationMethod.checkOutModel.list![index],currency:widget.shippingInformationMethod.checkOutModel.baseCurrencyCode!);
                        }, separatorBuilder: (BuildContext context, int index) {
                        return Container(height:0.5,width: ScreenUtil().screenWidth,
                          color: ColorManager.gray300,);
                      },),
                    ),
                    Container(height: 280.h,),




                  ],
                ),
              ),
            ),
          ),
          Positioned.directional(textDirection: Directionality.of(context),
              bottom: 0,
              start: 0,
              end: 0,
              child: BlocBuilder<CheckOutBloc, CheckOutState>(
                bloc: checkOutBloc,
                builder: (context, state) {
                  if(state is CheckOutSuccess){
                    return Container(height: 250.h,
                      width: ScreenUtil().screenWidth,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.w), // Top corners radius
                          ),
                        ),
                        elevation: 4, // Set elevation
                        shadowColor: Colors.transparent,
                        child: Container(
                          margin: EdgeInsets.all(20.w),
                          child: Column(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: ColorManager.gray300,
                                      width: 0.5),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(flex:3,child: Container(
                                      child: TextFormField(


                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: ColorManager.mainBlack,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.normal


                                        ),
                                        obscureText: false,
                                        controller: _voucherController,
                                        decoration: InputDecoration(

                                          hintText: AppStrings.enterVoucher.tr(),
                                          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                              color: Colors.grey,
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.normal


                                          ),



                                        ),

                                      ),
                                    )),
                                    Expanded(flex:1,child: InkWell(
                                      onTap: (){
                                        String voucher = _voucherController.text;
                                        String coupounCode = _voucherController.text;

                                        if(voucherCode.isEmpty) {
                                          if (coupounCode
                                              .trim()
                                              .isNotEmpty) {
                                            FocusScope.of(context).unfocus();
                                            applyCouponBloc.add(ApplyCouponFetched(
                                                coupounCode, userLoginToken));
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(
                                                  AppStrings.couponCodeError.tr())),
                                            );
                                          }
                                        }else{
                                          print("delete");
                                          deleteCoupounBloc.add(DeleteCoupounButtonPressed(authorization: userLoginToken));

                                        }
                                      },
                                      child: BlocListener<ApplyCouponBloc, ApplyCouponState>(
                                        bloc: applyCouponBloc,
                                        listener: (context, applyCouponState) {
                                          if(applyCouponState is ApplyCouponLoading){
                                            showLoadingDialog(context);
                                          }else if(applyCouponState is ApplyCouponSuccess){
                                            voucherCode = _voucherController.text;
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(AppStrings.couponCodeApplied.tr())),
                                            );
                                            checkOutBloc.add(CheckOutFetched(authorization: userLoginToken));
                                          }else if(applyCouponState is ApplyCouponFailure){
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(applyCouponState.message)),
                                            );
                                          }
                                        },
                                        child: BlocListener<DeleteCoupounBloc, DeleteCoupounState>(
                                          bloc: deleteCoupounBloc,
                                          listener: (context, deleteCoupounState) {
                                            if(deleteCoupounState is DeleteCoupounLoading){
                                              Navigator.pop(context);
                                            }else if(deleteCoupounState is DeleteCoupounFailure) {
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(
                                                    AppStrings.couponCodeError.tr())),
                                              );
                                            }else if(deleteCoupounState is DeleteCoupounSuccess){
                                              Navigator.pop(context);
                                              voucherCode ="";
                                              _voucherController.text = "";
                                              checkOutBloc.add(CheckOutFetched(authorization: userLoginToken));
                                              setState(() {

                                              });

                                            }
                                            // TODO: implement listener
                                          },

                                          child: Container(
                                            margin: EdgeInsets.symmetric(vertical: 4.w,horizontal: 4.w),
                                            child: Container(
                                              alignment: AlignmentDirectional.center,
                                              color: ColorManager.primary,
                                              child: Text(AppStrings.apply.tr(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                    color: ColorManager.white,
                                                    fontSize: ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.normal
                                                ),),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.w,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(AppStrings.subtotal.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: ColorManager.secondaryBlack,
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.normal
                                  ),),
                                  Text('${state.checkOutModel.subtotal} ${AppStrings.kd
                                      .tr()}',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                        color: ColorManager.mainBlack,
                                        fontWeight: FontWeight.normal,
                                        fontSize: ScreenUtil().setSp(14)
                                    ),)



                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.w,),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(AppStrings.shippingCost.tr(), style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.normal
                                        ),),
                                        Text('${state.checkOutModel.shippingAmount} ${AppStrings.kd
                                            .tr()}',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                              color: ColorManager.mainBlack,
                                              fontWeight: FontWeight.normal,
                                              fontSize: ScreenUtil().setSp(14)
                                          ),)



                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.w,),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(AppStrings.voucher.tr(), style: Theme
                                            .of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.normal
                                        ),),
                                        Text('${state.checkOutModel.discountAmount} ${AppStrings.kd
                                            .tr()}',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                              color: ColorManager.mainBlack,
                                              fontWeight: FontWeight.normal,
                                              fontSize: ScreenUtil().setSp(14)
                                          ),)



                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.w,),
                              DottedLine(
                                dashColor: Colors.grey,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.w,),
                                  Container(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(AppStrings.total.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.normal
                                        ),),
                                        Text('${state.checkOutModel.grandTotal} ${AppStrings.kd
                                            .tr()}',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                              color: ColorManager.mainBlack,
                                              fontWeight: FontWeight.normal,
                                              fontSize: ScreenUtil().setSp(14)
                                          ),)



                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.w,),
                              BlocListener<OrderBloc, OrderState>(
                                bloc: orderBloc,
                                listener: (context, orderState) {
                                  if(orderState is OrderLoading){
                                    showLoadingDialog(context);
                                  }
                                  else if(orderState is OrderFailure){
                                    dismissLoadingDialog();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          orderState.message)),
                                    );
                                  }
                                  else if(orderState is OrderSuccess){
                                    dismissLoadingDialog();
                                    Map<String,dynamic> map ={};
                                    map['orderId'] =orderState.orderId;
                                    map['title']= AppStrings.paymentSuccess.tr();
                                    Navigator.pushNamed(context, Routes.successRoute,arguments: map);
                                  }
                                },
                                child: BlocListener<GenerateInvoiceBloc, GenerateInvoiceState>(
                                    bloc: generateInvoiceBloc,
                                    listener: (context, generateInvoiceState) {
                                      if(generateInvoiceState is GenerateInvoiceLoading){
                                        showLoadingDialog(context);
                                      }else if(generateInvoiceState is GenerateInvoiceFailure){
                                        dismissLoadingDialog();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(
                                              generateInvoiceState.message)),
                                        );
                                      }else if(generateInvoiceState is GenerateInvoiceSuccess){
                                        dismissLoadingDialog();
                                        String url = generateInvoiceState.list[1];
                                        int id  = generateInvoiceState.list[0];
                                        String invoiceId = '${id}';
                                        print(invoiceId);
                                        Map<String,dynamic> map ={};
                                        String lastPart = widget.shippingInformationMethod.paymentMethods[selectedPaymentIndex].code;


                                        map['url']= url;
                                        map['invoiceId'] = invoiceId;
                                        map['paymentMethod']= lastPart;
                                        map['title']= AppStrings.payment.tr();
                                        map['amount']= state
                                            .checkOutModel
                                            .grandTotal;
                                        Navigator.pushNamed(context, Routes.paymentRoute,arguments: map);
                                      }
                                      // TODO: implement listener
                                    },
                                    child:     InkWell(
                                      onTap:() {
                                        if (widget.shippingInformationMethod
                                            .paymentMethods[selectedPaymentIndex]
                                            .code == "cashondelivery") {
                                          UserPreferences userPreferences = GetIt.I<UserPreferences>();
                                          // GetIt.I<CreateCartBloc>().add(CreateCartFetched(userPreferences.userToken!));
                                          GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));


                                          String userLoginToken = userPreferences.userToken!;
                                          Map<String,dynamic> paymentMethod ={};
                                          paymentMethod['method'] ='cashondelivery';
                                          Map<String,dynamic> map ={};
                                          map['paymentMethod'] = paymentMethod;

                                          orderBloc.add(OrderFetched(userLoginToken, map));

                                        } else {
                                          generateInvoiceBloc.add(
                                              GenerateInvoiceFetched(
                                                  authoriztion: Constants
                                                      .headerValue,
                                                  invoiceValue: state
                                                      .checkOutModel
                                                      .grandTotal
                                                      .toString(),
                                                  customerName: '${cartState
                                                      .orderModel
                                                      .billingAddress!
                                                      .firstname} ${cartState
                                                      .orderModel
                                                      .billingAddress!
                                                      .lastname}',
                                                  countryCode: cartState
                                                      .orderModel
                                                      .billingAddress!
                                                      .countryId!));
                                        }
                                      },
                                      child: Container(
                                        height: 44.w,
                                        alignment: AlignmentDirectional.center,
                                        width: ScreenUtil().screenWidth,
                                        decoration: BoxDecoration(
                                            color: ColorManager.primary,
                                            borderRadius: BorderRadius.circular(22.w)

                                        ),

                                        child: Text(AppStrings.payment.tr(),
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color: ColorManager.white,
                                              fontSize: ScreenUtil().setSp(14),
                                              fontWeight: FontWeight.normal
                                          ),),
                                      ),
                                    )

                                ),
                              ),


                            ],
                          ),
                        ),

                      ),);
                  }else{
                    return Container();
                  }

                },
              ))
        ],
      );
    }else{
      return Container();
    }

  },
);;
              } else {
                return Container();
              }
            },
            listener: (context, state) {
              if (state is CartSuccess) {
                if (state.orderModel.items.isNotEmpty) {
                  cartLocalBloc.add(
                      AddCartLocalListItems(state.orderModel.items));
                }
              }
            },
          ),

        ),
      ),
    );
  }
}

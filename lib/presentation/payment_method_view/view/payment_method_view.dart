
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/presentation/payment_method_view/bloc/set_payment_information_bloc.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/user_prefrences.dart';
import '../../../domain/model/shipping_information_model.dart';
import '../../../domain/model/state_model.dart';
import '../../check_out/widgets/forward_arrow.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_icon_button.dart';

class PaymentMethodView extends StatefulWidget {
  final List<PaymentMethodInformationModel> paymentMethods;
  final AddressDomain addressDomain;

  const PaymentMethodView({super.key,required this.paymentMethods,required this.addressDomain});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  SetPaymentInformationBloc _setPaymentInformationBloc = instance<SetPaymentInformationBloc>();
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
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
              text: AppStrings.paymentMethod.tr(),
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
          backgroundColor: ColorManager.gray100,
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 3.w,
          //   title: AppbarTitle(
          //     text: AppStrings.paymentMethod.tr(),
          //   ),
          //   leading:
          //   AppbarIconbutton(
          //       svgPath: isRtl() ?
          //       ImageAssets.imgArrowright : ImageAssets.imgArrowleft,
          //       onTap: () {
          //         Navigator.pop(context);
          //       }),
          //
          //
          // ),
          body: Container(
            margin: EdgeInsets.all(10.w),
            child:
            BlocListener<SetPaymentInformationBloc, SetPaymentInformationState>(
              bloc: _setPaymentInformationBloc,
  listener: (context, state) {
                if(state is SetPaymentInformationLoading){

                  showLoadingDialog(context);
                }else if(state is SetPaymentInformationFailure){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }else if(state is SetPaymentInformationSuccess){
                  Navigator.pop(context);
                  Navigator.pop(context,state.index);
                }
    // TODO: implement listener
  },
  child: ListView.separated(itemBuilder: (context,index){
              return InkWell(
                onTap: ()async{

                  StateModel ?  mStateModel= await GetIt.I<AppPreferences>().getState();
                  print(widget.paymentMethods[index].code);
                  Map<String,dynamic> map ={};
                  Map<String,dynamic> paymentMethodMap ={};
                  String lastPart = widget.paymentMethods[index].code.split('_').last;

                  paymentMethodMap['method'] = widget.paymentMethods[index].code;
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
                  print(map);
                  _setPaymentInformationBloc.add(setPaymentInformationFetched(userPreferences.userToken!,map,index));


                },
                child: Container(
                    height: 50.w,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    width: ScreenUtil().screenWidth,

                    child: Container(
                      height: ScreenUtil().screenHeight,
                      width: ScreenUtil().screenWidth,

                      child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(



                                child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [


                                      Container(
                                          height: 50.w,
                                          width: 50.w,
                                          alignment: AlignmentDirectional.center,

                                          child:  widget.paymentMethods[index].code =="cashondelivery"?
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
                                          widget.paymentMethods[index].title  ,
                                          overflow:
                                          TextOverflow
                                              .ellipsis,
                                          textAlign:
                                          TextAlign
                                              .left,
                                          style:Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color:
                                            ColorManager.black,
                                            fontSize: 14.sp,

                                            fontWeight: FontWeight.w500,
                                          )),
                                    ])),
                            ForwardArrow()

                          ]),
                    )),
              );
            }, separatorBuilder: (context,index){
              return Column(
                children: [
                  Container(height: 5.w,),
                  Container(height: 0.5,
                    width: ScreenUtil().screenWidth,
                    color: ColorManager.seperatorColor,
                  ),
                  Container(height: 5.w,),
                ],
              );
            }, itemCount: widget.paymentMethods.length),
),
          ),
        ),
      ),
    );
  }
}

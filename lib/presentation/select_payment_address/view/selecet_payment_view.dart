import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/domain/model/shipping_information_model.dart';
import 'package:ozon/domain/model/state_model.dart';
import 'package:ozon/presentation/add_address/bloc/default_city_bloc/default_city_bloc.dart';
import 'package:ozon/presentation/main/bloc/estimate_method_bloc/estimate_method_bloc.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/app_prefrences.dart';
import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../../domain/model/adresses_model.dart';
import '../../../domain/model/estimate_shipping_method.dart';
import '../../add_address/bloc/add_address_bloc/add_address_bloc.dart';
import '../../addresses/bloc/addresses_bloc.dart';
import '../../main/bloc/shipping_information/shipping_information_bloc.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
class SelecetPaymentView extends StatefulWidget {
  const SelecetPaymentView({super.key});

  @override
  State<SelecetPaymentView> createState() => _SelecetPaymentViewState();
}

class _SelecetPaymentViewState extends State<SelecetPaymentView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  AddressDomain? selectedAddressDomain;
  List<AddressDomain> addresses = [];
  final DefaultCityBloc defaultCityBloc = instance<DefaultCityBloc>();
  final AddAddressBloc addAddressBloc = instance<AddAddressBloc>();
  final EstimateMethodBloc estimateMethodBloc = instance<EstimateMethodBloc>();
  AddressesBloc addressesBloc =  GetIt.I<AddressesBloc>();
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  UserBloc userBloc = GetIt.I<UserBloc>();
  ShippingInformationBloc shippingInformationBloc = instance<ShippingInformationBloc>();
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.w,
            title: AppbarTitle(
              text: AppStrings.selectAddress.tr(),
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

         body: Stack(
           children: [
             Positioned.fill(

               child: BlocBuilder<DefaultCityBloc, DefaultCityState>(
                 bloc: defaultCityBloc..add(DefaultCityFetched()),
                builder: (context, defaultCityState) {
                       if(defaultCityState is DefaultCityLoading){
                return Container(
                  alignment: AlignmentDirectional.center,
                  child:    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
                       }else if(defaultCityState is DefaultCitySuccess){
                return BlocBuilder<AddressesBloc, AddressesState>(
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
                        color: Colors.white,
                        alignment: AlignmentDirectional.center,
                        child: Text(state.message,
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
                    }else if(state is AddressesSuccess){
                      if(state.customerDomain.addresses.isEmpty){
                        return Container(
                          height: ScreenUtil().screenHeight,
                          width: ScreenUtil().screenWidth,
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(

                                child: Text(AppStrings.noAddressFound.tr(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(18),
                                        fontWeight: FontWeight.w500

                                    )),

                              ),
                              SizedBox(height: 10.w,),
                              InkWell(
                                onTap: (){
                                  Map<String,dynamic> map={};

                                  map['title']= AppStrings.addAddress.tr();
                                  Navigator.pushNamed(context, Routes.addAddressRoute,arguments: map);

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
                                  child: Text(AppStrings.addAddress.tr(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal
                                    ),),

                                ),
                              )

                            ],
                          ),
                        );
                      }else{
                        addresses.clear();

                        for(int i =0;i<state.customerDomain.addresses.length;i++){
                          print('state.customerDomain.addresses[i].city ==> ${state.customerDomain.addresses[i].city}');
                          print('defaultCityState.mStateModel.name ---> ${defaultCityState.mStateModel.name}');

                          if(defaultCityState.mStateModel.name== state.customerDomain.addresses[i].city){
                            addresses.add(state.customerDomain.addresses[i]);

                          }
                        }
                        if(addresses.isEmpty){
                          return Container(
                            height: ScreenUtil().screenHeight,
                            width: ScreenUtil().screenWidth,
                            alignment: AlignmentDirectional.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(

                                  child: Text(AppStrings.noAddressFound.tr(),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(18),
                                          fontWeight: FontWeight.w500

                                      )),

                                ),
                                SizedBox(height: 10.w,),
                                InkWell(
                                  onTap: (){
                                    Map<String,dynamic> map={};

                                    map['title']= AppStrings.addAddress.tr();
                                    Navigator.pushNamed(context, Routes.addAddressRoute,arguments: map);

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
                                    child: Text(AppStrings.addAddress.tr(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                          color: ColorManager.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal
                                      ),),

                                  ),
                                )

                              ],
                            ),
                          );
                        }else{
                          return Stack(
                            children: [
                              Positioned.fill(
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context,index){
                                      return InkWell(
                                          onTap: ()async{
                                            int selectedId = addresses[index].id;
                                            int selectedIndex =-1;

                                            for(int i =0;i<state.customerDomain.addresses.length;i++){
                                              if(state.customerDomain.addresses[i].id == selectedId){
                                                selectedIndex = i;
                                                break;
                                              }


                                            }
                                            if(!state.customerDomain.addresses[selectedIndex].defaultShipping){
                                              isSelectedItem = true;
                                              String email =state.customerDomain.email;
                                              int userId = state.customerDomain.id;
                                              String userFirstName = state.customerDomain.firstname;
                                              String userLastName = state.customerDomain.lastname;
                                              CustomerDomain customerDomain =state.customerDomain;
                                              Map<String,dynamic> userMap = {};
                                              userMap['id'] = userId;
                                              userMap['email'] = email;
                                              userMap['firstname'] = userFirstName;
                                              userMap['lastname'] = userLastName;
                                              StateModel ?  mStateModel= await GetIt.I<AppPreferences>().getState();
                                              List<Map<String,dynamic> >  addressList= [];
                                              for(int i =0;i<customerDomain.addresses.length;i++){
                                                if(customerDomain.addresses[i].id == customerDomain.addresses[selectedIndex].id){
                                                  AddressDomain addressDomain = customerDomain.addresses[i];

                                                  Map<String,dynamic> addressMap = {};
                                                  Map<String,dynamic> regionMap ={};
                                                  regionMap['region_code']=mStateModel!.stateId;
                                                  regionMap['region']=addressDomain.region.region;
                                                  regionMap['region_id']=addressDomain.region.regionId;
                                                  addressMap['region'] = regionMap;
                                                  addressMap['firstname'] = addressDomain.firstname;
                                                  addressMap['lastname'] = addressDomain.lastname;
                                                  addressMap['country_id'] = addressDomain.countryId;
                                                  List<String> streets = [];
                                                  streets.add(addressDomain.street[0]);
                                                  addressMap['street'] = streets;
                                                  addressMap['telephone'] = addressDomain.telephone;
                                                  addressMap['city'] = mStateModel.name;
                                                  addressMap['postcode'] = addressDomain.postalCode;
                                                  addressMap['default_shipping'] = true;


                                                  addressMap['default_billing'] = true;

                                                  List<Map<String,dynamic>> customAttributes =[];
                                                  Map<String,dynamic> customAttribute = {};
                                                  customAttribute["attribute_code"]="building_nubmber";
                                                  for(int j=0;j<addressDomain.customAttributes.length;j++){
                                                    if(addressDomain.customAttributes[j].attributeCode=="building_nubmber"){
                                                      customAttribute["value"]=addressDomain.customAttributes[j].value;
                                                      break;
                                                    }

                                                  }
                                                  customAttributes.add(customAttribute);
                                                  Map<String,dynamic> customAttributeFlat = {};
                                                  customAttributeFlat["attribute_code"]="flat_number";
                                                  for(int j=0;j<addressDomain.customAttributes.length;j++){
                                                    if(addressDomain.customAttributes[j].attributeCode=="flat_number"){
                                                      customAttributeFlat["value"]=addressDomain.customAttributes[j].value;
                                                      break;
                                                    }

                                                  }
                                                  customAttributes.add(customAttributeFlat);
                                                  Map<String,dynamic> customAttributeCivilId = {};
                                                  customAttributeCivilId["attribute_code"]="civil_id";
                                                  customAttributeCivilId["value"]="0000000000";
                                                  customAttributes.add(customAttributeCivilId);
                                                  addressMap["custom_attributes"]= customAttributes;
                                                  addressList.add(addressMap);

                                                }
                                                else{
                                                  AddressDomain addressDomain = customerDomain.addresses[i];

                                                  Map<String,dynamic> addressMap = {};
                                                  Map<String,dynamic> regionMap ={};
                                                  regionMap['region_code']=mStateModel!.stateId;;
                                                  regionMap['region']=addressDomain.region.region;
                                                  regionMap['region_id']=addressDomain.region.regionId;
                                                  addressMap['region'] = regionMap;
                                                  addressMap['firstname'] = addressDomain.firstname;
                                                  addressMap['lastname'] = addressDomain.lastname;
                                                  addressMap['country_id'] = addressDomain.countryId;
                                                  addressMap['postcode'] = addressDomain.postalCode;
                                                  List<String> streets = [];
                                                  streets.add(addressDomain.street[0]);
                                                  addressMap['street'] = streets;
                                                  addressMap['telephone'] = addressDomain.telephone;
                                                  addressMap['city'] = addressDomain.city;

                                                  addressMap['default_shipping'] = false;


                                                  addressMap['default_billing'] = false;

                                                  List<Map<String,dynamic>> customAttributes =[];
                                                  Map<String,dynamic> customAttribute = {};
                                                  customAttribute["attribute_code"]="building_nubmber";
                                                  for(int j=0;j<addressDomain.customAttributes.length;j++){
                                                    if(addressDomain.customAttributes[j].attributeCode=="building_nubmber"){
                                                      customAttribute["value"]=addressDomain.customAttributes[j].value;
                                                      break;
                                                    }

                                                  }
                                                  customAttributes.add(customAttribute);
                                                  Map<String,dynamic> customAttributeFlat = {};
                                                  customAttributeFlat["attribute_code"]="flat_number";
                                                  for(int j=0;j<addressDomain.customAttributes.length;j++){
                                                    if(addressDomain.customAttributes[j].attributeCode=="flat_number"){
                                                      customAttributeFlat["value"]=addressDomain.customAttributes[j].value;
                                                      break;
                                                    }

                                                  }
                                                  customAttributes.add(customAttributeFlat);
                                                  Map<String,dynamic> customAttributeCivilId = {};
                                                  customAttributeCivilId["attribute_code"]="civil_id";
                                                  customAttributeCivilId["value"]="0000000000";
                                                  customAttributes.add(customAttributeCivilId);
                                                  addressMap["custom_attributes"]= customAttributes;
                                                  addressList.add(addressMap);
                                                }

                                              }

                                              userMap['addresses']= addressList;
                                              Map<String,dynamic> map = {};
                                              map['customer'] = userMap;

                                              addAddressBloc.add(AddAddressFetched(map,userPreferences.userToken!,index));

                                            }

                                          },
                                        child: Container(
                                          width: ScreenUtil().screenWidth,

                                          height: 50.w,
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
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

                                                                      child: Text('${addresses[index].defaultShipping?AppStrings.defaultAddress.tr():AppStrings.notDefaultAddress.tr()}'
                                                                        ,
                                                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                                            color: ColorManager.mainBlack,
                                                                            fontWeight: FontWeight.normal,
                                                                            fontSize: ScreenUtil().setSp(14)

                                                                        ),),
                                                                    )),
                                                                    Expanded(flex:2,child: Container(
                                                                      alignment: AlignmentDirectional.centerStart,
                                                                      child: Text('${addresses[index].countryId} , ${addresses[index].city} , ${AppStrings.streetNo.tr()} ${state.customerDomain.addresses[index].street[0]}'
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
                                              Positioned.directional(textDirection: Directionality.of(context),
                                                  top: 0,
                                                  bottom: 0,
                                                  end: 20.w,
                                                  child: BlocListener<AddAddressBloc, AddAddressState>(
                                                    bloc: addAddressBloc,

                                                    listener: (context, state) {
                                                      if(state is AddAddressLoading){
                                                        if(state.index == index) {
                                                          showLoadingDialog(
                                                              context);
                                                        }
                                                      }else if(state is AddAddressFailure){
                                                        if(state.index == index) {
                                                          Navigator.pop(context);
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(content: Text(state.message)),
                                                          );
                                                        }
                                                      }else if(state is AddAddressSuccess){
                                                        if(state.index == index) {
                                                          Navigator.pop(context);
                                                          addressesBloc.add(AddressesFetched(userPreferences.userToken!, 0));
                                                        }
                                                      }

                                                      // TODO: implement listener
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.all(10.w),
                                                      child: addresses[index].defaultShipping?
                                                      Icon(Icons.radio_button_checked,color: ColorManager.primary,
                                                        size: 20.w,):Icon(Icons.radio_button_off,color: ColorManager.primary,
                                                        size: 20.w,),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );

                                    }, separatorBuilder: (context,index){
                                  return Container(height: 10.h,);
                                }, itemCount: addresses.length),
                              ),

                              Positioned.directional(textDirection: Directionality.of(context),
                                  bottom: 0,
                                  start: 0,
                                  end: 0,
                                  child:      Container(
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
                                        child:isAddressSelected(state.customerDomain)?
                                        BlocListener<EstimateMethodBloc, EstimateMethodState>(
                                          bloc: estimateMethodBloc,
                                          listener: (context, estimateMethodState) async{
                                            if(estimateMethodState is EstimateMethodLoading){
                                              showLoadingDialog(context);

                                            }else if(estimateMethodState is EstimateMethodFailure){
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(estimateMethodState.message)),
                                              );
                                            } else if(estimateMethodState is EstimateMethodSuccess){
                                              StateModel ?  mStateModel= await GetIt.I<AppPreferences>().getState();
                                              AddressDomain addressDomain = state.customerDomain.addresses[selectedIndex];
                                              Map<String,dynamic> addressInformationMap ={};
                                              String  carrierCode = estimateMethodState.estimateMethodList[0].carrierCode;
                                              String methodCode  =estimateMethodState.estimateMethodList[0].methodCode;
                                              addressInformationMap['shipping_method_code']= methodCode;
                                              addressInformationMap['shipping_carrier_code']= carrierCode;
                                              Map<String,dynamic> shippingMap ={};
                                              shippingMap['region'] =mStateModel!.name;
                                              shippingMap['region_id'] = mStateModel!.stateId;
                                              shippingMap['region_code'] =mStateModel!.stateId!;
                                              shippingMap['postcode'] = addressDomain.postalCode;
                                              shippingMap['country_id'] = addressDomain!.countryId;
                                              shippingMap['city'] = addressDomain!.region.region;


                                              List<String> streets =[];

                                              for(int j=0;j<addressDomain!.street.length;j++){
                                                streets.add(addressDomain!.street[j]);


                                              }
                                              shippingMap["street"] =streets;


                                              shippingMap['telephone'] = addressDomain!.telephone;
                                              shippingMap['firstname'] = addressDomain!.firstname;
                                              shippingMap['lastname'] = addressDomain!.lastname;
                                              shippingMap['email'] = userPreferences.email;
                                              addressInformationMap['shipping_address']=shippingMap;

                                              if(selectedIndex != -1){
                                                Map<String,dynamic> billingMap ={};
                                                billingMap['postcode'] = addressDomain.postalCode;
                                                billingMap['region'] =mStateModel.name;
                                                billingMap['region_id'] = mStateModel.stateId;
                                                billingMap['region_code'] =mStateModel.stateId;
                                                billingMap['postcode']= addressDomain.postalCode;
                                                billingMap['country_id'] = addressDomain!.countryId;
                                                billingMap['city'] = addressDomain!.region.region;
                                                // for(int j=0;j<addressDomain!.customAttributes!.length;j++){
                                                //   if(addressDomain!.customAttributes![j].attributeCode=="flat_number"){
                                                //     billingMap["flat_number"]=addressDomain!.customAttributes![j].value;
                                                //     break;
                                                //   }
                                                //
                                                // }
                                                List<String> streets =[];

                                                for(int j=0;j<addressDomain!.street.length;j++){
                                                  streets.add(addressDomain!.street[j]);


                                                }
                                                billingMap["street"] =streets;
                                                // for(int j=0;j<addressDomain.customAttributes.length;j++){
                                                //   if(addressDomain.customAttributes[j].attributeCode=="building_nubmber"){
                                                //     billingMap["building_nubmber"]=addressDomain.customAttributes[j].value;
                                                //     break;
                                                //   }
                                                //
                                                // }
                                                billingMap['telephone'] = addressDomain!.telephone;
                                                billingMap['firstname'] = addressDomain!.firstname;
                                                billingMap['lastname'] = addressDomain!.lastname;
                                                billingMap['email'] = userPreferences.email;
                                                addressInformationMap['billing_address']=billingMap;
                                              }
                                              Map<String,dynamic> map ={};
                                              map['addressInformation'] = addressInformationMap;
                                              shippingInformationBloc.add(ShippingInformationFetched(userPreferences.userToken!, map));


                                            }
                                          },
                                          child: BlocListener<ShippingInformationBloc, ShippingInformationState>(
                                            bloc: shippingInformationBloc,
                                            listener: (context, shippingInformationState) {
                                              if(shippingInformationState is ShippingInformationLoading){

                                              }else if(shippingInformationState is ShippingInformationFailure){
                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text(shippingInformationState.message)),
                                                );
                                              }else if(shippingInformationState is ShippingInformationSuccess){
                                                Navigator.pop(context);
                                                EstimateShippingMethod estimatedShippingMethod = (estimateMethodBloc.state as EstimateMethodSuccess).estimateMethodList[0];
                                                ShippingInformationModel shippingInformationMethod = shippingInformationState.shippingInformationModel!;
                                                Map<String,dynamic> map = {};
                                                map['estimatedShippingMethod']= estimatedShippingMethod;
                                                map['shippingInformationMethod']= shippingInformationMethod;
                                                map['addressDomain']= selectedAddressDomain;


                                                map['title']= AppStrings.cart.tr();




                                                // Navigator.pushNamed(context, Routes.checkOutRoute,arguments: map);
                                                Navigator.pushNamed(context, Routes.checkOutRoute,arguments: map);
                                              }
                                            },
                                            child: InkWell(
                                                  onTap: ()async{
                                                    int indexSelected = -1;

                                                    for(int i =0;i<state.customerDomain.addresses.length;i++){
                                                      if(state.customerDomain.addresses[i].defaultShipping){
                                                        indexSelected = i;
                                                        selectedAddressDomain = state.customerDomain.addresses[i];
                                                      }

                                                    }

                                                  if(indexSelected !=-1){
                                                    StateModel ?  mStateModel= await GetIt.I<AppPreferences>().getState();
                                                    AddressDomain   addressDomain = state.customerDomain.addresses[indexSelected];
                                                    Map<String,dynamic> estimatedMap ={};
                                                    Map<String,dynamic> map ={};
                                                    map['region'] =mStateModel!.name;
                                                    map['region_id'] = mStateModel!.stateId;
                                                    map['region_code'] =mStateModel!.stateId;
                                                    map['country_id'] = addressDomain!.countryId;
                                                    map['city'] = addressDomain!.region.region;
                                                    // map["flat_number"] ="";
                                                    // for(int j=0;j<addressDomain!.customAttributes!.length;j++){
                                                    //   if(addressDomain!.customAttributes![j].attributeCode=="flat_number"){
                                                    //     map["flat_number"]=[addressDomain!.customAttributes![j].value];
                                                    //     break;
                                                    //   }
                                                    //
                                                    // }

                                                    List<String> streets =[];

                                                    for(int j=0;j<addressDomain!.street.length;j++){
                                                      streets.add(addressDomain!.street[j]);


                                                    }
                                                    map["street"] =streets;
                                                    // map["building_nubmber"] ="";
                                                    // for(int j=0;j<addressDomain.customAttributes.length;j++){
                                                    //   if(addressDomain.customAttributes[j].attributeCode=="building_nubmber"){
                                                    //     map["building_nubmber"]=addressDomain.customAttributes[j].value;
                                                    //     break;
                                                    //   }
                                                    //
                                                    // }
                                                    map['postcode']= addressDomain.postalCode;
                                                    map['telephone'] = addressDomain.telephone;
                                                    map['firstname'] = addressDomain.firstname;
                                                    map['lastname'] = addressDomain.lastname;
                                                    map['email'] = userPreferences.email;
                                                    map['postcode'] =addressDomain.postalCode;
                                                    estimatedMap['address'] = map;
                                                    estimateMethodBloc.add(EstimateMethodFetched(estimatedMap, userPreferences.userToken!));

                                                  }

                                                },
                                              child: Center(
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

                                                ),
                                          ),
                                        ):Container(),
                                      ),
                                    ),
                                  ),)




                            ],
                          );
                        }


                      }

                    }else{
                      return Container();
                    }

                  },
                );
                       }else{
                return Container();
                       }


                },
                       ),
             ),

           ],
         ),

        ),
      ),
    );
  }
  int selectedIndex =-1;
  bool isAddressSelected(CustomerDomain customer){
    bool isSelected = false;
    for(int i =0;i<customer.addresses.length;i++){
      if(customer.addresses[i].defaultShipping){
        isSelected = true;
        selectedIndex = i;
        break;

      }
    }
    return isSelected;
  }
}

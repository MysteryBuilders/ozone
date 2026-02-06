import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/app_prefrences.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/model/city_model.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/state_model.dart';
import 'package:ozon/presentation/add_address/bloc/add_address_bloc/add_address_bloc.dart';
import 'package:ozon/presentation/add_address/bloc/checkbox_bloc.dart';
import 'package:ozon/presentation/add_address/bloc/checkbox_state.dart';
import 'package:ozon/presentation/add_address/bloc/default_city_bloc/default_city_bloc.dart';
import 'package:ozon/presentation/cities/bloc/cities_bloc.dart';
import 'package:ozon/presentation/country/bloc/country_bloc.dart';
import 'package:ozon/presentation/main/bloc/estimate_method_bloc/estimate_method_bloc.dart';
import 'package:ozon/presentation/main/bloc/shipping_information/shipping_information_bloc.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';

import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../app/user_prefrences.dart';
import '../../addresses/bloc/addresses_bloc.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../bloc/checkbox_event.dart';
import 'custom_checkbox.dart';
class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  final TextEditingController _AddressController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final CheckboxBloc checkboxBloc = instance<CheckboxBloc>();
  final CheckboxBloc checkboxBloc2 = instance<CheckboxBloc>();
  final AddAddressBloc addAddressBloc = instance<AddAddressBloc>();


  final TextEditingController _flatNumberController = TextEditingController();

  final AddressesBloc addressesBloc =  GetIt.I<AddressesBloc>();
  final DefaultCityBloc defaultCityBloc = instance<DefaultCityBloc>();
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  AppPreferences _appPreferences = GetIt.I<AppPreferences>();
  CountryModel? countryModel ;
  StateModel? stateModel;
  CityModel? cityModel;
  int selectedIndex =-1;
  int selectBillingIndex =-1;
  AddressDomain? addressDomain;
  AddressDomain? billingAddressDomain;
  String? carrierCode;
  String? methodCode;
  UserBloc _userBloc = instance<UserBloc>();
  final EstimateMethodBloc estimateMethodBloc = instance<EstimateMethodBloc>();
  ShippingInformationBloc shippingInformationBloc = instance<ShippingInformationBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // init();
    GetIt.I<CitiesBloc>().add(InitCities());


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

          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.w,
            title: AppbarTitle(
              text: AppStrings.addAddress.tr(),
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
            bloc: _userBloc..add(UserInfoFetched(userPreferences.userToken!)),
  builder: (context, userState) {
              if(userState is UserLoading){
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              }else if(userState is UserFailure){
                return Container();

              }else if(userState is UserSuccess) {
                _firstNameController.text = userState.userInfoModel!.firstname!;
                _lastNameController.text = userState.userInfoModel!.lastname!;

                return BlocBuilder<DefaultCityBloc, DefaultCityState>(
                  bloc: defaultCityBloc..add(DefaultCityFetched()),
                  builder: (context, state) {
                    if (state is DefaultCityLoading) {
                      return Container(
                        alignment: AlignmentDirectional.center,
                        child: SizedBox(
                            height: 150.w,
                            width: 150.w,
                            child: Lottie.asset(ImageAssets.loadingView)),

                      );
                    } else if (state is DefaultCitySuccess) {
                      return BlocListener<AddressesBloc, AddressesState>(
                        bloc: addressesBloc,
                        listener: (context, state) {
                          if (state is AddressesLoading) {
                            showLoadingDialog(context);
                          } else if (state is AddressesSuccess) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else if (state is AddressesFailure) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        child: BlocListener<
                            EstimateMethodBloc,
                            EstimateMethodState>(
                          bloc: estimateMethodBloc,
                          listener: (context, estimateMethodState) {
                            if (estimateMethodState is EstimateMethodLoading) {

                            } else
                            if (estimateMethodState is EstimateMethodFailure) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(estimateMethodState.message)),
                              );
                            } else
                            if (estimateMethodState is EstimateMethodSuccess) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Map<String, dynamic> addressInformationMap = {};
                              carrierCode =
                                  estimateMethodState.estimateMethodList[0]
                                      .carrierCode;
                              methodCode =
                                  estimateMethodState.estimateMethodList[0]
                                      .methodCode;
                              addressInformationMap['shipping_method_code'] =
                                  methodCode;
                              addressInformationMap['shipping_carrier_code'] =
                                  carrierCode;
                              Map<String, dynamic> shippingMap = {};
                              shippingMap['region'] =
                                  addressDomain!.region!.region;
                              shippingMap['region_id'] =
                                  addressDomain!.region!.regionId;
                              shippingMap['region_code'] = "";
                              shippingMap['country_id'] =
                                  addressDomain!.countryId;
                              shippingMap['city'] = addressDomain!.city;
                              for (int j = 0; j <
                                  addressDomain!.customAttributes!
                                      .length; j++) {
                                if (addressDomain!.customAttributes![j]
                                    .attributeCode == "flat_number") {
                                  shippingMap["flat_number"] =
                                  [addressDomain!.customAttributes![j].value];
                                  break;
                                }
                              }
                              shippingMap['telephone'] =
                                  addressDomain!.telephone;
                              shippingMap['firstname'] =
                                  addressDomain!.firstname;
                              shippingMap['lastname'] = addressDomain!.lastname;
                              shippingMap['email'] = userPreferences.email;
                              addressInformationMap['shipping_address'] =
                                  shippingMap;

                              if (selectBillingIndex != -1) {
                                Map<String, dynamic> billingMap = {};
                                billingMap['region'] =
                                    addressDomain!.region!.region;
                                billingMap['region_id'] =
                                    addressDomain!.region!.regionId;
                                billingMap['region_code'] = "";
                                billingMap['country_id'] =
                                    addressDomain!.countryId;
                                billingMap['city'] = addressDomain!.city;
                                for (int j = 0; j <
                                    addressDomain!.customAttributes!
                                        .length; j++) {
                                  if (addressDomain!.customAttributes![j]
                                      .attributeCode == "flat_number") {
                                    billingMap["street"] =
                                    [addressDomain!.customAttributes![j].value];
                                    break;
                                  }
                                }
                                billingMap['telephone'] =
                                    addressDomain!.telephone;
                                billingMap['firstname'] =
                                    addressDomain!.firstname;
                                billingMap['lastname'] =
                                    addressDomain!.lastname;
                                billingMap['email'] = userPreferences.email;
                                addressInformationMap['billing_address'] =
                                    billingMap;
                              }
                              Map<String, dynamic> map = {};
                              map['addressInformation'] = addressInformationMap;
                              shippingInformationBloc.add(
                                  ShippingInformationFetched(
                                      userPreferences.userToken!, map));
                            }
                            // TODO: implement listener
                          },
                          child: BlocListener<
                              ShippingInformationBloc,
                              ShippingInformationState>(
                            bloc: shippingInformationBloc,
                            listener: (context, shippingInformationState) {
                              if (shippingInformationState is ShippingInformationLoading) {

                              } else
                              if (shippingInformationState is ShippingInformationFailure) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      shippingInformationState.message)),
                                );
                              } else
                              if (shippingInformationState is ShippingInformationSuccess) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                              // TODO: implement listener
                            },
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      margin: EdgeInsets.all(20.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.firstName.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),
                                            child: TextFormField(


                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction
                                                  .next,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                  color: ColorManager
                                                      .secondaryBlack,
                                                  fontSize: ScreenUtil().setSp(
                                                      12),
                                                  fontWeight: FontWeight.normal


                                              ),
                                              obscureText: false,
                                              controller: _firstNameController,
                                              decoration: InputDecoration(

                                                hintText: AppStrings.firstName
                                                    .tr(),
                                                hintStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: ColorManager
                                                        .secondaryBlack,
                                                    fontSize: ScreenUtil()
                                                        .setSp(12),
                                                    fontWeight: FontWeight
                                                        .normal


                                                ),


                                              ),

                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.lastName.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),
                                            child: TextFormField(


                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction
                                                  .next,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                  color: ColorManager
                                                      .secondaryBlack,
                                                  fontSize: ScreenUtil().setSp(
                                                      12),
                                                  fontWeight: FontWeight.normal


                                              ),
                                              obscureText: false,
                                              controller: _lastNameController,
                                              decoration: InputDecoration(

                                                hintText: AppStrings.lastName
                                                    .tr(),
                                                hintStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: ColorManager
                                                        .secondaryBlack,
                                                    fontSize: ScreenUtil()
                                                        .setSp(12),
                                                    fontWeight: FontWeight
                                                        .normal


                                                ),


                                              ),

                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.phone.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),
                                            child: TextFormField(
                                              textInputAction: TextInputAction
                                                  .done,
                                              keyboardType: TextInputType.phone,

                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                  color: ColorManager
                                                      .secondaryBlack,
                                                  fontSize: ScreenUtil().setSp(
                                                      12),
                                                  fontWeight: FontWeight.normal


                                              ),
                                              decoration: InputDecoration(

                                                hintText: AppStrings.phone.tr(),
                                                hintStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: ColorManager
                                                        .secondaryBlack,
                                                    fontSize: ScreenUtil()
                                                        .setSp(12),
                                                    fontWeight: FontWeight
                                                        .normal


                                                ),


                                              ),
                                              controller: _phoneController,
                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.country.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned.directional(
                                                  textDirection: Directionality
                                                      .of(context),
                                                  top: 0,
                                                  bottom: 0,
                                                  start: 10.w,
                                                  child: Container(
                                                    alignment: AlignmentDirectional
                                                        .centerStart,
                                                    child: Text(
                                                      textAlign: TextAlign
                                                          .start,

                                                      isRtl() ? state
                                                          .mCountryModel
                                                          .fullNameLocale
                                                          .toString() : state
                                                          .mCountryModel
                                                          .fullNameEnglish
                                                          .toString(),
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .displayMedium!
                                                          .copyWith(
                                                          color: ColorManager
                                                              .black900,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          fontWeight: FontWeight
                                                              .w400

                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.governorate.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),
                                            child: Stack(
                                              children: [
                                                Positioned.directional(
                                                  textDirection: Directionality
                                                      .of(context),
                                                  top: 0,
                                                  bottom: 0,
                                                  start: 10.w,
                                                  child: Container(
                                                    alignment: AlignmentDirectional
                                                        .centerStart,
                                                    child: Text(
                                                      textAlign: TextAlign
                                                          .start,

                                                      state.mStateModel.name!,
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .displayMedium!
                                                          .copyWith(
                                                          color: ColorManager
                                                              .black900,
                                                          fontSize: ScreenUtil()
                                                              .setSp(12),
                                                          fontWeight: FontWeight
                                                              .w400

                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.city.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          InkWell(
                                            onTap: () {
                                              Map<String, dynamic> map = {};
                                              map['stateName'] =
                                                  state.mStateModel!.name;
                                              map['title'] =
                                                  AppStrings.city.tr();
                                              Navigator.pushNamed(
                                                  context, Routes.citiesRoute,
                                                  arguments: map);
                                              // Navigator.pushNamed(context, Routes.citiesRoute,arguments: map);


                                            },
                                            child: Container(
                                              width: ScreenUtil().screenWidth,
                                              height: 40.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorManager
                                                          .lightPrimaryBackGround,
                                                      width: 0.5),
                                                  borderRadius: BorderRadius
                                                      .circular(20.w)
                                              ),
                                              child: Stack(
                                                children: [
                                                  Positioned.directional(
                                                    textDirection: Directionality
                                                        .of(context),
                                                    top: 0,
                                                    bottom: 0,
                                                    start: 10.w,
                                                    child: Container(
                                                      alignment: AlignmentDirectional
                                                          .centerStart,
                                                      child: BlocBuilder<
                                                          CitiesBloc,
                                                          CitiesState>(
                                                        bloc: GetIt.I<
                                                            CitiesBloc>(),
                                                        builder: (context,
                                                            cityState) {
                                                          if (cityState is CitiesSuccess) {
                                                            cityModel =
                                                                cityState
                                                                    .selectedCity;
                                                            return Text(
                                                              textAlign: TextAlign
                                                                  .start,

                                                              cityState
                                                                  .selectedCity ==
                                                                  null
                                                                  ? AppStrings
                                                                  .city.tr()
                                                                  : cityState
                                                                  .selectedCity
                                                                  .cityName!,
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .displayMedium!
                                                                  .copyWith(
                                                                  color: ColorManager
                                                                      .black900,
                                                                  fontSize: ScreenUtil()
                                                                      .setSp(
                                                                      12),
                                                                  fontWeight: FontWeight
                                                                      .w400

                                                              ),
                                                            );
                                                          } else {
                                                            return Text(
                                                              textAlign: TextAlign
                                                                  .start,

                                                              AppStrings.city
                                                                  .tr(),
                                                              style: Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .displayMedium!
                                                                  .copyWith(
                                                                  color: ColorManager
                                                                      .black900,
                                                                  fontSize: ScreenUtil()
                                                                      .setSp(
                                                                      12),
                                                                  fontWeight: FontWeight
                                                                      .w400

                                                              ),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned.directional(
                                                    textDirection: Directionality
                                                        .of(context),
                                                    top: 0,
                                                    bottom: 0,
                                                    end: 10.w,
                                                    child: SvgPicture.asset(
                                                      ImageAssets.imgArrowdown,
                                                      color: ColorManager
                                                          .amber900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.postalCode.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),

                                            alignment: Alignment.center,
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction
                                                  .next,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                  color: ColorManager
                                                      .secondaryBlack,
                                                  fontSize: ScreenUtil().setSp(
                                                      12),
                                                  fontWeight: FontWeight.normal


                                              ),
                                              decoration: InputDecoration(

                                                hintText: AppStrings.postalCode
                                                    .tr(),
                                                hintStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: ColorManager
                                                        .secondaryBlack,
                                                    fontSize: ScreenUtil()
                                                        .setSp(12),
                                                    fontWeight: FontWeight
                                                        .normal


                                                ),


                                              ),
                                              controller: _postalCodeController,
                                            ),
                                          ),

                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.buildingNo.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),

                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction
                                                  .next,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                  color: ColorManager
                                                      .secondaryBlack,
                                                  fontSize: ScreenUtil().setSp(
                                                      12),
                                                  fontWeight: FontWeight.normal


                                              ),
                                              decoration: InputDecoration(

                                                hintText: AppStrings.buildingNo
                                                    .tr(),
                                                hintStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: ColorManager
                                                        .secondaryBlack,
                                                    fontSize: ScreenUtil()
                                                        .setSp(12),
                                                    fontWeight: FontWeight
                                                        .normal


                                                ),


                                              ),
                                              controller: _buildingController,
                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.streetNo.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction
                                                  .done,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                  color: ColorManager
                                                      .secondaryBlack,
                                                  fontSize: ScreenUtil().setSp(
                                                      12),
                                                  fontWeight: FontWeight.normal


                                              ),
                                              decoration: InputDecoration(

                                                hintText: AppStrings.streetNo
                                                    .tr(),
                                                hintStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: ColorManager
                                                        .secondaryBlack,
                                                    fontSize: ScreenUtil()
                                                        .setSp(12),
                                                    fontWeight: FontWeight
                                                        .normal


                                                ),


                                              ),
                                              controller: _AddressController,
                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Text(AppStrings.flatNumber.tr(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.mainBlack,
                                                fontWeight: FontWeight.normal,
                                                fontSize: ScreenUtil().setSp(12)
                                            ),),
                                          SizedBox(height: 5.w,),
                                          Container(
                                            width: ScreenUtil().screenWidth,
                                            height: 40.w,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: ColorManager
                                                        .lightPrimaryBackGround,
                                                    width: 0.5),
                                                borderRadius: BorderRadius
                                                    .circular(20.w)
                                            ),
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              textInputAction: TextInputAction
                                                  .done,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                  color: ColorManager
                                                      .secondaryBlack,
                                                  fontSize: ScreenUtil().setSp(
                                                      12),
                                                  fontWeight: FontWeight.normal


                                              ),
                                              decoration: InputDecoration(

                                                hintText: AppStrings.flatNumber
                                                    .tr(),
                                                hintStyle: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: ColorManager
                                                        .secondaryBlack,
                                                    fontSize: ScreenUtil()
                                                        .setSp(12),
                                                    fontWeight: FontWeight
                                                        .normal


                                                ),


                                              ),
                                              controller: _flatNumberController,
                                            ),
                                          ),
                                          SizedBox(height: 20.w,),
                                          Container(
                                            height: 40.w,
                                            child: BlocBuilder<
                                                CheckboxBloc,
                                                CheckboxState>(
                                              bloc: checkboxBloc,
                                              builder: (context, state) {
                                                return CustomCheckbox(
                                                  value: state.isChecked,

                                                  text: AppStrings
                                                      .makeDefAddress.tr(),
                                                  iconSize: 20,
                                                  variant: CheckboxVariant
                                                      .FillAmber900,
                                                  onChange: (val) {
                                                    checkboxBloc.add(
                                                        ToggleCheckboxEvent());
                                                  },


                                                );
                                              },
                                            ),
                                          ),


                                          SizedBox(height: 100.w,),


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
                                      width: ScreenUtil().screenWidth,

                                      height: 100.w,

                                      child: Card(
                                        color: Colors.white,

                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(
                                                20.w), // Top corners radius
                                          ),
                                        ),
                                        elevation: 4,
                                        // Set elevation

                                        surfaceTintColor: Colors.white,
                                        child: BlocListener<
                                            AddAddressBloc,
                                            AddAddressState>(
                                          bloc: addAddressBloc,
                                          listener: (context, state) {
                                            if (state is AddAddressLoading) {
                                              showLoadingDialog(context);
                                            } else
                                            if (state is AddAddressSuccess) {
                                              Navigator.pop(context);
                                              addressesBloc.add(
                                                  AddressesFetched(
                                                      userPreferences
                                                          .userToken!, 0));
                                            } else
                                            if (state is AddAddressFailure) {
                                              Navigator.pop(context);
                                              ScaffoldMessenger
                                                  .of(context)
                                                  .showSnackBar(
                                                SnackBar(content: Text(
                                                    state.message)),
                                              );
                                            }
                                          },
                                          child: InkWell(


                                            onTap: () {
                                              String firstName = _firstNameController
                                                  .text;
                                              String lastName = _lastNameController
                                                  .text;
                                              String phoneNumber = _phoneController
                                                  .text;
                                              String postalCode = _postalCodeController
                                                  .text;
                                              String buildingNo = _buildingController
                                                  .text;
                                              String streetAddress = _AddressController
                                                  .text;
                                              String flatNumber = _flatNumberController
                                                  .text;


                                              if (firstName
                                                  .trim()
                                                  .isEmpty) {
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      AppStrings.firstNameError
                                                          .tr())),
                                                );
                                              } else if (lastName
                                                  .trim()
                                                  .isEmpty) {
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      AppStrings.lastNameError
                                                          .tr())),
                                                );
                                              } else if (phoneNumber
                                                  .trim()
                                                  .isEmpty) {
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      AppStrings
                                                          .mobileNumberInvalid
                                                          .tr())),
                                                );
                                              } else if (postalCode
                                                  .trim()
                                                  .isEmpty) {
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      AppStrings.postalCodeError
                                                          .tr())),
                                                );
                                              } else if (buildingNo
                                                  .trim()
                                                  .isEmpty) {
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      AppStrings.buildingNoError
                                                          .tr())),
                                                );
                                              } else if (streetAddress
                                                  .trim()
                                                  .isEmpty) {
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      AppStrings
                                                          .StreetAdreessError
                                                          .tr())),
                                                );
                                              }
                                              else if (flatNumber
                                                  .trim()
                                                  .isEmpty) {
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      AppStrings.flatNumberError
                                                          .tr())),
                                                );
                                              } else if (cityModel == null) {
                                                ScaffoldMessenger
                                                    .of(context)
                                                    .showSnackBar(
                                                  SnackBar(content: Text(
                                                      AppStrings.cityError
                                                          .tr())),
                                                );
                                              } else {
                                                String email = userState
                                                    .userInfoModel!.email!;
                                                int userId = userState
                                                    .userInfoModel!.id!;
                                                String userFirstName = userState
                                                    .userInfoModel!.firstname!;
                                                String userLastName = userState
                                                    .userInfoModel!.lastname!;
                                                CustomerDomain customerDomain = (addressesBloc
                                                    .state as AddressesSuccess)
                                                    .customerDomain;
                                                Map<String, dynamic> userMap = {
                                                };
                                                userMap['id'] = userId;
                                                userMap['email'] = email;
                                                userMap['firstname'] =
                                                    userFirstName;
                                                userMap['lastname'] =
                                                    userLastName;

                                                List<Map<String,
                                                    dynamic>> addressList = [];
                                                for (int i = 0; i <
                                                    customerDomain.addresses
                                                        .length; i++) {
                                                  AddressDomain addressDomain = customerDomain
                                                      .addresses[i];

                                                  Map<String,
                                                      dynamic> addressMap = {};
                                                  Map<String,
                                                      dynamic> regionMap = {};
                                                  regionMap['region_code'] = "";
                                                  regionMap['region'] =
                                                      addressDomain.region
                                                          .region;
                                                  regionMap['region_id'] =
                                                      addressDomain.region
                                                          .regionId;
                                                  addressMap['region'] =
                                                      regionMap;
                                                  addressMap['firstname'] =
                                                      addressDomain.firstname;
                                                  addressMap['lastname'] =
                                                      addressDomain.lastname;
                                                  addressMap['country_id'] =
                                                      addressDomain.countryId;
                                                  addressMap['postcode'] =
                                                      addressDomain.postalCode;
                                                  List<String> streets = [];
                                                  streets.add(
                                                      addressDomain.street[0]);
                                                  addressMap['street'] =
                                                      streets;
                                                  addressMap['telephone'] =
                                                      addressDomain.telephone;
                                                  addressMap['city'] =
                                                      addressDomain.city;
                                                  if (checkboxBloc.state
                                                      .isChecked) {
                                                    addressMap['default_shipping'] =
                                                    false;
                                                  } else {
                                                    addressMap['default_shipping'] =
                                                        addressDomain
                                                            .defaultShipping;
                                                  }
                                                  if (checkboxBloc.state
                                                      .isChecked) {
                                                    addressMap['default_billing'] =
                                                    false;
                                                  } else {
                                                    addressMap['default_billing'] =
                                                        addressDomain
                                                            .defaultBilling;
                                                  }
                                                  List<Map<String,
                                                      dynamic>> customAttributes = [
                                                  ];
                                                  Map<String,
                                                      dynamic> customAttribute = {
                                                  };
                                                  customAttribute["attribute_code"] =
                                                  "building_nubmber";
                                                  for (int j = 0; j <
                                                      addressDomain
                                                          .customAttributes
                                                          .length; j++) {
                                                    if (addressDomain
                                                        .customAttributes[j]
                                                        .attributeCode ==
                                                        "building_nubmber") {
                                                      customAttribute["value"] =
                                                          addressDomain
                                                              .customAttributes[j]
                                                              .value;
                                                      break;
                                                    }
                                                  }
                                                  customAttributes.add(
                                                      customAttribute);
                                                  Map<String,
                                                      dynamic> customAttributeFlat = {
                                                  };
                                                  customAttributeFlat["attribute_code"] =
                                                  "flat_number";
                                                  String flatValue = "";
                                                  for (int j = 0; j <
                                                      addressDomain
                                                          .customAttributes
                                                          .length; j++) {
                                                    if (addressDomain
                                                        .customAttributes[j]
                                                        .attributeCode ==
                                                        "flat_number") {
                                                      flatValue = addressDomain
                                                          .customAttributes[j]
                                                          .value;
                                                      // customAttributeFlat["value"]=addressDomain.customAttributes[j].value;
                                                      break;
                                                    }
                                                  }
                                                  customAttributeFlat["value"] =
                                                      flatValue;
                                                  customAttributes.add(
                                                      customAttributeFlat);
                                                  Map<String,
                                                      dynamic> customAttributeCivilId = {
                                                  };
                                                  customAttributeCivilId["attribute_code"] =
                                                  "civil_id";
                                                  customAttributeCivilId["value"] =
                                                  "0000000000";
                                                  customAttributes.add(
                                                      customAttributeCivilId);
                                                  addressMap["custom_attributes"] =
                                                      customAttributes;
                                                  addressList.add(addressMap);
                                                }

                                                Map<String,
                                                    dynamic> addressMap = {};
                                                Map<String,
                                                    dynamic> regionMap = {};
                                                regionMap['region_code'] = state
                                                    .mStateModel!.stateId;
                                                regionMap['region'] = cityModel!
                                                    .cityName!;
                                                regionMap['region_id'] =
                                                    cityModel!.entityId;
                                                addressMap['region'] =
                                                    regionMap;
                                                addressMap['firstname'] =
                                                    _firstNameController.text;
                                                addressMap['lastname'] =
                                                    _lastNameController.text;
                                                addressMap['country_id'] = state
                                                    .mCountryModel.id;
                                                addressMap['postcode'] =
                                                    postalCode;
                                                List<String> streets = [];
                                                streets.add(_AddressController
                                                    .text);
                                                addressMap['street'] = streets;
                                                addressMap['telephone'] =
                                                    _phoneController.text;
                                                addressMap['city'] = state
                                                    .mStateModel!.name;

                                                addressMap['default_shipping'] =
                                                    checkboxBloc.state
                                                        .isChecked;


                                                addressMap['default_billing'] =
                                                    checkboxBloc.state
                                                        .isChecked;
                                                List<Map<String,
                                                    dynamic>> customAttributes = [
                                                ];
                                                Map<String,
                                                    dynamic> customAttribute = {
                                                };
                                                customAttribute['attribute_code'] =
                                                'building_nubmber';
                                                customAttribute['value'] =
                                                    buildingNo;
                                                customAttributes.add(
                                                    customAttribute);
                                                Map<String,
                                                    dynamic> customAttributeFlat = {
                                                };
                                                customAttributeFlat['attribute_code'] =
                                                'flat_number';
                                                customAttributeFlat['value'] =
                                                    flatNumber;
                                                customAttributes.add(
                                                    customAttributeFlat);
                                                Map<String,
                                                    dynamic> customAttributeCivil = {
                                                };
                                                customAttributeCivil['attribute_code'] =
                                                'civil_id';
                                                customAttributeCivil['value'] =
                                                '0000000000';
                                                customAttributes.add(
                                                    customAttributeCivil);
                                                addressMap["custom_attributes"] =
                                                    customAttributes;

                                                addressList.add(addressMap);
                                                userMap['addresses'] =
                                                    addressList;
                                                Map<String, dynamic> map = {};
                                                map['customer'] = userMap;
                                                print('map ---> ${userMap}');

                                                addAddressBloc.add(
                                                    AddAddressFetched(map,
                                                        userPreferences
                                                            .userToken!, 0));
                                              }
                                            },
                                            child: Container(
                                              alignment: AlignmentDirectional
                                                  .center,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 30.w),
                                              child: Container(
                                                height: 40.w,
                                                alignment: AlignmentDirectional
                                                    .center,
                                                width: ScreenUtil().screenWidth,
                                                decoration: BoxDecoration(
                                                    color: ColorManager.primary,
                                                    borderRadius: BorderRadius
                                                        .circular(20.w)

                                                ),

                                                child: Text(
                                                  AppStrings.save.tr(),
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                      color: ColorManager.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(14),
                                                      fontWeight: FontWeight
                                                          .normal
                                                  ),),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
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
      ),
    );
  }
}

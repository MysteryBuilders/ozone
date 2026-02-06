import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../../domain/model/adresses_model.dart';
import '../../../domain/model/city_model.dart';
import '../../../domain/model/country_model.dart';
import '../../../domain/model/state_model.dart';
import '../../add_address/bloc/add_address_bloc/add_address_bloc.dart';
import '../../add_address/bloc/checkbox_bloc.dart';
import '../../add_address/bloc/checkbox_event.dart';
import '../../add_address/bloc/checkbox_state.dart';
import '../../add_address/bloc/default_city_bloc/default_city_bloc.dart';
import '../../add_address/view/custom_checkbox.dart';
import '../../addresses/bloc/addresses_bloc.dart';
import '../../cities/bloc/cities_bloc.dart';
import '../../country/bloc/country_bloc.dart';
import '../../main/bloc/estimate_method_bloc/estimate_method_bloc.dart';
import '../../main/bloc/shipping_information/shipping_information_bloc.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../states/bloc/states_bloc.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
class AddressDetailsView extends StatefulWidget {
  final AddressDomain addressDomain;
  const AddressDetailsView({super.key,required this.addressDomain});

  @override
  State<AddressDetailsView> createState() => _AddressDetailsViewState();
}

class _AddressDetailsViewState extends State<AddressDetailsView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  final TextEditingController _AddressController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final DefaultCityBloc defaultCityBloc = instance<DefaultCityBloc>();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _flatNumberController = TextEditingController();
  final CountryBloc countryBloc =  GetIt.I<CountryBloc>();
  final CheckboxBloc checkboxBloc = instance<CheckboxBloc>();
  final CheckboxBloc checkboxBloc2 = instance<CheckboxBloc>();
  final AddAddressBloc addAddressBloc = instance<AddAddressBloc>();
  final StatesBloc statesBloc =  GetIt.I<StatesBloc>();
  final UserBloc userBloc =  GetIt.I<UserBloc>();
  final CitiesBloc citiesBloc = GetIt.I<CitiesBloc>();
  final AddressesBloc addressesBloc =  GetIt.I<AddressesBloc>();
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();

  CountryModel? countryModel ;
  StateModel? stateModel;
  CityModel? cityModel;
  String cityName="";
  String stateName ="";
  String countryId = "";
  int selectedIndex =-1;
  int selectBillingIndex =-1;
  AddressDomain? addressDomain;
  AddressDomain? billingAddressDomain;
  String? carrierCode;
  String? methodCode;
  final EstimateMethodBloc estimateMethodBloc = instance<EstimateMethodBloc>();
  ShippingInformationBloc shippingInformationBloc = instance<ShippingInformationBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    citiesBloc..add(InitCities());
    _firstNameController.text = widget.addressDomain.firstname;
    _lastNameController.text = widget.addressDomain.lastname;
    _phoneController.text =widget.addressDomain.telephone;
    cityName = widget.addressDomain.city;
    stateName = widget.addressDomain.region.region;
    _AddressController.text = widget.addressDomain.street[0];
    countryId = widget.addressDomain.countryId;

    _postalCodeController.text = widget.addressDomain.postalCode;
    bool isDefaultAddress= widget.addressDomain.defaultShipping;
    checkboxBloc.add(InitCheckboxEvent(isDefaultAddress));
    bool isDefaultBilling= widget.addressDomain.defaultBilling;
    checkboxBloc2.add(InitCheckboxEvent(isDefaultBilling));
    String buildingNo ="";
    String flatNo="";
    for(int i =0;i<widget.addressDomain.customAttributes.length;i++){
      String attributeCode = widget.addressDomain.customAttributes[i].attributeCode;
      if(attributeCode == "building_nubmber"){
        buildingNo = widget.addressDomain.customAttributes[i].value;
        break;
      }
    }
    for(int i =0;i<widget.addressDomain.customAttributes.length;i++){
      String attributeCode = widget.addressDomain.customAttributes[i].attributeCode;
      if(attributeCode == "flat_number"){
        flatNo = widget.addressDomain.customAttributes[i].value;
        break;
      }
    }
    _flatNumberController.text = flatNo;
    _buildingController.text = buildingNo;


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
          backgroundColor: ColorManager.gray100,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.w,
            title: AppbarTitle(
              text: AppStrings.editAddress.tr(),
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

          body: Container(
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
        }
        else if(defaultCityState is DefaultCitySuccess){
          return BlocListener<AddressesBloc, AddressesState>(
            bloc: addressesBloc,
            listener: (context, state) {
              if(state is AddressesLoading){
                showLoadingDialog(context);
              }else if(state is AddressesSuccess){
               Navigator.pop(context);
               Navigator.pop(context);
              }else if(state is AddressesFailure){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: BlocListener<EstimateMethodBloc, EstimateMethodState>(
              bloc: estimateMethodBloc,
              listener: (context, estimateMethodState) {
                if(estimateMethodState is EstimateMethodLoading){

                }else if(estimateMethodState is EstimateMethodFailure){
                 Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(estimateMethodState.message)),
                  );
                } else if(estimateMethodState is EstimateMethodSuccess){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Map<String,dynamic> addressInformationMap ={};
                  carrierCode = estimateMethodState.estimateMethodList[0].carrierCode;
                  methodCode  =estimateMethodState.estimateMethodList[0].methodCode;
                  addressInformationMap['shipping_method_code']= methodCode;
                  addressInformationMap['shipping_carrier_code']= carrierCode;
                  Map<String,dynamic> shippingMap ={};
                  shippingMap['region'] =addressDomain!.region!.region;
                  shippingMap['region_id'] = addressDomain!.region!.regionId;
                  shippingMap['region_code'] ="";
                  shippingMap['country_id'] = addressDomain!.countryId;
                  shippingMap['city'] = addressDomain!.city;
                  for(int j=0;j<addressDomain!.customAttributes!.length;j++){
                    if(addressDomain!.customAttributes![j].attributeCode=="street"){
                      shippingMap["street"]=[addressDomain!.customAttributes![j].value];
                      break;
                    }

                  }
                  shippingMap['telephone'] = addressDomain!.telephone;
                  shippingMap['firstname'] = addressDomain!.firstname;
                  shippingMap['lastname'] = addressDomain!.lastname;
                  shippingMap['email'] = userPreferences.email;
                  addressInformationMap['shipping_address']=shippingMap;

                  if(selectBillingIndex != -1){
                    Map<String,dynamic> billingMap ={};
                    billingMap['region'] =addressDomain!.region!.region;
                    billingMap['region_id'] = addressDomain!.region!.regionId;
                    billingMap['region_code'] ="";
                    billingMap['country_id'] = addressDomain!.countryId;
                    billingMap['city'] = addressDomain!.city;
                    for(int j=0;j<addressDomain!.customAttributes!.length;j++){
                      if(addressDomain!.customAttributes![j].attributeCode=="flat_number"){
                        billingMap["street"]=[addressDomain!.customAttributes![j].value];
                        break;
                      }

                    }
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
                // TODO: implement listener
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.w,),
                                Text(AppStrings.firstName.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                  child: TextFormField(


                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal


                                    ),
                                    obscureText: false,
                                    controller: _firstNameController,
                                    decoration: InputDecoration(

                                      hintText: AppStrings.firstName.tr(),
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: ColorManager.secondaryBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal


                                      ),



                                    ),

                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Text(AppStrings.lastName.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                  child: TextFormField(


                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal


                                    ),
                                    obscureText: false,
                                    controller: _lastNameController,
                                    decoration: InputDecoration(

                                      hintText: AppStrings.lastName.tr(),
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: ColorManager.secondaryBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal


                                      ),



                                    ),

                                  ),
                                ),

                                SizedBox(height: 20.w,),
                                Text(AppStrings.phone.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.phone,

                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal


                                    ),
                                    decoration: InputDecoration(

                                      hintText: AppStrings.emailHint.tr(),
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: ColorManager.secondaryBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal


                                      ),



                                    ),
                                    controller: _phoneController,
                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Text(AppStrings.country.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.directional(
                                        textDirection: Directionality.of(context),
                                        top: 0,
                                        bottom: 0,
                                        start: 10.w,
                                        child: Container(
                                          alignment: AlignmentDirectional.centerStart,
                                          child: Text(
                                            textAlign: TextAlign.start,

                                            countryModel == null
                                                ? countryId
                                                : isRtl() ? countryModel!.fullNameLocale
                                                .toString() : countryModel!.fullNameEnglish
                                                .toString(),
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                color: ColorManager.black900,
                                                fontSize: ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w400

                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Text(AppStrings.governorate.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned.directional(
                                        textDirection: Directionality.of(context),
                                        top: 0,
                                        bottom: 0,
                                        start: 10.w,
                                        child: Container(
                                          alignment: AlignmentDirectional.centerStart,
                                          child: BlocListener<StatesBloc, StatesState>(
                                            bloc: statesBloc,
                                            listener: (context, state) {
                                              // if (state is StatesSelected) {
                                              //   stateModel = state.selectedState;
                                              //   cityName = "";
                                              //   cityModel = null;
                                              //   setState(() {
                                              //
                                              //   });
                                              // }
                                            },
                                            child: Text(
                                              textAlign: TextAlign.start,

                                              stateModel == null
                                                  ? stateName.isEmpty?AppStrings.selectGovernorate.tr():stateName
                                                  : stateModel!.name!,
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                  color: ColorManager.black900,
                                                  fontSize: ScreenUtil().setSp(12),
                                                  fontWeight: FontWeight.w400

                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Text(AppStrings.city.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: ColorManager.mainBlack,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ScreenUtil().setSp(12)
                                  ),),
                                SizedBox(height: 5.w,),
                                InkWell(
                                  onTap: () {


                                      Map<String, dynamic> map = {};

                                      map['stateName'] = stateName;
                                      map['title']= AppStrings.city.tr();
                                      Navigator.pushNamed(context,Routes.citiesRoute,arguments: map);
                                      // Navigator.pushNamed(
                                      //     context, Routes.citiesRoute, arguments: map);

                                  },
                                  child: Container(
                                    width: ScreenUtil().screenWidth,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(20.w)
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned.directional(
                                          textDirection: Directionality.of(context),
                                          top: 0,
                                          bottom: 0,
                                          start: 10.w,
                                          child: Container(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: BlocBuilder<CitiesBloc, CitiesState>(
                                              bloc: citiesBloc,
                                              builder: (context, cityState) {
                                                if(cityState is CitiesSuccess){
                                                  if(cityState.selectedCity!= null){
                                                    cityName = cityState.selectedCity.cityName!;

                                                    return Text(
                                                      textAlign: TextAlign.start,

                                                      cityState.selectedCity.cityName!,
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .displayMedium!
                                                          .copyWith(
                                                          color: ColorManager.black900,
                                                          fontSize: ScreenUtil().setSp(12),
                                                          fontWeight: FontWeight.w400

                                                      ),
                                                    );
                                                  }else{
                                                    return Text(
                                                      textAlign: TextAlign.start,

                                                      cityName,
                                                      style: Theme
                                                          .of(context)
                                                          .textTheme
                                                          .displayMedium!
                                                          .copyWith(
                                                          color: ColorManager.black900,
                                                          fontSize: ScreenUtil().setSp(12),
                                                          fontWeight: FontWeight.w400

                                                      ),
                                                    );
                                                  }

                                                }else{
                                                  return Text(
                                                    textAlign: TextAlign.start,

                                                    cityName,
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(
                                                        color: ColorManager.black900,
                                                        fontSize: ScreenUtil().setSp(12),
                                                        fontWeight: FontWeight.w400

                                                    ),
                                                  );
                                                }

                                              },
                                            ),
                                          ),
                                        ),
                                        Positioned.directional(
                                          textDirection: Directionality.of(context),
                                          top: 0,
                                          bottom: 0,
                                          end: 10.w,
                                          child: SvgPicture.asset(
                                            ImageAssets.imgArrowdown,
                                            color: ColorManager.amber900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Text(AppStrings.postalCode.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),

                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal


                                    ),
                                    decoration: InputDecoration(

                                      hintText: AppStrings.postalCode.tr(),
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: ColorManager.secondaryBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal


                                      ),



                                    ),
                                    controller: _postalCodeController,
                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Text(AppStrings.buildingNo.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),

                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal


                                    ),
                                    decoration: InputDecoration(

                                      hintText: AppStrings.buildingNo.tr(),
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: ColorManager.secondaryBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal


                                      ),



                                    ),
                                    controller: _buildingController,
                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Text(AppStrings.streetNo.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal


                                    ),
                                    decoration: InputDecoration(

                                      hintText: AppStrings.streetNo.tr(),
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: ColorManager.secondaryBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal


                                      ),



                                    ),
                                    controller: _AddressController,
                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Text(AppStrings.flatNumber.tr(),
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                      border: Border.all(color: ColorManager.lightPrimaryBackGround,
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(20.w)
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal


                                    ),
                                    decoration: InputDecoration(

                                      hintText: AppStrings.emailHint.tr(),
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: ColorManager.secondaryBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal


                                      ),



                                    ),
                                    controller: _flatNumberController,
                                  ),
                                ),
                                SizedBox(height: 20.w,),
                                Container(
                                  height: 40.w,

                                  child: BlocBuilder<CheckboxBloc, CheckboxState>(
                                    bloc: checkboxBloc,
                                    builder: (context, state) {
                                      return CustomCheckbox(
                                        value: state.isChecked,

                                        text: AppStrings.makeDefAddress.tr(),
                                        iconSize: 20,
                                        variant: CheckboxVariant.FillAmber900,
                                        onChange: (val) {
                                          checkboxBloc.add(ToggleCheckboxEvent());
                                        },


                                      );
                                    },
                                  ),
                                ),



                                SizedBox(height: 100.w,),

                              ],
                            )
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
                            child:  BlocListener<AddAddressBloc, AddAddressState>(
                              bloc: addAddressBloc,
                              listener: (context, state) {
                                if(state is AddAddressLoading){
                                  showLoadingDialog(context);
                                }else if(state is AddAddressSuccess){
                                  dismissLoadingDialog();
                                  addressesBloc.add(AddressesFetched(userPreferences.userToken!,0));

                                }else if(state is AddAddressFailure){
                                  dismissLoadingDialog();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                }
                              },
                              child: InkWell(


                                  onTap: (){
                                    String firstName= _firstNameController.text;
                                    String lastName = _lastNameController.text;
                                    String phoneNumber=  _phoneController.text;
                                    String postalCode = _postalCodeController.text;
                                    String buildingNo = _buildingController.text;
                                    String streetAddress = _AddressController.text;
                                    String flatNo = _flatNumberController.text;



                                    if(firstName.trim().isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.firstNameError.tr())),
                                      );
                                    }else  if(lastName.trim().isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.lastNameError.tr())),
                                      );
                                    } else if(phoneNumber.trim().isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.mobileNumberInvalid.tr())),
                                      );
                                    }else if(postalCode.trim().isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.postalCodeError.tr())),
                                      );
                                    }else if(buildingNo.trim().isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.buildingNoError.tr())),
                                      );
                                    }else if(streetAddress.trim().isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.StreetAdreessError.tr())),
                                      );
                                    }else if(flatNo.trim().isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.flatNumberError.tr())),
                                      );
                                    }

                                    else if(countryId.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.countryError.tr())),
                                      );
                                    }else if(stateName.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.governorateError.tr())),
                                      );
                                    }else if( cityName.isEmpty){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(AppStrings.cityError.tr())),
                                      );
                                    }else{
                                      String email =(userBloc.state as UserSuccess).userInfoModel!.email!;
                                      int userId = (userBloc.state as UserSuccess).userInfoModel!.id!;
                                      String userFirstName = (userBloc.state as UserSuccess).userInfoModel!.firstname!;
                                      String userLastName = (userBloc.state as UserSuccess).userInfoModel!.lastname!;
                                      CustomerDomain customerDomain =(addressesBloc.state as AddressesSuccess).customerDomain;
                                      Map<String,dynamic> userMap = {};
                                      userMap['id'] = userId;
                                      userMap['email'] = email;
                                      userMap['firstname'] = userFirstName;
                                      userMap['lastname'] = userLastName;

                                      List<Map<String,dynamic> >  addressList= [];
                                      for(int i =0;i<customerDomain.addresses.length;i++){
                                        if(customerDomain.addresses[i].id == widget.addressDomain.id){
                                          Map<String,dynamic> addressMap = {};
                                          Map<String,dynamic> regionMap ={};
                                          regionMap['region_code']=stateModel!.stateId;
                                          regionMap['region']=cityName;
                                          regionMap['region_id']=citiesBloc.selectedCityModel!.entityId;
                                          addressMap['region'] = regionMap;
                                          addressMap['firstname'] = _firstNameController.text;
                                          addressMap['postcode'] = _postalCodeController.text;
                                          addressMap['lastname'] = _lastNameController.text;
                                          addressMap['country_id'] =  countryId.isEmpty? countryModel!.id:countryId;
                                          List<String> streets = [];
                                          streets.add(_AddressController.text);
                                          addressMap['street'] = streets;
                                          addressMap['telephone'] = _phoneController.text;
                                          addressMap['city'] = stateName;

                                          addressMap['default_shipping'] = checkboxBloc.state.isChecked;


                                          addressMap['default_billing'] = checkboxBloc2.state.isChecked;
                                          List<Map<String,dynamic>> customAttributes =[];
                                          Map<String,dynamic> customAttribute = {};
                                          customAttribute['attribute_code'] ='building_nubmber';
                                          customAttribute['value'] =buildingNo;
                                          customAttributes.add(customAttribute);
                                          Map<String,dynamic> customAttributeFlat = {};
                                          customAttributeFlat['attribute_code'] ='flat_number';
                                          customAttributeFlat['value'] =flatNo;
                                          customAttributes.add(customAttributeFlat);
                                          Map<String,dynamic> customAttributeCivil = {};
                                          customAttributeCivil['attribute_code'] ='civil_id';
                                          customAttributeCivil['value'] ='0000000000';
                                          customAttributes.add(customAttributeCivil);
                                          addressMap["custom_attributes"]= customAttributes;

                                          addressList.add(addressMap);

                                          print('map ---> ${userMap}');
                                        }
                                        else{
                                          AddressDomain addressDomain = customerDomain.addresses[i];

                                          Map<String,dynamic> addressMap = {};
                                          Map<String,dynamic> regionMap ={};
                                          regionMap['region_code']="";
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
                                          if(checkboxBloc.state.isChecked){
                                            addressMap['default_shipping'] = false;
                                          }else {
                                            addressMap['default_shipping'] =
                                                addressDomain.defaultShipping;
                                          }
                                          if(checkboxBloc2.state.isChecked){
                                            addressMap['default_billing'] = false;
                                          }else{
                                            addressMap['default_billing'] = addressDomain.defaultBilling;

                                          }

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

                                      addAddressBloc.add(AddAddressFetched(map,userPreferences.userToken!,0));



                                    }



                                  },
                               child:  Container(
                                  alignment: AlignmentDirectional.center,
                                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                                  child: Container(
                                    height: 40.w,
                                    alignment: AlignmentDirectional.center,
                                    width: ScreenUtil().screenWidth,
                                    decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        borderRadius: BorderRadius.circular(20.w)

                                    ),

                                    child: Text(AppStrings.save.tr(),
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
              ),
            ),
          );
        }else{
          return Container();
        }

          },
        )

          ),
        ),
      ),
    );
  }
}

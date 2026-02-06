
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/location/bloc/location_bloc/current_location_bloc.dart';
import 'package:ozon/presentation/location/bloc/location_bloc/current_location_event.dart';
import 'package:ozon/presentation/location/bloc/location_bloc/current_location_state.dart';
import 'package:ozon/presentation/location/bloc/save_location_bloc/save_location_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/create_cart_bloc/create_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/offers_bloc/load_more_state.dart';
import 'package:ozon/presentation/resources/color_manager.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/constants.dart';
import '../../../app/user_prefrences.dart';
import '../../../domain/model/country_model.dart';
import '../../../domain/model/order_model.dart';
import '../../../domain/model/state_model.dart';
import '../../country/bloc/country_bloc.dart';
import '../../country/bloc/country_result_bloc/country_result_bloc.dart';
import '../../country/bloc/country_result_bloc/country_result_event.dart';
import '../../country/bloc/country_result_bloc/country_result_state.dart';
// import '../../main/bloc/cart_bloc/cart_bloc.dart';
import '../../main/bloc/delete_item_cart/delete_item_cart_bloc.dart';
import '../../main/bloc/store_locator_bloc/store_locator_bloc.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../states/bloc/states_bloc.dart';
import '../../states/bloc/states_result_bloc/states_reult_bloc.dart';
import '../../widgets/loading_view.dart';

class LocationView extends StatefulWidget {
  final String type;
  final String id ;
  const LocationView({super.key,required this.type,required this.id});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final CurrentLocationBloc _currentLocationBloc = instance<CurrentLocationBloc>();
  final CountryResultBloc countryResultBloc = instance<CountryResultBloc>();
  final DeleteItemCartBloc mDeleteItemCartBloc = instance<DeleteItemCartBloc>();
  final CartBloc cartBloc = instance<CartBloc>();
  final StatesReultBloc statesReultBloc = instance<StatesReultBloc>();
  final StoreLocatorBloc storeLocatorBloc = instance<StoreLocatorBloc>();
  final StoreLocatorBloc mStoreLocatorBloc = instance<StoreLocatorBloc>();
  final UserBloc userBloc = instance<UserBloc>();
  final UserBloc _userBloc = instance<UserBloc>();
  final  SaveLocationBloc saveLocationBloc = instance<SaveLocationBloc>();
  final SaveLocationBloc _saveLocationBloc = instance<SaveLocationBloc>();
  final UserPreferences userPreferences = instance<UserPreferences>();
  final AppPreferences appPreferences = instance<AppPreferences>();
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  CountryModel? mCountryModel;
  StateModel? mStateModel;
  CountryBloc countryBloc =instance<CountryBloc>();
  StatesBloc statesBloc =instance<StatesBloc>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }
  void init()async {
    await Future.delayed(Duration.zero);
    mCountryModel = await GetIt.I<AppPreferences>().getCountry();

    mStateModel = await GetIt.I<AppPreferences>().getState();
    if(mCountryModel != null && mStateModel != null){
      countryResultBloc.add(SelectCountryResultFetch(mCountryModel!));
      statesReultBloc.add(SelectStatesReultFetch(mStateModel!));
      countryBloc.add(SelectCountry(mCountryModel!));
      statesBloc.add(SelectStates(mStateModel!));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        alignment: AlignmentDirectional.center,
        margin: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 118.w,
              height: 118.w,
              decoration: BoxDecoration(
                color: ColorManager.grey,
                shape: BoxShape.circle
              ),
              alignment: AlignmentDirectional.center,
              child: Icon(Icons.location_on_rounded,
              color: ColorManager.primary
                ,size: 56.w,),

            ),
            SizedBox(height: 30.w,),
            Text(AppStrings.whatsYourLocation.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: ColorManager.mainBlack,
              fontSize: ScreenUtil().setSp(24),
              fontWeight: FontWeight.w700

              
            ),),
            SizedBox(height: 20.w,),
            Text(AppStrings.locationDescription.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: ColorManager.secondaryBlack,
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.normal


              ),),
            SizedBox(height: 30.w,),
//             InkWell(
//               onTap: (){
//                 _currentLocationBloc.add(FetchLocation());
//
//               },
//               child: BlocListener<CurrentLocationBloc, CurrentLocationState>(
//                 bloc: _currentLocationBloc,
//   listener: (context, state) {
//     if(state is CurrentLocationLoading){
//       showLoadingDialog(context);
//     }else if(state is CurrentLocationFailure){
//       Navigator.pop(context);
//     }else if(state is CurrentLocationSuccess){
//       Navigator.pop(context);
//
//     }
//   },
//   child: Container(
//                 width: ScreenUtil().screenWidth,
//                 height: 48.w,
//                 decoration: BoxDecoration(
//                   color: ColorManager.primary,
//                   borderRadius: BorderRadius.circular(24.w)
//                 ),
//                 alignment: AlignmentDirectional.center,
//
//                 child: Text(AppStrings.allowAccessLocation.tr(),style:
//                   Theme.of(context).textTheme.displayMedium!.copyWith(
//                     color: ColorManager.white,
//                     fontSize: ScreenUtil().setSp(16),
//                     fontWeight: FontWeight.w500
//
//                   ),),
//               ),
// ),
//             ),
//             SizedBox(height: 10.w,),
            InkWell(
              onTap: (){
                _showLocationDialogBottomSheet(context,isRtl());
              },
              child: Container(
                width: ScreenUtil().screenWidth,
                height: 48.w,

                alignment: AlignmentDirectional.center,

                child: Text(AppStrings.enterLocationManually.tr(),style:
                Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: ColorManager.primary,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500

                ),),
              ),
            ),

          ],

        ),
      ),

    );
  }
  void _showLocationDialogBottomSheet(BuildContext mContext,bool isRtl){

    showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        context: mContext,

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
              Container(height: 50.w,
                width: ScreenUtil().screenWidth,


                child: Stack(
                  children: [
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close,color: ColorManager.primary,size: 30.w,))
                      ,
                      top: 0,
                      bottom: 0,
                      end: 10.w,),
                    Positioned.fill(

                      child: Center(
                        child: Text(AppStrings.selectAddress.tr(),
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: ColorManager.mainBlack,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w500,

                          ),),
                      ),
                    ),

                  ],
                ),),
              Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),

              Container(
                margin: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.selectCountry.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: ColorManager.mainBlack,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal,

                    ),),
                    SizedBox(height: 10.w,),
                    InkWell(
                      onTap: ()async{
                        var result = await     Navigator.pushNamed(mContext, Routes.countryRoute);
                        if(result!= null){
                          CountryModel countryResultModel = result as CountryModel;

                          // GetIt.I<CitiesBloc>().add(InitCities());

                          countryResultBloc.add(SelectCountryResultFetch(countryResultModel ));
                          StateModel ?mstateModel ;
                          statesReultBloc.add(ResetStatesReultFetch( ));
                          // mCityModel = null;
                        }



                      },
                      child: Container(
                        height: 50.w,
                        width: ScreenUtil().screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorManager.gray300,
                                width: 1.w)
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 3.w,horizontal: 10.w),
                          child: Stack(
                            children: [
                              Positioned.fill(child:
                              BlocBuilder<CountryResultBloc, CountryResultState>(
                                bloc: countryResultBloc,
                                builder: (context, state) {
                                  print(state);
                                  if(state is CountryResultStateSuccess){

                                    // mStateModel = null;
                                    // mCityModel = null;


                                    return Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 30.w,
                                            alignment: AlignmentDirectional.center,
                                            child: SvgPicture.network(
                                              state.countryModel.extensionAttributes!.image!,
                                              width: 30.w,
                                              height: 30.w,





                                              placeholderBuilder: (context) =>
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    child: LinearProgressIndicator(
                                                      color: Colors.grey.shade200,
                                                      backgroundColor: Colors.grey.shade100,
                                                    ),
                                                  ),




                                            ),
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(
                                            flex: 1,
                                            child: Text(isRtl?state.countryModel.fullNameLocale!:state.countryModel.fullNameEnglish!,
                                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                  color: ColorManager.secondaryBlack,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: ScreenUtil().setSp(14)
                                              ),),
                                          ),
                                        ],
                                      ),
                                    );
                                  }else{
                                    return Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(AppStrings.selectCountry.tr(),
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontWeight: FontWeight.normal,
                                            fontSize: ScreenUtil().setSp(14)
                                        ),),
                                    );
                                  }

                                },
                              )),
                              Positioned.directional(textDirection: Directionality.of(context),
                                  top: 0,
                                  bottom: 0,
                                  end: 0,
                                  child: Icon(Icons.keyboard_arrow_down_outlined,
                                    color: ColorManager.primary,
                                    size: 25.w,))

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.w,),
                    Text(AppStrings.selectArea.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: ColorManager.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal,

                    ),),
                    SizedBox(height: 10.w,),
                    InkWell(
                      onTap: ()async{

                        if(countryResultBloc.state is CountryResultStateSuccess){
                          //   Map<String,dynamic> map ={};
                          //   map['stateName'] =(GetIt.I<CountryBloc>().state as CountrySelected).selectedCountry.;
                          // map['title']= AppStrings.city.tr();
                          // Routes.navigateTo(Routes.citiesRoute,arguments: map);
                          Map<String,dynamic> map ={};
                          map['countryCode'] =(countryResultBloc.state as CountryResultStateSuccess).countryModel.id;

                          // Navigator.pushNamed(context, Routes.statesRoute,arguments: map);
                          // statesBloc.add(StatesEvent)
                          map['title']= AppStrings.governorate.tr();

                          var result =        await Navigator.pushNamed(mContext, Routes.statesRoute,arguments: map);
                          if(result!= null){
                            StateModel resultStateModel = result as StateModel;
                            statesReultBloc.add(SelectStatesReultFetch(resultStateModel));
                            // GetIt.I<CitiesBloc>().add(InitCities());
                            //
                            // mCityModel = null;
                          }

                        }
                      },
                      child: Container(
                        height: 50.w,
                        width: ScreenUtil().screenWidth,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorManager.gray300,
                                width: 1.w)
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 3.w,horizontal: 10.w),
                          child: Stack(
                            children: [
                              Positioned.fill(child:
                              BlocBuilder<StatesReultBloc, StatesReultState>(
                                bloc: statesReultBloc,
                                builder: (context, state) {
                                  if(state is StatesResultStateSuccess){




                                    return Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(state.stateModel.name!,
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontWeight: FontWeight.normal,
                                            fontSize: ScreenUtil().setSp(14)
                                        ),),
                                    );
                                  }else{
                                    return Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(AppStrings.selectArea.tr(),
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontWeight: FontWeight.normal,
                                            fontSize: ScreenUtil().setSp(14)
                                        ),),
                                    );
                                  }

                                },
                              )),
                              Positioned.directional(textDirection: Directionality.of(context),
                                  top: 0,
                                  bottom: 0,
                                  end: 0,
                                  child: Icon(Icons.keyboard_arrow_down_outlined,
                                    color: ColorManager.primary,
                                    size: 25.w,))

                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.w,),
                    InkWell(
                      onTap: ()async{
                        if(countryResultBloc.state is !CountryResultStateSuccess){
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(AppStrings.countryError.tr())),
                          // );
                          Fluttertoast.showToast(
                              msg: AppStrings.countryError.tr(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                        }
                        else if( statesReultBloc.state is !StatesResultStateSuccess){
                          Fluttertoast.showToast(
                              msg: AppStrings.governorateError.tr(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text(AppStrings.governorateError.tr())),
                          // );
                        }


                        else{
                          StateModel? mInitalState = await GetIt.I<AppPreferences>().getState();
                          if(mInitalState!= null){
                            String initStateId = mInitalState.stateId!;
                            String selectedStateId =(statesReultBloc.state as StatesResultStateSuccess).stateModel.stateId!;

                              if(GetIt.I<CartBloc>().state is CartSuccess) {
                                List<OrderItemModel> orderList = (GetIt
                                    .I<CartBloc>()
                                    .state
                                as CartSuccess).orderModel.items;
                                if (orderList.isEmpty) {
                              await    GetIt.I<AppPreferences>().saveCountry(
                                      (countryResultBloc
                                          .state as CountryResultStateSuccess)
                                          .countryModel);
                              await    GetIt.I<AppPreferences>().saveState(
                                      (statesReultBloc
                                          .state as StatesResultStateSuccess)
                                          .stateModel);
                                  print("mStoreLocator called For 1");
                                  storeLocatorBloc.add(StoreLocatorFetched(
                                      Constants.headerValue, (countryResultBloc
                                      .state as CountryResultStateSuccess)
                                      .countryModel.id!, (statesReultBloc
                                      .state as StatesResultStateSuccess)
                                      .stateModel.stateId!));
                                } else {
                                  Navigator.pop(context);
                                  _showDeleteItemsDialog(context, orderList,
                                      (countryResultBloc
                                          .state as CountryResultStateSuccess)
                                          .countryModel, (statesReultBloc
                                          .state as StatesResultStateSuccess)
                                          .stateModel);
                                }
                              }else{
                                GetIt.I<AppPreferences>().saveCountry(
                                    (countryResultBloc
                                        .state as CountryResultStateSuccess)
                                        .countryModel);
                                GetIt.I<AppPreferences>().saveState(
                                    (statesReultBloc
                                        .state as StatesResultStateSuccess)
                                        .stateModel);
                                print("mStoreLocator called For 1");
                                storeLocatorBloc.add(StoreLocatorFetched(
                                    Constants.headerValue, (countryResultBloc
                                    .state as CountryResultStateSuccess)
                                    .countryModel.id!, (statesReultBloc
                                    .state as StatesResultStateSuccess)
                                    .stateModel.stateId!));
                              }




                          }else{
                            GetIt.I<AppPreferences>().saveCountry((countryResultBloc.state as CountryResultStateSuccess).countryModel);
                            GetIt.I<AppPreferences>().saveState((statesReultBloc.state as StatesResultStateSuccess).stateModel);
                            print("mStoreLocator called For 2");

                            storeLocatorBloc.add(StoreLocatorFetched(Constants.headerValue, (countryResultBloc.state as CountryResultStateSuccess).countryModel.id!, (statesReultBloc.state as StatesResultStateSuccess).stateModel.stateId!));

                          }

                          // GetIt.I<AppPreferences>().saveCity(mCityModel!);
                        }


                      },
                      child: BlocListener<StoreLocatorBloc, StoreLocatorState>(
                        bloc: storeLocatorBloc,
                        listener: (context, state)async {
                          if(state is StoreLocatorLoading){
                            showLoadingDialog(context);
                            print("StoreLocatorState ---> ${state}");

                          }
                          else if(state is StoreLocatorFailure){
                            Navigator.pop(context);
                            print("StoreLocatorState ---> ${state}");
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );

                          }
                          else if(state is StoreLocatorSuccess) {
                            print("StoreLocatorState ---> ${state}");
                            Navigator.pop(context);

                            UserPreferences userPreferences = GetIt.I<
                                UserPreferences>();
                          await  GetIt.I<AppPreferences>().setStoreCode(
                                state.storeLocatorModel.storeCode!);
                            print("tate.storeLocatorModel.storeCode ---> ${state.storeLocatorModel.storeCode}");
                            await  GetIt.I<AppPreferences>().setSourceCode(
                                state.storeLocatorModel.sourceCode!);

                            await GetIt.I<AppPreferences>().setWebSiteId(state.storeLocatorModel.webSiteId.toString());

                            // GetIt.I<CartBloc>().add(
                            //     CartFetched(userPreferences.userToken!));
                            // Routes.resetNavigatorKeys();
                            if (userPreferences.userToken!.isNotEmpty) {
                              userBloc.add(
                                  UserInfoFetched(userPreferences.userToken!));
                            } else {
                              CountryModel? countryModel = await GetIt.I<
                                  AppPreferences>().getCountry();
                              StateModel? stateModel = await GetIt.I<
                                  AppPreferences>().getState();
                              Map<String, dynamic> map = {};
                              map['country_id'] = countryModel!.id.toString();;
                              map['visitor_id'] = await getDeviceUDID();
                              map['customer_id'] = "";
                              map['quote_id'] = "";
                              map['source_code']=state.storeLocatorModel.sourceCode!.toString();;
                              map['region'] = stateModel!.name.toString();;
                              map['website_id'] =
                              state.storeLocatorModel.webSiteId!.toString();;
                              map['region_id'] = stateModel.stateId.toString();;
                              Map<String, dynamic> locationMap = {};
                              locationMap['location'] = map;
                              await appPreferences.setSourceCode(state.storeLocatorModel.sourceCode!.toString());
                              await appPreferences.setWebSiteId(state.storeLocatorModel.webSiteId!.toString());
                              await appPreferences.setStoreCode(state.storeLocatorModel.storeCode!.toString());
                              saveLocationBloc.add(SaveLocationFetched(
                                  locationMap, Constants.headerValue));

                              // Navigator.of(Routes.getCurrentNavigatorState()!.context).pushReplacementNamed(Routes.mainRoute);

                            }
                          }
                        },
                        child: BlocListener<SaveLocationBloc, SaveLocationState>(
                          bloc: saveLocationBloc,
                          listener: (context, saveLocationState) {
                            if(saveLocationState is SaveLocationLoading){
                              showLoadingDialog(context);

                            }else if(saveLocationState is SaveLocationFailure){
                              Navigator.pop(context);


                            }else if(saveLocationState is SaveLocationSuccess){
                              // UserPreferences userPreferences = GetIt.I<UserPreferences>();
                              // if(userPreferences.userToken!.isNotEmpty){
                              //   GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));
                              // }
                              Navigator.pop(context);
                              Navigator.pop(context);
                              print("dskskfkepskkpfkpsf");
                              Map<String,dynamic> map ={};
                              map['type']= "";
                              map['id']="";
                              Navigator.pushReplacementNamed(context, Routes.mainRoute,arguments: map);
                              ;

                            }
                            // TODO: implement listener
                          },
  child: BlocListener<UserBloc, UserState>(
    bloc: userBloc,
    listener: (context, userState)async {
      if(userState is UserLoading){
        showLoadingDialog(context);
      }else if(userState is UserFailure){
        Navigator.pop(context);
      }else if(userState is UserSuccess){
        Navigator.pop(context);


        CountryModel? countryModel = await GetIt.I<AppPreferences>().getCountry();
        StateModel? stateModel = await GetIt.I<AppPreferences>().getState();
        Map<String,dynamic> map ={};
        map['country_id'] =countryModel!.id.toString();
        map['visitor_id'] =await getDeviceUDID();
        map['customer_id'] =userState.userInfoModel.id.toString();
        map['quote_id'] ="";
        map['region'] =stateModel!.name;
        map['source_code']=(storeLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.sourceCode!.toString();

        map['website_id'] =(storeLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.webSiteId!.toString();
        map['region_id'] = stateModel.stateId.toString();
        await appPreferences.setSourceCode((storeLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.sourceCode!.toString());
        await appPreferences.setWebSiteId((storeLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.webSiteId!.toString());
        await appPreferences.setStoreCode((storeLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.storeCode!.toString());
        Map<String,dynamic> locationMap ={};
        locationMap['location'] = map;
        saveLocationBloc.add(SaveLocationFetched(locationMap, Constants.headerValue));


      }
    },
  child: Container(
                          height: 50.w,
                          width: ScreenUtil().screenWidth,
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(5.w)
                          ),
                          child: Text(AppStrings.continueShipping.tr(),
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal
                            ),),

                        ),
),
),
                      ),
                    ),
                    SizedBox(height: 30.w,),


                  ],
                ),

              )


            ],
          );
        }
    );


  }
  Future<void> _showDeleteItemsDialog(BuildContext context,List<OrderItemModel> orderList,CountryModel mCountryModel,StateModel mStateModel) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(

          content: Container(
            height: 50.h,
            alignment: AlignmentDirectional.center,
            child: Stack(
              children: [
                Positioned.fill(

                  child: Center(
                    child: Text(AppStrings.deleteCart.tr(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: ColorManager.mainBlack,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w500,

                      ),),
                  ),
                ),


              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  BlocListener<DeleteItemCartBloc, DeleteItemCartState>(
                bloc:mDeleteItemCartBloc ,
                listener: (context, state) {
                  if(state is DeleteItemCartLoading){
                    showLoadingDialog(context);
                  }else if(state is DeleteItemCartFailure){
                    Navigator.pop(context);


                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }else if(state is DeleteItemCartSuccess){
                    Navigator.pop(context);

                    print("minus");
                    UserPreferences userPreferences = GetIt.I<UserPreferences>();
                    print("mStoreLocator called For delete");

                    mStoreLocatorBloc.add(StoreLocatorFetched(Constants.headerValue, mCountryModel!.id!, mStateModel!.stateId!));

                  }


                  // TODO: implement listener
                },
                child: BlocListener<StoreLocatorBloc, StoreLocatorState>(
                  bloc: mStoreLocatorBloc,
                  listener: (context, storeLocatoreState)async {
                    if(storeLocatoreState is StoreLocatorLoading){
                      showLoadingDialog(context);
                      print("storelocator StoreLocatorLoading");

                    }
                    else if(storeLocatoreState is StoreLocatorFailure){
                      print("storelocator StoreLocatorFailure");
                      Navigator.pop(context);


                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(storeLocatoreState.message)),
                      );

                    }
                    else if(storeLocatoreState is StoreLocatorSuccess){
                      print("storelocator StoreLocatorSuccess");
                      Navigator.pop(context);


                      UserPreferences userPreferences = GetIt.I<UserPreferences>();
                     await GetIt.I<AppPreferences>().setStoreCode(storeLocatoreState.storeLocatorModel.storeCode!);
                      await  GetIt.I<AppPreferences>().setSourceCode(storeLocatoreState.storeLocatorModel.sourceCode!);
                      await  GetIt.I<AppPreferences>().setWebSiteId(storeLocatoreState.storeLocatorModel.webSiteId.toString());
                      // Routes.resetNavigatorKeys();
                      if(userPreferences.userToken!.isNotEmpty){
                        _userBloc.add(UserInfoFetched(userPreferences.userToken!));
                      }else{
                        CountryModel? countryModel = await GetIt.I<AppPreferences>().getCountry();
                        StateModel? stateModel = await GetIt.I<AppPreferences>().getState();
                        Map<String,dynamic> map ={};
                        map['country_id'] =countryModel!.id.toString();
                        map['visitor_id'] =await getDeviceUDID();
                        map['customer_id'] ="";
                        map['quote_id'] ="";
                        map['source_code']=storeLocatoreState.storeLocatorModel.sourceCode!.toString();;
                        map['region'] =stateModel!.name.toString();;
                        map['website_id'] =storeLocatoreState.storeLocatorModel.webSiteId!.toString();;
                        map['region_id'] = stateModel.stateId.toString();;
                        await appPreferences.setSourceCode(storeLocatoreState.storeLocatorModel.toString());
                        await appPreferences.setWebSiteId(storeLocatoreState.storeLocatorModel.webSiteId!.toString());
                        await appPreferences.setStoreCode(storeLocatoreState.storeLocatorModel.storeCode!.toString());
                        Map<String,dynamic> locationMap ={};
                        locationMap['location'] = map;
                        _saveLocationBloc.add(SaveLocationFetched(locationMap, userPreferences.userToken!));


                        
                      }


                    }
                  },
                  child: BlocListener<SaveLocationBloc, SaveLocationState>(
                    bloc: _saveLocationBloc,
  listener: (context, saveLocationState) {
                      if(saveLocationState is SaveLocationLoading){
                        showLoadingDialog(context);

                      }else if(saveLocationState is SaveLocationFailure){
                        Navigator.pop(context);


                      }else if(saveLocationState is SaveLocationSuccess){
                        UserPreferences userPreferences = GetIt.I<UserPreferences>();


                        Navigator.pop(context);
                        print("dskskfkepskkpfkpsf");
                        Map<String,dynamic> map ={};
                        map['type']= "";
                        map['id']="";
                        Navigator.pushReplacementNamed(context, Routes.mainRoute,arguments: map);
                        ;

                      }
    // TODO: implement listener
  },
  child: BlocListener<UserBloc, UserState>(
    bloc: _userBloc,
  listener: (context, userState)async {
   if(userState is UserLoading){
     showLoadingDialog(context);
   }else if(userState is UserFailure){
     Navigator.pop(context);
     Navigator.pop(context);
   }else if(userState is UserSuccess){
     Navigator.pop(context);
     UserPreferences userPreferences = GetIt.I<UserPreferences>();
     CountryModel? countryModel = await GetIt.I<AppPreferences>().getCountry();
     StateModel? stateModel = await GetIt.I<AppPreferences>().getState();
     Map<String,dynamic> map ={};
     map['country_id'] =countryModel!.id.toString();
     map['visitor_id'] =await getDeviceUDID();
     map['customer_id'] =userState.userInfoModel.id.toString();
     map['quote_id'] ="";
     map['region'] =stateModel!.name;
     map['source_code']=(mStoreLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.sourceCode!.toString();


     map['website_id'] =(mStoreLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.webSiteId!.toString();
     map['region_id'] = stateModel.stateId.toString();
     Map<String,dynamic> locationMap ={};
     locationMap['location'] = map;
     await appPreferences.setSourceCode((mStoreLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.sourceCode!.toString());
     await appPreferences.setWebSiteId((mStoreLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.webSiteId!.toString());
     await appPreferences.setStoreCode((mStoreLocatorBloc.state as StoreLocatorSuccess).storeLocatorModel.storeCode!.toString());
     _saveLocationBloc.add(SaveLocationFetched(locationMap, userPreferences.userToken!));


   }
  },
  child: Text(AppStrings.yes.tr(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Color(0xFF5CB852),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(18),

                    ),),
),
),
                ),
              ),
              onPressed: () async{
             await   GetIt.I<AppPreferences>().saveCountry(mCountryModel);
             await  GetIt.I<AppPreferences>().saveState(mStateModel);


                List<String> itemsId = [];
                for(int i =0;i<orderList.length;i++){
                  itemsId.add(orderList[i].itemId.toString());
                }
                UserPreferences userPreferences = GetIt.I<UserPreferences>();
                mDeleteItemCartBloc.add(DeleteMultipleItemsCartPressed(itemIds: itemsId, authorization: userPreferences.userToken!));

                // Navigator.pushReplacementNamed(context, Routes.mainRoute);


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
        );
      },
    );
  }

  Future<String?> getDeviceUDID() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Sometimes use androidInfo.androidId
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
    return null;
  }


}

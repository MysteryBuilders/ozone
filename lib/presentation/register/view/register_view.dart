import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/main/bloc/store_locator_bloc/store_locator_bloc.dart';
import 'package:ozon/presentation/register/bloc/register_bloc.dart';
import 'package:ozon/presentation/register/bloc/register_event.dart';
import 'package:ozon/presentation/register/bloc/register_state.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/constants.dart';
import '../../../app/extensions.dart';
import '../../../domain/model/country_model.dart';
import '../../../domain/model/state_model.dart';
import '../../country/bloc/country_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../states/bloc/states_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isPasswordShown = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String mCountryCode="";
  StoreLocatorBloc storeLocatorBloc = instance<StoreLocatorBloc>();
  RegisterBloc _registerBloc = instance<RegisterBloc>();
  CountryBloc countryBloc = instance<CountryBloc>();
  StatesBloc statesBloc = instance<StatesBloc>();
  @override
  void dispose() {
    _registerBloc.close();
    super.dispose();
  }
  CountryModel? mCountryModel;
  StateModel? mStateModel;
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  void init()async{
    await Future.delayed(Duration.zero);
    mCountryModel = await GetIt.I<AppPreferences>().getCountry();

    mStateModel= await GetIt.I<AppPreferences>().getState();

    // mCityModel= await GetIt.I<AppPreferences>().getCity();


    if(mCountryModel!= null && mStateModel != null){
      countryBloc.add(SelectCountry(mCountryModel!));
      statesBloc.add(SelectStates(mStateModel!));
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

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
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.w,

            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);

              },
              child: Container(),
            ),


          ),

          body: SafeArea(child: Container(
            width: ScreenUtil().screenWidth,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: Column(
                          children: [
                            Text(AppStrings.createAccount.tr(),
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: ColorManager.mainBlack,
                                  fontWeight: FontWeight.normal,
                                  fontSize: ScreenUtil().setSp(24)
                              ),),
                            SizedBox(height: 10.h,),
                            Text(AppStrings.fillInformation.tr(),
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: ColorManager.secondaryBlack,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.normal
                              ),),

                          ],
                        )

                    ),

                    SizedBox(height: 20.w,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.firstName.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.normal
                      ),),
                    ),
                    Container(
                      height: 40.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),

                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(20.w),

                          border: Border.all(color: ColorManager.secondaryBlack,width:0.5)),
                      child: CustomTextFormField(
                        width: ScreenUtil().screenWidth,

                        variant: TextFormFieldVariant.FillWhiteA700,
                        padding: TextFormFieldPadding.PaddingAll10,
                        controller: _firstNameController,
                      ),
                    ),
                    SizedBox(height: 10.h,),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.lastName.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.normal
                      ),),
                    ),
                    Container(
                      height: 40.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),

                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(20.w),

                          border: Border.all(color: ColorManager.secondaryBlack,width:0.5)),
                      child: CustomTextFormField(
                        width: ScreenUtil().screenWidth,

                        variant: TextFormFieldVariant.FillWhiteA700,
                        padding: TextFormFieldPadding.PaddingAll10,
                        controller: _lastNameController,
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.emailHint.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.normal
                      ),),
                    ),
                    Container(
                      height: 40.w,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),

                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(20.w),

                          border: Border.all(color: ColorManager.secondaryBlack,width:0.5)),
                      child: CustomTextFormField(
                        width: ScreenUtil().screenWidth,

                        variant: TextFormFieldVariant.FillWhiteA700,
                        padding: TextFormFieldPadding.PaddingAll10,
                        controller: _emailController,
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.country.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.normal
                      ),),
                    ),
                    InkWell(
                      onTap: ()async{
                        var result = await     Navigator.pushNamed(context, Routes.countryRoute);
                        if(result!= null){
                          statesBloc.add(InitStates());
                          countryBloc.add(SelectCountry(result as CountryModel));
                          // GetIt.I<CitiesBloc>().add(InitCities());

                          // mCityModel = null;
                        }



                      },
                      child: Container(
                        height: 40.w,
                        alignment: Alignment.center,


                        padding: EdgeInsets.symmetric(horizontal: 10.w),

                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(20.w),

                            border: Border.all(color: ColorManager.secondaryBlack,width:0.5)),
                        child: Container(

                          child: Stack(
                            children: [
                              Positioned.fill(child:
                              BlocBuilder<CountryBloc, CountryState>(
                                bloc: countryBloc,
                                builder: (context, state) {
                                  print(state);
                                  if(state is CountrySuccess){
                                    mCountryModel = state.countryModel;
                                    // mStateModel = null;
                                    // mCityModel = null;


                                    return Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(isRtl()?state.countryModel.fullNameLocale!:state.countryModel.fullNameEnglish!,
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                             color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal
                                        ),),
                                    );
                                  }else{
                                    return Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(AppStrings.selectCountry.tr(),
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal
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
                                    color: ColorManager.mainBlack,
                                    size: 25.w,))

                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.city.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.normal
                      ),),
                    ),
                    InkWell(
                      onTap: ()async{
                        if(countryBloc.state is CountrySuccess){
                          //   Map<String,dynamic> map ={};
                          //   map['stateName'] =(GetIt.I<CountryBloc>().state as CountrySelected).selectedCountry.;
                          // map['title']= AppStrings.city.tr();
                          // Routes.navigateTo(Routes.citiesRoute,arguments: map);
                          Map<String,dynamic> map ={};
                          map['countryCode'] =(countryBloc.state as CountrySuccess).countryModel.id;

                          // Navigator.pushNamed(context, Routes.statesRoute,arguments: map);
                          // statesBloc.add(StatesEvent)
                          map['title']= AppStrings.governorate.tr();

                          var result =        await Navigator.pushNamed(context, Routes.statesRoute,arguments: map);
                          if(result!= null){
                            statesBloc.add(SelectStates(result as StateModel));
                            mStateModel = result;
                            storeLocatorBloc.add(StoreLocatorFetched(Constants.headerValue, mCountryModel!.id!, mStateModel!.stateId!));
                            // GetIt.I<CitiesBloc>().add(InitCities());
                            //
                            // mCityModel = null;
                          }

                        }
                      },
                      child: BlocListener<StoreLocatorBloc, StoreLocatorState>(
                        bloc: storeLocatorBloc,
                          listener: (context, state) {
                        if(state is StoreLocatorLoading){
                        showLoadingView(context);

                        }
                        else if(state is StoreLocatorFailure){
                          Navigator.pop(context);


                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );

                        }
                        else if(state is StoreLocatorSuccess){
                          Navigator.pop(context);

                          GetIt.I<AppPreferences>().saveCountry(mCountryModel!);
                          GetIt.I<AppPreferences>().saveState(mStateModel!);
                          GetIt.I<AppPreferences>().setStoreCode(state.storeLocatorModel.storeCode!);
                          // Navigator.pushReplacementNamed(context, Routes.mainRoute);

                        }
                          },
                          child: Container(
                        height: 40.w,
                            padding: EdgeInsets.symmetric(horizontal: 10.w),

                            decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: BorderRadius.circular(20.w),

                                border: Border.all(color: ColorManager.secondaryBlack,width:0.5)),
                        child: Container(

                          child: Stack(
                            children: [
                              Positioned.fill(child:
                              BlocBuilder<StatesBloc, StatesState>(
                                bloc: statesBloc,
                                builder: (context, state) {
                                  if(state is StatesSuccess){
                                    mStateModel = state.selectState;
                                    // storeLocatorBloc.add(StoreLocatorFetched(Constants.headerValue, mCountryModel!.id!, mStateModel!.stateId!));


                                    return Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(state.selectState.name!,
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal
                                        ),),
                                    );
                                  }else{
                                    return Container(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(AppStrings.selectCity.tr(),
                                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal
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
                                    color: ColorManager.mainBlack,
                                    size: 25.w,))

                            ],
                          ),
                        ),
                      ),
                        ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.phone.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.normal
                      ),),
                    ),
                    Container(
                      height: 40.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),

                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(20.w),

                          border: Border.all(color: ColorManager.secondaryBlack,width:0.5)),



                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(flex:2,child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: CountryCodePicker(
                              pickerStyle: PickerStyle.dialog,
                              initialSelection: 'KW',
                              onChanged: (country){
                                mCountryCode = country.dialCode.toString();
                                print("mCountryCode --> ${mCountryCode}");

                              },
                              onInit: (country){
                                mCountryCode = country!.dialCode.toString();
                                print("mCountryCode --> ${mCountryCode}");
                              },
                              alignLeft: false,
                              padding: EdgeInsets.zero,
                              favorite: ['+965', '+966', '+973','+968','+974'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              textStyle: TextStyle(
                                color: ColorManager.secondaryBlack,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(12)
                              ),
                              flagWidth: 40.w,
                              searchStyle:TextStyle(
                                  color: ColorManager.mainBlack,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.normal
                              ) ,
                              dialogTextStyle: TextStyle(
                                  color: ColorManager.mainBlack,
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.normal
                              ),


                            ),
                          )),
                          Expanded(
                            flex: 4,
                            child: CustomTextFormField(
                              width: ScreenUtil().screenWidth,

                              variant: TextFormFieldVariant.FillWhiteA700,
                              padding: TextFormFieldPadding.PaddingAll10,
                              controller: _phoneController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.password.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.normal
                      ),),
                    ),
                    Container(
                        height: 40.w,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),

                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(20.w),

                            border: Border.all(color: ColorManager.secondaryBlack,width:0.5)),
                        child: CustomTextFormField(
                          width: ScreenUtil().screenWidth,
                          suffix: InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () {
                                isPasswordShown = !isPasswordShown;
                                setState(() {

                                });

                              },
                              child: Container(
                                  alignment: AlignmentDirectional.center,


                                  child: Icon(
                                    size: 24.w,
                                    isPasswordShown
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: ColorManager.mainBlack,
                                  ))),
                          suffixConstraints: BoxConstraints(
                              maxWidth: 24.w,
                              maxHeight: 24.w
                          ),

                          variant: TextFormFieldVariant.FillWhiteA700,
                          padding: TextFormFieldPadding.PaddingAll10,
                          isObscureText:
                          isPasswordShown ? false : true,
                          controller: _passwordController,
                        )
                    ),
                    SizedBox(height: 30.h,),
                    BlocListener<RegisterBloc, RegisterState>(
                      bloc: _registerBloc,
                          listener: (context, state) {
                          if(state is RegisterLoading){
                        showLoadingView(context);

                          }else if(state is RegisterSuccess){
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, Routes.loginRoute);

                          }else if(state is RegisterFailure){
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("سوف يصلك بريد الكتروني لتفعيل الحساب")),
                        );
                          }
                          },
                          child: GestureDetector(
                            onTap: ()async{
                              FocusManager.instance.primaryFocus?.unfocus();
                              String firstName = _firstNameController.text;
                              String lastName = _lastNameController.text;
                              String email = _emailController.text;
                              String phone = _phoneController.text;
                              String password = _passwordController.text;
                              if(firstName.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.firstNameError.tr())),
                                );
                              }else if(lastName.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.lastNameError.tr())),
                                );
                              }else if(email.isEmpty||!email.isValidEmail()){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.emailError.tr())),
                                );
                              }else if(phone.trim().isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.phoneError.tr())),
                                );
                              }else if(!password.isValidPassword()){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.passwordError.tr())),);

                              }else{
                                String store = await GetIt.I<AppPreferences>().getStoreCode();
                                    _registerBloc.add(RegisterButtonPressed(email: email, firstName: firstName, lastName: lastName, phoneNumber: phone, password: password, authorization:Constants.headerValue, countryCode: mCountryModel!.id!, stateId: mStateModel!.stateId!, storeCode: store,));
                                    }

                            },
                            child: Container(
                              height: 40.w,
                              alignment: AlignmentDirectional.center,

                              width: ScreenUtil().screenWidth,
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(20.w),




                              ),
                              child: Text(AppStrings.register.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500

                                ),),
                            ),
                          ),
                        ),

                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, Routes.loginRoute);
                            },
                            child: Container(
                                margin: EdgeInsetsDirectional.only(start: 20.w,end: 20.w,top: 40.h,bottom: 5.h)
                                // getMargin(
                                //     left: 20, top: 40, right: 20, bottom: 5)
                                ,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppStrings.alreadyHaveAccount2.tr(),
                                          // style: TextStyle(
                                          //     color: ColorManager().gray800,
                                          //     fontSize: getFontSize(12),
                                          //     fontFamily: 'Poppins',
                                          //     fontWeight: FontWeight.w400)
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color:  ColorManager.mainBlack,
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.w400
                                          )

                                      ),
                                      TextSpan(
                                          text: AppStrings.login.tr(),
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color:  ColorManager.primary,
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.w400
                                          )


                                      )
                                    ]),
                                    textAlign: TextAlign.start)))),
                    Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context, Routes.mainRoute,(Route<dynamic> route) => false);

                            },
                            child: Container(
                                margin: EdgeInsetsDirectional.only(start: 20.w,end: 20.w,top: 40.h,bottom: 5.h)
                                // getMargin(
                                //     left: 20, top: 40, right: 20, bottom: 5)
                                ,
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: AppStrings.continueAsGuest.tr(),
                                          // style: TextStyle(
                                          //     color: ColorManager().gray800,
                                          //     fontSize: getFontSize(12),
                                          //     fontFamily: 'Poppins',
                                          //     fontWeight: FontWeight.w400)
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                              color:  ColorManager.mainBlack,
                                              fontSize: ScreenUtil().setSp(12),
                                              fontWeight: FontWeight.w400
                                          )

                                      ),

                                    ]),
                                    textAlign: TextAlign.start))))
                  ],

                ),
              ),

            ),


          )),

        ),
      ),
    );
  }
}

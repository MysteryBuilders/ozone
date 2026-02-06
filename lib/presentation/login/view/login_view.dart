import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/app_prefrences.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/location/bloc/save_location_bloc/save_location_bloc.dart';
import 'package:ozon/presentation/login/bloc/login_bloc.dart';
import 'package:ozon/presentation/login/bloc/login_event.dart';
import 'package:ozon/presentation/login/bloc/login_state.dart';
import 'package:ozon/presentation/main/bloc/user_bloc/user_bloc.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../app/user_prefrences.dart';
import '../../../domain/model/country_model.dart';
import '../../../domain/model/state_model.dart';
import '../../main/bloc/create_cart_bloc/create_cart_bloc.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/loading_view.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isPasswordShown = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc = instance<LoginBloc>();
  UserBloc _userBloc = instance<UserBloc>();
  SaveLocationBloc _saveLocationBloc = instance<SaveLocationBloc>();
  AppPreferences _appPreferences = instance<AppPreferences>();
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  CreateCartBloc createCartBloc = instance<CreateCartBloc>();
  @override
  void dispose() {
  _loginBloc.close();
    super.dispose();
  }
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
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
              backgroundColor: ColorManager.white,
              elevation: 0.w,

              leading: GestureDetector(
                onTap: (){
                  Navigator.pop(context);

                },
                child: Container(),
              ),


            ),
            body: SafeArea(
              child: Container(

                  width: ScreenUtil().screenWidth,
                  margin: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                                child: Column(
                                  children: [
                                    Text(AppStrings.login.tr(),
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                          color: ColorManager.mainBlack,
                                          fontWeight: FontWeight.normal,
                                          fontSize: ScreenUtil().setSp(24)
                                      ),),
                                    SizedBox(height: 10.h,),
                                    Text(AppStrings.welcome.tr(),
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                          color: ColorManager.secondaryBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal
                                      ),),

                                  ],
                                )

                            ),
                            SizedBox(height: 30.w,),

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
                            Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.resetPasswordRoute);

                                    },
                                    child: Padding(
                                        padding:EdgeInsetsDirectional.only(start: 10.w,end: 10.w,top: 10.w)
                                        ,
                                        child: Text(AppStrings.forgetPassword.tr(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style:Theme.of(context).textTheme.displayMedium!.copyWith(
                                                color:  ColorManager.primary,
                                                decorationColor: ColorManager.primary,


                                                decoration: TextDecoration.underline,
                                                fontSize: ScreenUtil().setSp(12),
                                                fontWeight: FontWeight.w400
                                            )
                                          // AppStyle.txtPoppinsRegular12Amber900
                                        )))),
                            SizedBox(height: 30.w,),
                            BlocListener<CreateCartBloc, CreateCartState>(
                              bloc: createCartBloc,
          listener: (context, state) {
        if(state is CreateCartLoading){
          showLoadingDialog(context);
        }else
        if(state is CreateCartSuccess){
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, Routes.mainRoute);

        }
          },
          child: BlocListener<LoginBloc, LoginState>(
                              bloc: _loginBloc,
          listener: (context, state) {
                                if(state is LoginLoading){
                                  showLoadingDialog(context);
                                }
                                else if(state is LoginSuccess){
                                  Navigator.pop(context);
                                  _appPreferences.setUserToken(state.newLoginModel.token!);
                                  _appPreferences.setEmail(_emailController.text);
                                  _appPreferences.setPassword(_passwordController.text);
                                  String token = "Bearer "+state.newLoginModel.token!;
                                  userPreferences.userToken = token.replaceAll('"', '');
                                  userPreferences.email= _emailController.text;
                                  userPreferences.password = _passwordController.text;
                                  _userBloc.add(UserInfoFetched(userPreferences.userToken!));



                                }
                                else if (state is LoginFailure){
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                }
        // TODO: implement listener
          },
          child:

          BlocListener<UserBloc, UserState>(
            bloc: _userBloc,
  listener: (context, userState) async{
              if(userState is UserLoading){
                showLoadingDialog(context);
              }else if(userState is UserFailure){
                Navigator.pop(context);
              }else if(userState is UserSuccess){
                Navigator.pop(context);
                CountryModel? countryModel = await GetIt.I<
                    AppPreferences>().getCountry();
                StateModel? stateModel = await GetIt.I<
                    AppPreferences>().getState();
                Map<String, dynamic> map = {};
                map['country_id'] = countryModel!.id.toString();;
                map['visitor_id'] = await getDeviceUDID();
                map['customer_id'] = "";
                map['quote_id'] = "";
                map['source_code']=await GetIt.I<
                    AppPreferences>().getSourceCode().toString();;
                map['region'] = stateModel!.name.toString();;
                map['website_id'] =
                await GetIt.I<
                    AppPreferences>().getWebSiteId()!.toString();;
                map['region_id'] = stateModel.stateId.toString();;
                Map<String, dynamic> locationMap = {};
                locationMap['location'] = map;
                _saveLocationBloc.add(SaveLocationFetched(
                    locationMap, userPreferences.userToken!));
              }
    // TODO: implement listener
  },
  child: BlocListener<SaveLocationBloc, SaveLocationState>(
    bloc: _saveLocationBloc,
  listener: (context, saveLocationState) {
      if(saveLocationState is SaveLocationLoading){
        showLoadingDialog(context);
      }else if(saveLocationState is SaveLocationFailure){
        Navigator.pop(context);
      }else if(saveLocationState is SaveLocationSuccess){
        Navigator.pop(context);
        createCartBloc.add(CreateCartFetched(userPreferences.userToken!));
      }
    // TODO: implement listener
  },
  child: InkWell(
            onTap: ()async{
              FocusScope.of(context).unfocus();
              String email = _emailController.text;
              String password = _passwordController.text;
              if(email.trim() == ""){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppStrings.emailError.tr())),
                );
              }else if(password.trim().length<8){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppStrings.passwordError.tr())),
                );
              }else{
                _loginBloc.add(LoginButtonPressed(email: email, password: password,authorization: Constants.headerValue));

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
              child: Text(AppStrings.login.tr(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500

                ),),
            ),
          ),
),
),

        ),
        ),
                            Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                    onTap: () {
                                   Navigator.pushReplacementNamed(context, Routes.registerRoute);
                                    },
                                    child: Container(
                                        margin: EdgeInsetsDirectional.only(start: 20.w,end: 20.w,top: 40.h,bottom: 5.h)
                                        // getMargin(
                                        //     left: 20, top: 40, right: 20, bottom: 5)
                                        ,
                                        child: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: AppStrings.dontHaveAccount.tr(),
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
                                                  text: AppStrings.signUpNow.tr(),
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



                          ],))),
            )),
      ),
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

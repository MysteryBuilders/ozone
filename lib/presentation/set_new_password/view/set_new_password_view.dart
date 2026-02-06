import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/domain/model/user_info_model.dart';
import 'package:ozon/presentation/set_new_password/bloc/set_new_password_bloc.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/user_prefrences.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/loading_view.dart';
class SetNewPasswordView extends StatefulWidget {
  UserInfoModel userInfoModel;
   SetNewPasswordView({super.key,required this.userInfoModel});

  @override
  State<SetNewPasswordView> createState() => _SetNewPasswordViewState();
}

class _SetNewPasswordViewState extends State<SetNewPasswordView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  AppPreferences _appPreferences = instance<AppPreferences>();
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  bool isCurrentPasswordShown = false;
  bool isNewPasswordShown = false;
  bool isConfirmNewPasswordShown = false;
  SetNewPasswordBloc _setNewPasswordBloc = instance<SetNewPasswordBloc>();
  final TextEditingController _currentPasswordController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
@override
  void dispose() {
    _setNewPasswordBloc.close();
    super.dispose();
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
              text: AppStrings.resetPassword.tr(),
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
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 3.w,
          //   title: AppbarTitle(
          //     text: AppStrings.resetPassword.tr(),
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
          body: SafeArea(child: Container(
            width: ScreenUtil().screenWidth,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(AppStrings.newPassword.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.mainBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 24.sp
                
                        ),),
                    ),
                    SizedBox(height: 2.w,),
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(AppStrings.newPassowrdTip.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.secondaryBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 12.sp
                
                        ),),
                    ),
                
                    SizedBox(height: 30.w,),
                
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.currentPassword.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                
                            border: Border.all(color: ColorManager.secondaryBlack,width:0.2)),
                        child: CustomTextFormField(
                          width: ScreenUtil().screenWidth,
                          suffix: InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () {
                                isCurrentPasswordShown = !isCurrentPasswordShown;
                                setState(() {
                
                                });
                
                              },
                              child: Container(
                                  alignment: AlignmentDirectional.center,
                
                
                                  child: Icon(
                                    size: 24.w,
                                    isCurrentPasswordShown
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
                          isCurrentPasswordShown ? false : true,
                          controller: _currentPasswordController,
                        )
                    ),
                    SizedBox(height: 20.w,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.newPassword.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
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

                            border: Border.all(color: ColorManager.secondaryBlack,width:0.2)),
                        child: CustomTextFormField(
                          width: ScreenUtil().screenWidth,
                          suffix: InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () {
                                isNewPasswordShown = !isNewPasswordShown;
                                setState(() {

                                });

                              },
                              child: Container(
                                  alignment: AlignmentDirectional.center,


                                  child: Icon(
                                    size: 24.w,
                                    isNewPasswordShown
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
                          isNewPasswordShown ? false : true,
                          controller: _newPasswordController,
                        )
                    ),

                    SizedBox(height: 20.w,),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text(AppStrings.confirmNewPassword.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
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

                            border: Border.all(color: ColorManager.secondaryBlack,width:0.2)),
                        child: CustomTextFormField(
                          width: ScreenUtil().screenWidth,
                          suffix: InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () {
                                isConfirmNewPasswordShown = !isConfirmNewPasswordShown;
                                setState(() {

                                });

                              },
                              child: Container(
                                  alignment: AlignmentDirectional.center,


                                  child: Icon(
                                    size: 24.w,
                                    isConfirmNewPasswordShown
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
                          isConfirmNewPasswordShown ? false : true,
                          controller: _confirmNewPasswordController,
                        )
                    ),
                    SizedBox(height: 30.w,),

                    BlocListener<SetNewPasswordBloc, SetNewPasswordState>(
                      bloc: _setNewPasswordBloc,
                          listener: (context, state) {
                        if(state is SetNewPasswordLoading){
                          showLoadingDialog(context);
                        }
                        else if(state is SetNewPasswordSuccess){
                       Navigator.pop(context);
                
                          _appPreferences.setPassword(_newPasswordController.text);
                
                
                          userPreferences.password= _newPasswordController.text;
                
                
                
                
                          Navigator.of(context,rootNavigator: true).pushReplacementNamed( Routes.mainRoute);
                        }
                        else if (state is SetNewPasswordFailure){
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                          },
                          child: InkWell(
                            onTap: (){
                              String oldPassword = _currentPasswordController.text;
                              String newPassword = _newPasswordController.text;
                              String confirmPassword = _confirmNewPasswordController.text;
                              if(!oldPassword.isValidPassword()){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.passwordError.tr())),
                                );


                              }else if(!newPassword.isValidPassword()){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.newPasswordError.tr())),
                                );
                              }else if(!confirmPassword.isValidPassword()){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.newPasswordError.tr())),
                                );
                              }else if(newPassword!= confirmPassword){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.confirmPasswordError.tr())),
                                );
                              }else{
                                _setNewPasswordBloc.add(UpdatePasswordButtonPressed(newPassword: newPassword,confirmNewPassword: confirmPassword, currentPassword: oldPassword,authorization: userPreferences.userToken!));

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
                              child: Text(AppStrings.resetPassword.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500

                                ),),
                            ),
                          ),
                        )
                
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

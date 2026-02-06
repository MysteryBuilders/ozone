import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/app/di.dart';

import 'package:ozon/presentation/resources/color_manager.dart';

import '../../../app/constants.dart';
import '../../resources/assets_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/loading_view.dart';
import '../bloc/forget_password_bloc.dart';
import '../bloc/forget_password_event.dart';
import '../bloc/forget_password_state.dart';
class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  ForgetPasswordBloc _forgetPasswordBloc = instance<ForgetPasswordBloc>();
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
   _forgetPasswordBloc.close();
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
          backgroundColor: ColorManager.gray100,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
           leading:    InkWell(
             onTap: (){
               Navigator.pop(context);
             },
             child: Container(
               margin: EdgeInsets.all(5.w),

               child: Container(
                 alignment: AlignmentDirectional.center,

                 width: 25.w,
                 height: 25.w,
                 decoration: BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.circle,
                     border: Border.all(color:ColorManager.secondaryBlack,
                         width: 1),


                 ),
                 child: Icon(Icons.arrow_back,color: Colors.black,
                   size: 22.w,),
               ),
             ),
           ),
          ),
          body:SafeArea(
            child: Container(
              margin: EdgeInsets.all(20.w),
              width: ScreenUtil().screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(AppStrings.resetPassword.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.mainBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenUtil().setSp(18)
                        ),),
                    ),
                    SizedBox(height: 10.h,),
                    Center(
                      child: Text(AppStrings.instrucrions.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.secondaryBlack,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.normal
                        ),),
                    ),
                    SizedBox(height: 60.h,),

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
                    SizedBox(height: 60.h,),
                    BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
                      bloc: _forgetPasswordBloc,
          listener: (context, state) {
        if(state is ForgetPasswordLoading){
          showLoadingDialog(context);

        }else if(state is ForgetPasswordSuccess){
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, Routes.loginRoute);

        }else if(state is ForgetPasswordFailure){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
          },
          child:GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
              String email = _emailController.text;
              if(email.trim().isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppStrings.emailError.tr())),
                );
              }else{
                _forgetPasswordBloc.add(ForgetPasswordButtonPressed(email: email,authorization: Constants.headerValue));
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
              child: Text(AppStrings.send.tr(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500

                ),),
            ),
          )

        ),
                  ],


                ),
              ),

            ),
          ) ,
        ),
      ),
    );
  }
}

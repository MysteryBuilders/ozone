import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/contact_us/bloc/contact_us_bloc.dart';
import 'package:ozon/presentation/contact_us/contact_us_details_bloc/contact_us_details_bloc.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_form_field.dart';
class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  ContactUsBloc contactUsBloc = instance<ContactUsBloc>();
  ContactUsDetailsBloc contactUsDetailsBloc = instance<ContactUsDetailsBloc>();
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
            backgroundColor: Colors.white,
            elevation: 0.w,
            title: AppbarTitle(
              text: AppStrings.contactUs.tr(),
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
          body: SafeArea(child: BlocBuilder<ContactUsDetailsBloc, ContactUsDetailsState>(
            bloc: contactUsDetailsBloc..add(ContactUsDetailsFetched(Constants.headerValue)),
          builder: (context, contactUsDetailsState) {
              if(contactUsDetailsState is ContactUsDetailsLoading){
                return Container(
                  alignment: AlignmentDirectional.center,
                  child:    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              }else if(contactUsDetailsState is ContactUsDetailsFailure){
                return Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.center,
                  child: Text(contactUsDetailsState.message,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w500

                    ),),
                );
              }else if(contactUsDetailsState is ContactUsDetailsSuccess) {
                return
                  BlocListener<ContactUsBloc, ContactUsState>(
                    bloc: contactUsBloc,
                    listener: (context, state) {
                      if (state is ContactUsLoading) {
                        showLoadingDialog(context);
                      } else if (state is ContactUsFailure) {
                        dismissLoadingDialog();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is ContactUsSuccess) {
                        dismissLoadingDialog();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    child: Container(
                      width: ScreenUtil().screenWidth,
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.all( 20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5.w),
                                child: Text(AppStrings.username.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                  controller: _nameController,
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
                                child: Text(AppStrings.phone.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
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
                                  controller: _mobileNoController,
                                ),
                              ),
                              SizedBox(height: 10.h,),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5.w),
                                child: Text(AppStrings.content.tr(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.mainBlack,
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.normal
                                ),),
                              ),
                              Container(
                                height: 200.w,

                                padding: EdgeInsets.symmetric(horizontal: 10.w),

                                decoration: BoxDecoration(
                                    color: ColorManager.white,
                                    borderRadius: BorderRadius.circular(20.w),

                                    border: Border.all(color: ColorManager.secondaryBlack,width:0.5)),

                                child: CustomTextFormField(
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
                                  width: ScreenUtil().screenWidth,

                                  variant: TextFormFieldVariant.FillWhiteA700,
                                  padding: TextFormFieldPadding.PaddingAll15,
                                  controller: _contentController,

                                ),
                              ),
                              SizedBox(height: 30.w,),
                              InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  String name = _nameController.text;
                                  String email = _emailController.text;
                                  String phone = _mobileNoController.text;
                                  String message = _contentController.text;
                                  if (name
                                      .trim()
                                      .isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          AppStrings.usernameError.tr())),
                                    );
                                  } else if (email
                                      .trim()
                                      .isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          AppStrings.emailError.tr())),
                                    );
                                  } else if (phone
                                      .trim()
                                      .isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          AppStrings.mobileNumberInvalid.tr())),
                                    );
                                  } else if (message
                                      .trim()
                                      .isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          AppStrings.messageError.tr())),
                                    );
                                  } else {
                                    Map<String, dynamic> map = {};
                                    map['name'] = name;
                                    map['email'] = email;
                                    map['phone'] = phone;
                                    map['comment'] = message;
                                    contactUsBloc.add(ContactUsFetched(map));
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
                              ),
                              SizedBox(height: 30.w,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _openMap(contactUsDetailsState.contactUsModel.contactUsList![0].latitude,
                                          contactUsDetailsState.contactUsModel.contactUsList![0].longitude);
                                    },
                                    child: Padding(
                                      padding:  EdgeInsets.all(10.w),
                                      child: Icon(Icons.location_on_outlined,
                                      color: ColorManager.primary,
                                      size: 30.w,),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: ()async{
                                      final call = Uri.parse('tel:${contactUsDetailsState.contactUsModel.contactUsList![0].phone}');
                                      if (await canLaunchUrl(call)) {
                                      launchUrl(call);
                                      } else {
                                      throw 'Could not launch $call';
                                      }
                                    },
                                    child: Padding(
                                      padding:  EdgeInsets.all(10.w),
                                      child: Icon(Icons.phone_android,
                                        color: ColorManager.primary,
                                        size: 30.w,),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      _sendEmail(contactUsDetailsState.contactUsModel.contactUsList![0].email);
                                    },
                                    child: Padding(
                                      padding:  EdgeInsets.all(10.w),
                                      child: Icon(Icons.email_outlined,
                                        color: ColorManager.primary,
                                        size: 30.w,),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20.w,),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(contactUsDetailsState.contactUsModel.contactUsList![0].address,
                                      maxLines: 5,
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                          color: ColorManager.mainBlack,
                                          fontSize: ScreenUtil().setSp(12),
                                          fontWeight: FontWeight.normal,

                                      ),),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
              }else{
                return Container();
              }
          },
        )),
        ),
      ),
    );
  }
  Future<void> _sendEmail(String emailString) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailString,
      queryParameters: {
        'subject': AppStrings.appName.tr(),
        'body': "",
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  Future<void> _openMap(String lat,String lng) async {
    final Uri mapUri = Uri.parse("geo:$lat,$lng");

    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri);
    } else {
      throw 'Could not open the map for the specified location.';
    }
  }

}

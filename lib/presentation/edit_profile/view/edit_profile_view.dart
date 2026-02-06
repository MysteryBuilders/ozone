import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/user_info_model.dart';
import 'package:ozon/presentation/add_address/bloc/add_address_bloc/add_address_bloc.dart';
import 'package:ozon/presentation/edit_profile/bloc/edit_profile_bloc.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/constants.dart';
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
import '../bloc/select_image/select_image_bloc.dart';
import '../bloc/select_image/select_image_event.dart';
import '../bloc/select_image/select_image_state.dart';
class EditProfileView extends StatefulWidget {
  UserInfoModel userInfoModel;
   EditProfileView({super.key,required this.userInfoModel});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstNameController.text = widget.userInfoModel.firstname!;
    _lastNameController.text = widget.userInfoModel.lastname!;
    _emailController.text = widget.userInfoModel.email!;
  }
  final TextEditingController _emailController = TextEditingController();
AddAddressBloc editProfileBloc = instance<AddAddressBloc>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  ImagePickerBloc _imagePickerBloc = instance<ImagePickerBloc>();
  bool isUpdate = false;
  File?  userImageFile;
  String nameImage = "";
  String getInitials(String firstName,String lastName) {
    List<String> parts = [firstName,lastName];
    if (parts.length >= 2) {
      String firstInitial = parts[0].isNotEmpty ? parts[0][0] : '';
      String lastInitial = parts[1].isNotEmpty ? parts[1][0] : '';
      return "$firstInitial$lastInitial".toUpperCase();
    } else if (parts.length == 1 && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    } else {
      return '';
    }
  }
  @override
  Widget build(BuildContext context) {

    AppPreferences _appPreferences = instance<AppPreferences>();
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();
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
              text: AppStrings.profile.tr(),
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

          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              
                  
                  Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(AppStrings.compeleteYourProfile.tr(),
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
                    child: Text(AppStrings.dontWorry.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.secondaryBlack,
                          fontWeight: FontWeight.normal,
                          fontSize: 12.sp
              
                      ),),
                  ),
                  SizedBox(height: 20.w,),
                  BlocBuilder<AddAddressBloc, AddAddressState>(
                    bloc: editProfileBloc,
  builder: (context, state) {
    return Center(
      child: ClipOval(
        child:    Container(
          color: ColorManager.grey,
          height: 90.w,
          width: 90.w,
          child: Center(
            child: Text(getInitials(_firstNameController.text,_lastNameController.text),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: ColorManager.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp
              ),),

          ),
        ),
      ),
    );

  },
),
                  // InkWell(
                  //   onTap: (){
                  //
                  //     _showDialogBottomSheet(context);
                  //   },
                  //   child: Container(
                  //     alignment: AlignmentDirectional.center,
                  //     child: BlocConsumer<ImagePickerBloc, ImagePickerState>(
                  //       bloc: _imagePickerBloc,
                  //       listener: (context, imagePickerState) {
                  //
                  //         // TODO: implement listener
                  //       },
                  //       builder: (context, imagePickerState) {
                  //         if(imagePickerState is ImagePickerLoading){
                  //           if(userImageFile!= null){
                  //             return Container(
                  //               height: 90.w,
                  //               width: 90.w,
                  //               alignment: AlignmentDirectional.center,
                  //               child: Stack(
                  //
                  //
                  //                 children: [
                  //
                  //                   Positioned.fill(child:
                  //                   ClipOval(
                  //                     child:    Container(
                  //                       height: 90.w,
                  //                       width: 90.w,
                  //                       decoration: BoxDecoration(
                  //
                  //                         image: DecorationImage(
                  //                             image: Image
                  //                                 .file(
                  //                                 File(
                  //                                     userImageFile!
                  //                                         .path))
                  //                                 .image,
                  //                             fit: BoxFit
                  //                                 .fill),
                  //                       ),
                  //                     ),
                  //                   )),
                  //                   Positioned.directional(textDirection: Directionality.of(context),
                  //                       bottom: 5.w
                  //                       , end: 0.w, child: Container(
                  //                         height: 30.w,
                  //                         width: 30.w,
                  //                         decoration: BoxDecoration(
                  //                             color: ColorManager.primary,
                  //                             shape: BoxShape.circle,
                  //                             border: Border.all(color: Colors.white, width: 1)
                  //                         ),
                  //                         alignment: AlignmentDirectional.center,
                  //                         child: Icon(Icons.edit, color: Colors.white, size: 20.w,),
                  //                       ))
                  //
                  //                 ],
                  //               ),
                  //
                  //             );
                  //           }else{
                  //             return Container(
                  //               height: 90.w,
                  //               width: 90.w,
                  //               alignment: AlignmentDirectional.center,
                  //               child: Stack(
                  //
                  //
                  //                 children: [
                  //                   Positioned.fill(child:
                  //                   ClipOval(
                  //                     child: CachedNetworkImage(
                  //                       fit: BoxFit.fill,
                  //
                  //
                  //                       imageUrl:
                  //                       "",
                  //                       placeholder: (context, url) =>
                  //                           LinearProgressIndicator(),
                  //                       errorWidget: (context, url, error) =>
                  //                           Image.asset(
                  //                             ImageAssets.UserNotFound,
                  //                             height: 90.w,
                  //                             width: 90.w,
                  //                           ),
                  //                     ),
                  //                   )),
                  //                   Positioned.directional(textDirection: Directionality.of(context),
                  //                       bottom: 5.w
                  //                       , end: 0.w, child: Container(
                  //                         height: 30.w,
                  //                         width: 30.w,
                  //                         decoration: BoxDecoration(
                  //                             color: ColorManager.primary,
                  //                             shape: BoxShape.circle,
                  //                             border: Border.all(color: Colors.white, width: 1)
                  //                         ),
                  //                         alignment: AlignmentDirectional.center,
                  //                         child: Icon(Icons.edit, color: Colors.white, size: 20.w,),
                  //                       ))
                  //
                  //                 ],
                  //               ),
                  //
                  //             );
                  //           }
                  //         }
                  //         else if(imagePickerState is ImagePickerFailure){
                  //           if(userImageFile!= null){
                  //             return Container(
                  //               height: 90.w,
                  //               width: ScreenUtil().screenWidth,
                  //               alignment: AlignmentDirectional.center,
                  //               child: Stack(
                  //
                  //
                  //                 children: [
                  //                   Positioned.directional(
                  //                       textDirection: Directionality.of(context),
                  //                       top:0,
                  //                       bottom:0,
                  //                       start:0,
                  //                       end:0,child:
                  //                   Container(
                  //                     width: ScreenUtil().screenWidth,
                  //                     alignment: AlignmentDirectional.center,
                  //                     child: ClipOval(
                  //
                  //                       child:    Container(
                  //                         alignment: AlignmentDirectional.center,
                  //                         height: 90.w,
                  //                         width: 90.w,
                  //                         decoration: BoxDecoration(
                  //
                  //                           image: DecorationImage(
                  //                               image: Image
                  //                                   .file(
                  //                                   File(
                  //                                       userImageFile!
                  //                                           .path))
                  //                                   .image,
                  //                               fit: BoxFit
                  //                                   .fill),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   )),
                  //                   Positioned.directional(textDirection: Directionality.of(context),
                  //                       bottom: 5.w
                  //                       , end: 0.w, child: Container(
                  //                         height: 30.w,
                  //                         width: 30.w,
                  //                         decoration: BoxDecoration(
                  //                             color: ColorManager.primary,
                  //                             shape: BoxShape.circle,
                  //                             border: Border.all(color: Colors.white, width: 1)
                  //                         ),
                  //                         alignment: AlignmentDirectional.center,
                  //                         child: Icon(Icons.edit, color: Colors.white, size: 20.w,),
                  //                       ))
                  //
                  //                 ],
                  //               ),
                  //
                  //             );
                  //           }else{
                  //             return Container(
                  //               height: 90.w,
                  //               width: 90.w,
                  //               alignment: AlignmentDirectional.center,
                  //               child: Stack(
                  //
                  //
                  //                 children: [
                  //                   Positioned.fill(child:
                  //                   ClipOval(
                  //                     child: CachedNetworkImage(
                  //                       fit: BoxFit.fill,
                  //
                  //
                  //                       imageUrl:
                  //                     "",
                  //                       placeholder: (context, url) =>
                  //                           LinearProgressIndicator(),
                  //                       errorWidget: (context, url, error) =>
                  //                           Image.asset(
                  //                             ImageAssets.UserNotFound,
                  //                             height: 90.w,
                  //                             width: 90.w,
                  //                           ),
                  //                     ),
                  //                   )),
                  //                   Positioned.directional(textDirection: Directionality.of(context),
                  //                       bottom: 5.w
                  //                       , end: 0.w, child: Container(
                  //                         height: 30.w,
                  //                         width: 30.w,
                  //                         decoration: BoxDecoration(
                  //                             color: ColorManager.primary,
                  //                             shape: BoxShape.circle,
                  //                             border: Border.all(color: Colors.white, width: 1)
                  //                         ),
                  //                         alignment: AlignmentDirectional.center,
                  //                         child: Icon(Icons.edit, color: Colors.white, size: 20.w,),
                  //                       ))
                  //
                  //                 ],
                  //               ),
                  //
                  //             );
                  //           }
                  //
                  //         }else if(imagePickerState is ImagePickerSuccess){
                  //           userImageFile =
                  //               imagePickerState.image;
                  //           return Container(
                  //             height: 90.w,
                  //             width: 90.w,
                  //             alignment: AlignmentDirectional.center,
                  //             child: Stack(
                  //
                  //
                  //               children: [
                  //                 Positioned.fill(child:
                  //                 ClipOval(
                  //                   child:    Container(
                  //                     height: 90.w,
                  //                     width: 90.w,
                  //                     decoration: BoxDecoration(
                  //
                  //                       image: DecorationImage(
                  //                           image: Image
                  //                               .file(
                  //                               File(
                  //                                   imagePickerState
                  //                                       .image
                  //                                       .path))
                  //                               .image,
                  //                           fit: BoxFit
                  //                               .fill),
                  //                     ),
                  //                   ),
                  //                 )),
                  //                 Positioned.directional(textDirection: Directionality.of(context),
                  //                     bottom: 5.w
                  //                     , end: 0.w, child: Container(
                  //                       height: 30.w,
                  //                       width: 30.w,
                  //                       decoration: BoxDecoration(
                  //                           color: ColorManager.primary,
                  //                           shape: BoxShape.circle,
                  //                           border: Border.all(color: Colors.white, width: 1)
                  //                       ),
                  //                       alignment: AlignmentDirectional.center,
                  //                       child: Icon(Icons.edit, color: Colors.white, size: 20.w,),
                  //                     ))
                  //
                  //               ],
                  //             ),
                  //
                  //           );
                  //         }else {
                  //           if(userImageFile!= null){
                  //             return Container(
                  //               height: 90.w,
                  //               width: 90.w,
                  //               alignment: AlignmentDirectional.center,
                  //               child: Stack(
                  //
                  //
                  //                 children: [
                  //                   Positioned.fill(child:
                  //                   ClipOval(
                  //                     child:    Container(
                  //                       height: 90.w,
                  //                       width: 90.w,
                  //                       decoration: BoxDecoration(
                  //
                  //                         image: DecorationImage(
                  //                             image: Image
                  //                                 .file(
                  //                                 File(
                  //                                     userImageFile!
                  //                                         .path))
                  //                                 .image,
                  //                             fit: BoxFit
                  //                                 .fill),
                  //                       ),
                  //                     ),
                  //                   )),
                  //                   Positioned.directional(textDirection: Directionality.of(context),
                  //                       bottom: 5.w
                  //                       , end: 0.w, child: Container(
                  //                         height: 30.w,
                  //                         width: 30.w,
                  //                         decoration: BoxDecoration(
                  //                             color: ColorManager.primary,
                  //                             shape: BoxShape.circle,
                  //                             border: Border.all(color: Colors.white, width: 1)
                  //                         ),
                  //                         alignment: AlignmentDirectional.center,
                  //                         child: Icon(Icons.edit, color: Colors.white, size: 20.w,),
                  //                       ))
                  //
                  //                 ],
                  //               ),
                  //
                  //             );
                  //           }else{
                  //             return Container(
                  //               height: 90.w,
                  //               width: 90.w,
                  //               alignment: AlignmentDirectional.center,
                  //               child: Stack(
                  //
                  //
                  //                 children: [
                  //                   Positioned.fill(child:
                  //                   ClipOval(
                  //                     child: CachedNetworkImage(
                  //                       fit: BoxFit.fill,
                  //
                  //
                  //                       imageUrl:
                  //                       "",
                  //                       placeholder: (context, url) =>
                  //                           LinearProgressIndicator(
                  //                             color: Colors.white,
                  //                             backgroundColor: Colors.white,
                  //                           ),
                  //                       errorWidget: (context, url, error) =>
                  //                           Image.asset(
                  //                             ImageAssets.UserNotFound,
                  //                             height: 90.w,
                  //                             width: 90.w,
                  //                           ),
                  //                     ),
                  //                   )),
                  //                   Positioned.directional(textDirection: Directionality.of(context),
                  //                       bottom: 5.w
                  //                       , end: 0.w, child: Container(
                  //                         height: 30.w,
                  //                         width: 30.w,
                  //                         decoration: BoxDecoration(
                  //                             color: ColorManager.primary,
                  //                             shape: BoxShape.circle,
                  //                             border: Border.all(color: Colors.white, width: 1)
                  //                         ),
                  //                         alignment: AlignmentDirectional.center,
                  //                         child: Icon(Icons.edit, color: Colors.white, size: 20.w,),
                  //                       ))
                  //
                  //                 ],
                  //               ),
                  //
                  //             );
                  //           }
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20.w,),
              
              
              
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
                  Text(AppStrings.emailHint.tr(),
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
                      controller: _emailController,
                      decoration: InputDecoration(

                        hintText: AppStrings.emailHint.tr(),
                        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorManager.secondaryBlack,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.normal


                        ),



                      ),

                    ),
                  ),
                  SizedBox(height: 30.w,),
              
                  BlocListener<AddAddressBloc, AddAddressState>(
                    bloc: editProfileBloc,
                        listener: (context, state) {
                      if(state is AddAddressLoading){
                        showLoadingDialog(context);
                      }
                      else if(state is AddAddressSuccess){
                      Navigator.pop(context);
              
                        _appPreferences.setEmail(_emailController.text);
              
              
              
              
                        userPreferences.email= _emailController.text;
                      Map<String,dynamic> map ={};
                      map['type']= "";
                      map['id']="";
                      Navigator.pushReplacementNamed(context, Routes.mainRoute,arguments: map);





                      }
                      else if (state is AddAddressFailure){
                      Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
                        );
                      }
                        },
                        child: InkWell(
                          onTap: (){
                            FocusScope.of(context).unfocus();
                            String firstName=_firstNameController.text;
                            String lastName = _lastNameController.text;
                            String email = _emailController.text;

                            if(firstName.trim().isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppStrings.firstNameError.tr())),
                              );
                            }else if(lastName.trim().isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppStrings.lastNameError.tr())),
                              );
                            }else if(email.trim().isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppStrings.emailError.tr())),
                              );
                            }else{
                              Map<String,dynamic> map = {};
                              map['id']= widget.userInfoModel.id;
                              map['email'] = email;
                              map['firstname']=firstName;
                              map['lastname'] = lastName;
                              map['website_id'] = widget.userInfoModel.websiteId;
                              Map<String,dynamic> customerMap = {};
                              customerMap['customer']= map;
                              editProfileBloc.add(AddAddressFetched(customerMap, userPreferences.userToken.toString(),0));


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
                            child: Text(AppStrings.updateProfile.tr(),
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500

                              ),),
                          ),
                        ),
                      ),
              
                ],
              
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _showDialogBottomSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
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
              Container(height: 70.w,
                width: ScreenUtil().screenWidth,
                alignment: Alignment.center,

                child: Text(AppStrings.selectImage.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal
                  ),),),
              Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),

              SizedBox(height: 20.w,),
              Container(height: 40.w,
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(flex:1,child: InkWell(
                      onTap: (){
                        _imagePickerBloc.add(PickImage(fromCamera: true));
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        color: ColorManager.gray300,
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.camera.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.primary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal
                          ),),
                      ),
                    )),
                    SizedBox(width: 20.w,),
                    Expanded(flex:1,child: InkWell(
                      onTap: (){
                        _imagePickerBloc.add(PickImage(fromCamera: false));
                        Navigator.pop(context);

                      },
                      child: Container(
                        color: ColorManager.primary,
                        alignment: AlignmentDirectional.center,
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.gallery.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal
                          ),),
                      ),
                    )),


                  ],
                ),),
              Container(height: 30.w,
                color: Color(0x00000000),),


            ],
          );
        }
    );


  }
}

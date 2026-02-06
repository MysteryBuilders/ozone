import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/app_prefrences.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/app/user_prefrences.dart';
import 'package:ozon/domain/model/country_model.dart';
import 'package:ozon/domain/model/splash_model.dart';
import 'package:ozon/domain/model/state_model.dart';
import 'package:ozon/presentation/login/bloc/login_bloc.dart';
import 'package:ozon/presentation/login/bloc/login_state.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/splash/bloc/app_Versions_bloc/app_versions_bloc.dart';
import 'package:ozon/presentation/splash/bloc/gif_bloc/gif_bloc.dart';
import 'package:ozon/presentation/splash/bloc/gif_bloc/gif_state.dart';
import 'package:ozon/presentation/splash/bloc/new_splash_bloc/new_splash_bloc.dart';
import 'package:ozon/presentation/splash/bloc/notification_bloc/notification_bloc.dart';
import 'package:ozon/presentation/splash/bloc/notification_bloc/notification_state.dart';

import 'package:ozon/presentation/splash/bloc/splash_bloc/splash_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:video_player/video_player.dart';


import '../../../app/constants.dart';
import '../../login/bloc/login_event.dart';
import '../../main/bloc/create_cart_bloc/create_cart_bloc.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../bloc/gif_bloc/gif_event.dart';
import '../bloc/notification_bloc/notification_event.dart';
import '../bloc/splash_bloc/splash_event.dart';
import '../bloc/splash_bloc/splash_state.dart';
import 'package:gif_view/gif_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late VideoPlayerController _controller;
   NewSplashBloc _splashBloc = instance<NewSplashBloc>();
   SplashModel? splashModel;
  final UserBloc userBloc = instance<UserBloc>();
  GifBloc _gifBloc = instance<GifBloc>();
  late NotificationBloc _notificationBloc = instance<NotificationBloc>();
  AppPreferences appPreferences = GetIt.I<AppPreferences>();
  UserPreferences userPreferences = GetIt.I<UserPreferences>();
  late AppVersionsBloc _appVersionsBloc = instance<AppVersionsBloc>();
  LoginBloc loginBloc = instance<LoginBloc>();
  final GifController _gifController = GifController();
  final int _totalFrames = 40; // You can experiment to get an accurate number
  CreateCartBloc createCartBloc = instance<CreateCartBloc>();
  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.asset(ImageAssets.splashVedio)
    //   ..initialize().then((_) {
    //     // Once the video is initialized, start playing it and trigger the event in Bloc
    //     _controller.play();
    //     _splashBloc.add(InitializeVideo());
    //
    //     // Listen to video status and when it's done, trigger the VideoEnded event
    //     _controller.addListener(() {
    //       if (_controller.value.position == _controller.value.duration) {
    //         _splashBloc.add(VideoEnded());
    //       }
    //     });
    //   });
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          key: scaffoldKey,
          body: Container(
            color: Colors.white,
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,

            child: BlocListener<NotificationBloc, NotificationState>(
              bloc: _notificationBloc,
              listener: (context, state) async {
                if (state is TokenReceivedState) {
                  String userToken = await appPreferences.getUserToken();
                  String email = await appPreferences.getEmail();
                  String password = await appPreferences.getPassword();
                  if (email.isNotEmpty) {
                    loginBloc.add(LoginButtonPressed(email: email,
                        password: password,
                        authorization: Constants.headerValue));
                  } else {
                    userPreferences.userToken = "";
                    userPreferences.email = "";
                    userPreferences.password = "";
                    showAnimatedFullScreenDialog(context, splashModel!.imageSplashList![0]);

                    // Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
                  }
                }
              },
              child: BlocListener<CreateCartBloc, CreateCartState>(
                bloc: createCartBloc,
            listener: (context, state) {
                  if(state is CreateCartSuccess){
                    showAnimatedFullScreenDialog(context, splashModel!.imageSplashList![0]);

                  }
          // TODO: implement listener
            },
            child: BlocListener<LoginBloc, LoginState>(
                          bloc: loginBloc,
                          listener: (context, state) async {
                            if (state is LoginSuccess) {
                              String email = await appPreferences.getEmail();
                              String password = await appPreferences.getPassword();
                              appPreferences.setUserToken(state.newLoginModel.token!);
                              appPreferences.setEmail(email);
                              appPreferences.setPassword(password);
                              print("tokenss ---> ${state.newLoginModel.token}");
                              String token = "Bearer " + state.newLoginModel.token!;
                              userPreferences.userToken = token.replaceAll('"', '');
                              userPreferences.email = email;
                              userPreferences.password = password;
                              userBloc.add(UserInfoFetched(userPreferences.userToken!));


                              createCartBloc.add(CreateCartFetched(userPreferences.userToken!));


                              // Navigator.pushReplacementNamed(context, Routes.mainRoute);
                            }
                            else if (state is LoginFailure) {
                              userPreferences.userToken = "";
                              userPreferences.email = "";
                              userPreferences.password = "";
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                              showAnimatedFullScreenDialog(context, splashModel!.imageSplashList![0]);

                              // Navigator.of(context).pushReplacementNamed(Routes.mainRoute);

                            }
                          },
                          child: BlocListener<NewSplashBloc, NewSplashState>(
                            bloc: _splashBloc,
                            listener: (context, state) {
                              if (state is NewSplashSuccess) {
                                if(state.isSplashFinishedLoading) {
                                  splashModel = state.splashModel;
                                  _appVersionsBloc.add(
                                      AppVersionsFetched(Constants.headerValue));
                                  //
                                  // _notificationBloc!.add(GetToken());
                                }
                              }
                            },
                            child: BlocListener<AppVersionsBloc, AppVersionsState>(
                              bloc: _appVersionsBloc,
                              listener: (context, state) async{
                                if(state is AppVersionsSuccess){
                                  PackageInfo packageInfo = await PackageInfo.fromPlatform();

                                  String appName = packageInfo.appName;
                                  String packageName = packageInfo.packageName;
                                  String version = packageInfo.version;

                                  String buildNumber = packageInfo.buildNumber;
                                  print('appName ---> ${appName}');
                                  print('packageName ---> ${packageName}');
                                  print('version ---> ${version}');
                                  print('buildNumber ---> ${buildNumber}');
                                  if(Platform.isIOS){
                                    int  iosVersion = int.parse(state.appVersionModel.versionsList![0].ios!.toString());
                                    int currentVersion = int.parse(buildNumber);
                                    if(currentVersion >= iosVersion){
                                      _notificationBloc!.add(GetToken());
                                      // Navigator.pushReplacementNamed(context, Routes.mainRoute);
                                    }else{
                                      String url = 'https://apps.apple.com/kw/app/id6711355509';
                                      showDownloadDialog(context,url);
                                      // _notificationBloc!.add(GetToken());

                                    }

                                  }
                                  else if(Platform.isAndroid){
                                    int androidVersion = int.parse(state.appVersionModel.versionsList![0].android!.toString());
                                    int currentVersion = int.parse(buildNumber);
                                    if(currentVersion >= androidVersion){
                                      _notificationBloc!.add(GetToken());
                                    }else{
                                      String url = 'https://play.google.com/store/apps/details?id=${packageName}';
                                      showDownloadDialog(context,url);

                                    }
                                  }
                                  // _notificationBloc!.add(GetToken());

                                }
                                // TODO: implement listener
                              },
                              child: BlocBuilder<NewSplashBloc, NewSplashState>(
                                bloc: _splashBloc..add(NewSplashFetched()),
                                builder: (context, state) {
                                  if(state is NewSplashLoading){
                                    return Container(
                                      alignment: AlignmentDirectional.center,
                                      child:    SizedBox(
                                          height: 150.w,
                                          width: 150.w,
                                          child: Lottie.asset(ImageAssets.loadingView)),

                                    );
                                  }else if(state is NewSplashFailure){
                                    return Container(
                                      color: Colors.white,
                                      alignment: AlignmentDirectional.center,
                                      child: Text(state.message,
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(18),
                                            fontWeight: FontWeight.w500

                                        ),),
                                    );
                                  }else if(state is NewSplashSuccess){
                                    int timeOut = state.splashModel.timeout!;


                                    return Container(

                                      child: GifView.network(
                                        progressBuilder: (context){
                                          return Container(
                                            height: 30,
                                            width: 30,
                                            child: LinearProgressIndicator(
                                              color: Colors.grey.shade200,
                                              backgroundColor: Colors.grey.shade100,
                                            ),
                                          );
                                        },
                                        fit: BoxFit.fill,
                                        state.splashModel.gif!,
                                        controller: _gifController,
                                        loop: false,
                                        onStart: (){
                                          print("start");
                                        },
                                        onFinish: () {
                                          print("finish");
                                         //  _gifController.play();
                                         // _gifBloc.add(GifStarted());
                                        },
                                        onLoaded: (int i){
                                          // int timeOut = splashModel!.timeout!;
                                          Timer(Duration(milliseconds:timeOut), () {
                                            _splashBloc.add(SplashTimeoutFinished());
                                          });


                                        },
                                        frameRate: 30,
                                      ),
                                    );
                                  }else{
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
          ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> showDownloadDialog(BuildContext context,String url) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,

          content: Container(
            height: 50.h,
            alignment: AlignmentDirectional.center,
            child: Text("update_message".tr(),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w500,

              ),),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text("yes".tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Color(0xFF5CB852),
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(18),

                ),),
              onPressed: () {
                Navigator.pop(context);
                _launchUrl(url);

              },
            ),
            TextButton(
              child:  Text("no".tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Color(0xFFDB3562),
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(18),

                ),),
              onPressed: () {
                Navigator.pop(context);
                exit(0);
              },
            ),
          ],
        );

      },
    );
  }
  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void showAnimatedFullScreenDialog(BuildContext context,ImageSplashModel imageSplashModel) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(
          color: Colors.transparent, // Makes background transparent
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white, // Pop-up background
          // Rounded corners
            ),
            child: Stack(
              children: [
                Positioned.fill(

                  child: InkWell(
                    onTap: ()async{
                CountryModel?      mCountryModel = await GetIt.I<AppPreferences>().getCountry();

                 StateModel?     mStateModel = await GetIt.I<AppPreferences>().getState();
                 if(mCountryModel!= null && mStateModel!= null){
                   String type = splashModel!.imageSplashList![0].type!;
                   String id = splashModel!.imageSplashList![0].id!;

                   Map<String,dynamic> map ={};
                   map['type']= type;
                   map['id']=id;
                   Navigator.pushReplacementNamed(context, Routes.mainRoute,arguments: map);

                 }else{
                   String type = splashModel!.imageSplashList![0].type!;
                   String id = splashModel!.imageSplashList![0].id!;

                   Map<String,dynamic> map ={};
                   map['type']= type;
                   map['id']=id;
                   Navigator.pushReplacementNamed(context, Routes.locationRoute,arguments: map);

                 }



                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: ClipRRect(

                        child: CachedNetworkImage(
                          width: ScreenUtil().screenWidth,
                          height: double.infinity,

                          fit: BoxFit.fill,
                          imageUrl: imageSplashModel.imageUrl!,
                          imageBuilder: (context,
                              imageProvider) =>
                              Container(
                                  width: ScreenUtil()
                                      .screenWidth,


                                  decoration: BoxDecoration(


                                    image: DecorationImage(


                                        fit: BoxFit.fill,
                                        image: imageProvider),
                                  )
                              ),
                          placeholder: (context, url) =>
                              Container(
                                height: 30,
                                width: 30,
                                child: LinearProgressIndicator(
                                  color: Colors.grey.shade200,
                                  backgroundColor: Colors.grey
                                      .shade100,
                                ),
                              ),


                          errorWidget: (context, url,
                              error) =>
                              SizedBox(
                                width: 30.w,
                                height: 30.w,
                                child: Image.asset(
                                  'assets/images/image_not_found.png',
                                  height: 30.w,
                                  width: 30.w,

                                ),
                              ),

                        ),


                      ),
                    ),
                  ),
                )
                ,
                Positioned.directional(textDirection:Directionality.of(context),
                    top:50.h,
                    end:20.w,child: InkWell(
                    onTap: ()async {
        CountryModel?      mCountryModel = await GetIt.I<AppPreferences>().getCountry();

        StateModel?     mStateModel = await GetIt.I<AppPreferences>().getState();
        if(mCountryModel!= null && mStateModel!= null) {
          Map<String,dynamic> map ={};
          map['type']= "";
          map['id']="";
          Navigator.pushReplacementNamed(context, Routes.mainRoute,arguments: map);
        }else{
          Map<String,dynamic> map ={};
          map['type']= "";
          map['id']="";
          Navigator.pushReplacementNamed(context, Routes.locationRoute,arguments: map);
        }
                    },
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: ColorManager.primary
                            ,
                        borderRadius: BorderRadius.circular(12.w),
                      ),


                      child: Text(AppStrings.skip.tr(),
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                        ),),

                                            ),
                    ),)
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
              .animate(animation),
          child: child,
        );
      },
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    _splashBloc.close();
    super.dispose();
  }
}

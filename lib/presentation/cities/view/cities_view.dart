import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/presentation/cities/bloc/cities_bloc.dart';

import '../../../app/user_prefrences.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';

import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';

import '../../widgets/appbar_title.dart';
class CitiesView extends StatefulWidget {
  final String stateName;
  const CitiesView({super.key,required this.stateName});

  @override
  State<CitiesView> createState() => _CitiesViewState();
}

class _CitiesViewState extends State<CitiesView> {

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  final TextEditingController _searchController = TextEditingController();

  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      final query = _searchController.text;
      // Dispatch search event to the bloc whenever the text changes
      GetIt.I<CitiesBloc>().add(SearchCities(query));
    });
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
              text: AppStrings.selectCity.tr(),
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
            margin: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Container(
                    height: 44.w,
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                        color: ColorManager.white,
                        border: Border.all(color: ColorManager.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(22.w)

                    ),
                    child: TextFormField(



                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorManager.mainBlack,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.normal


                      ),
                      obscureText: false,
                      controller: _searchController,
                      decoration: InputDecoration(



                        hintText: AppStrings.searchCity.tr(),
                        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorManager.blackLight,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.normal


                        ),



                      ),

                    )
                ),
                SizedBox(height: 10.h,),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: ScreenUtil().screenWidth,
                    height: ScreenUtil().screenHeight,
                    child: BlocBuilder<CitiesBloc, CitiesState>(
                      bloc: GetIt.I<CitiesBloc>()..add(CitiesFetched(widget.stateName)),
                      builder: (context, state) {
                        if(state is CitiesLoading){
                          return Container(
                            alignment: AlignmentDirectional.center,
                            child: SizedBox(
                                height: 150.w,
                                width: 150.w,
                                child: Lottie.asset(ImageAssets.loadingView)),

                          );
                        }else if(state is CitiesFailure){
                          return Container(
                            color: Colors.white,
                            alignment: AlignmentDirectional.center,
                            child: Text(state.message,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w500

                              ),),
                          );
                        }else if(state is CitiesSuccess) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10.w),
                            child: ListView.separated(itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  GetIt.I<CitiesBloc>().add(SelectCity(state.citiesModel[index]));

                                 Navigator.pop(context);
                                },
                                child: Container(
                                  height: 44.w,
                                  alignment: Alignment.center,

                                  decoration: BoxDecoration(
                                      color: ColorManager.whiteA700,
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
                                            state.citiesModel[index].cityName!,
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                color: ColorManager.black900,
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w400

                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.directional(
                                        textDirection: Directionality.of(context),
                                        top: 0,
                                        bottom: 0,
                                        end: 10.w,
                                        child: SvgPicture.asset(
                                          isRtl()?  ImageAssets.imgArrowleft:ImageAssets.imgArrowright,
                                          color: ColorManager.amber900,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }, separatorBuilder: (context,index){
                              return Column(
                                children: [
                                  SizedBox(height: 5.w,),
                                  Container(height: 1.w,width: ScreenUtil().screenWidth,
                                    color: ColorManager.borderColor,),
                                  SizedBox(height: 10.w,),
                                ],
                              );
                            }, itemCount: state.citiesModel.length),

                          );
                        }else{
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


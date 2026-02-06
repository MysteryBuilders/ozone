import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/presentation/country/bloc/country_bloc.dart';

import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../search/widgets/custom_search_view.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';

class CountryView extends StatefulWidget {
  const CountryView({super.key});

  @override
  State<CountryView> createState() => _CountryViewState();
}

class _CountryViewState extends State<CountryView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  final TextEditingController _searchController = TextEditingController();

  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  CountryBloc countryBloc = instance<CountryBloc>();
  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _searchController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if(GetIt.I<CountryBloc>().state is !CountrySuccess){
    //   GetIt.I<CountryBloc>().add(CountriesFetched(userPreferences.userToken!));

    // }
  }
  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      final query = _searchController.text;
      // Dispatch search event to the bloc whenever the text changes
      countryBloc.add(SearchCountries(query));
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
              text: AppStrings.country.tr(),
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



                      hintText: AppStrings.searchCountry.tr(),
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
                    child: BlocBuilder<CountryBloc, CountryState>(
                      bloc: countryBloc..add(CountriesFetched(userPreferences.userToken!)),
                      builder: (context, state) {
                        if(state is CountryLoading){
                        return Container(
                        alignment: AlignmentDirectional.center,
                        child: SizedBox(
                        height: 150.w,
                        width: 150.w,
                        child: Lottie.asset(ImageAssets.loadingView)),

                        );
                        }else if(state is CountryFailure){
                        return Container(
                        color: Colors.white,
                        alignment: AlignmentDirectional.center,
                        child: Text(state.message,
                        style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(
                        color: ColorManager.secondaryBlack,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.normal

                        ),),
                        );
                        }else if(state is CountrySuccess) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.w),
                      child: ListView.separated(itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            // GetIt.I<CountryBloc>().add(SelectCountry(state.categoryModel[index]));
                            Navigator.pop(context,state.categoryModel[index]);
                          },
                          child: Container(
                            height: 44.w,
                            alignment: Alignment.center,

                            decoration: BoxDecoration(
                                color: ColorManager.white,
                            ),
                            child: Stack(
                              children: [
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  top: 0,
                                  bottom: 0,
                                  start: 0,
                                  child: Container(
                                    width: ScreenUtil().screenWidth,
                                    height: ScreenUtil().screenHeight,

                                    child: Row(
                                      children: [
                                        Container(
                                          width: 60.w,
                                          alignment: AlignmentDirectional.center,
                                          child: SvgPicture.network(
                                         state.categoryModel[index].extensionAttributes!.image!,
                                            width: 50.w,
                                            height: 50.w,





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
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          flex: 1,
                                          child: Text(

                                            textAlign: TextAlign.start,
                                            isRtl()?state.categoryModel[index].fullNameLocale.toString():state.categoryModel[index].fullNameEnglish.toString(),
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                color: ColorManager.secondaryBlack,
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.normal

                                            ),
                                          ),
                                        ),
                                      ],
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
                                    color: ColorManager.primary,
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
                      }, itemCount: state.categoryModel.length),

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

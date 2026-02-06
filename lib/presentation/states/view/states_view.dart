import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/di.dart';

import '../../../app/user_prefrences.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../search/widgets/custom_search_view.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../bloc/states_bloc.dart';
class StatesView extends StatefulWidget {
  final String countryCode;
  const StatesView({super.key,required this.countryCode});

  @override
  State<StatesView> createState() => _StatesViewState();
}

class _StatesViewState extends State<StatesView> {

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
  StatesBloc statesBloc = instance<StatesBloc>();
  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      final query = _searchController.text;
      // Dispatch search event to the bloc whenever the text changes
      statesBloc.add(SearchStates(query));
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
              text: AppStrings.governorate.tr(),
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



                        hintText: AppStrings.searchGovernorate.tr(),
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
                    child: BlocBuilder<StatesBloc, StatesState>(
                      bloc: statesBloc..add(StatesFetched(widget.countryCode!)),
                      builder: (context, state) {
                        if(state is StatesLoading){
                          return Container(
                            alignment: AlignmentDirectional.center,
                            child: SizedBox(
                                height: 150.w,
                                width: 150.w,
                                child: Lottie.asset(ImageAssets.loadingView)),

                          );
                        }else if(state is StatesFailure){
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
                        }else if(state is StatesSuccess) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10.w),
                            child: ListView.separated(itemBuilder: (context,index){
                              return InkWell(
                                onTap: (){
                                  // GetIt.I<StatesBloc>().add(SelectStates(state.statesList[index]));
                                  Navigator.pop(context,state.statesList[index]);
                                },
                                child: Container(
                                  height: 50.w,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                                  decoration: BoxDecoration(
                                      color: ColorManager.whiteA700,
                                      borderRadius: BorderRadius.circular(10.w)),
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
                                            state.statesList[index].name!,
                                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                color: ColorManager.secondaryBlack,
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.normal

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
                            }, itemCount: state.statesList.length),

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

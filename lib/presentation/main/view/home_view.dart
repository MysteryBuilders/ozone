import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lottie/lottie.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/app/user_prefrences.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/presentation/main/bloc/count_down_bloc/counter_bloc.dart';
import 'package:ozon/presentation/main/bloc/home_bloc/home_bloc.dart';
import 'package:ozon/presentation/main/bloc/home_bloc/home_state.dart';
import 'package:ozon/presentation/main/view/home_widget/before_after_widget.dart';
import 'package:ozon/presentation/main/view/home_widget/grid_view_widget.dart';
import 'package:ozon/presentation/main/view/home_widget/home_brands_widget.dart';
import 'package:ozon/presentation/main/view/home_widget/home_categories_widget.dart';
import 'package:ozon/presentation/main/view/home_widget/home_product_widget.dart';
import 'package:ozon/presentation/main/view/home_widget/home_slider_widget.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../app/app_prefrences.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../bloc/home_bloc/home_event.dart';
import 'home_widget/straggled_grid_view_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeBloc ?_homeBloc = instance<HomeBloc>();
  CountdownBloc? countdownBloc = instance<CountdownBloc>();
  AppPreferences appPreferences = instance<AppPreferences>();
  UserPreferences userPreferences = instance<UserPreferences>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();


  }
  init()async{
    String sourceCode = await appPreferences.getSourceCode();
    userPreferences.sourceCode = sourceCode;
    _homeBloc!.add(HomeFetched(Constants.headerValue));


  }
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _homeBloc!.close();

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
          backgroundColor: ColorManager.gray100,
          body: BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeBloc!,
            builder: (context, state) {
              if(state is HomeLoading){
                return Container(
                  alignment: AlignmentDirectional.center,
                  child:    SizedBox(
                    height: 150.w,
                    width: 150.w,
                    child: Lottie.asset(ImageAssets.loadingView)),

                );
              }else if(state is HomeSuccess){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.w),

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            border: Border.all(color: ColorManager.borderColor),
                            borderRadius: BorderRadius.circular(22.w)
                          ),
                          child: Container(

                            child: Stack(
                              children: [
                                Positioned.fill(
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



                                      hintText: AppStrings.search.tr(),
                                      hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          color: ColorManager.blackLight,
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
                                  child: InkWell(
                                    onTap: (){
                                      if(_searchController.text.trim().isNotEmpty){
                                        Map<String,dynamic> map = {};
                                        map['searchText'] = _searchController.text;
                                        Navigator.pushNamed(context, Routes.searchRoute,arguments: map);
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(AppStrings.searchError.tr())),
                                        );
                                      }


                                    },
                                    child: Container(

                                      child: Icon(Icons.search_outlined,color: ColorManager.primary,size: 30.w,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.w,),

                        ListView.separated(
                            padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),


                            itemBuilder: (context,index){
                          return buildItem(state.screenHome.components[index].componentData, state.screenHome.components[index].type,state.screenHome.components[index].timer);
                        }, separatorBuilder: (context,index){
                          return Container(height: 10.w,);
                        }, itemCount: state.screenHome.components.length),
                        Container(height: 80.w,)
                      ],
                    ),
                  ),
                );
              }else if(state is HomeFailure){
                return Center(child: Text(' ${state.message}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.normal
                ),));
              }else {
                return Center(child: Text('No data loaded'));
              }
            },
          ),
        ),
      ),
    );
  }
  Widget buildItem(dynamic componentData,String type, int time){

    if(type == "slider_component_di"){
      return HomeSliderWidget(sliderList: componentData as List<SliderComponentDataHome>,time: time,countdownBloc: countdownBloc!,);

    }else if(type =="two_banner_component_di"){
      print(componentData);
      return GridViewWidget(sliderList: componentData as List<SliderComponentDataHome>,time: time,countdownBloc: countdownBloc!,);

    }else if(type =="four_banner_component_di"){
      print(componentData);
      return StraggledGridViewWidget(sliderList: componentData as List<SliderComponentDataHome>,time: time,countdownBloc: countdownBloc!,);

    }else if(type == "before_after_filter_banner_component_di"){
      return BeforeAfterWidget(sliderList: componentData as List<SliderComponentDataHome>,time: time,countdownBloc: countdownBloc!,);

    }

    else if(type == "category_component_di"){
      return HomeCategoriesWidget(categoryComponentDataHome: componentData as List<CategoryComponentHome>,time: time,countdownBloc: countdownBloc!);
    }else if(type =="products_component_di"){
      List<ProductComponentDataHome> productComponentDataHomeList = componentData as List<ProductComponentDataHome>;
      ProductComponentDataHome productComponentDataHome = productComponentDataHomeList[0];
      String type = productComponentDataHome.collectionFilter;
      String title = productComponentDataHome.title;

      List<ProductHome> productList=[];
      if(type == "best_seller"){
         productList = productComponentDataHome.newArrivalProducts!;

      }else if(type =="offers"){
        productList = productComponentDataHome.newArrivalProducts!;
      }else if(type =="new_arrival"){
        productList = productComponentDataHome.newArrivalProducts!;
      }
      return HomeProductWidget(productList: productList, title: title,time: time,countdownBloc: countdownBloc!);



    }else if(type =="brands_component_di"){
      List<BrandHome> brandsComponentDataHomeList = componentData as List<BrandHome>;
      // BrandComponentDataHome brandComponentDataHome = brandsComponentDataHomeList[0];
      // List<BrandHome> brandList = brandComponentDataHome.featuredBrands;
      String title = AppStrings.brands.tr();
      return HomeBrandsWidget(brandList: brandsComponentDataHomeList,title: title,time: time,countdownBloc: countdownBloc!,);
    }else if(type == "banner_component_di"){
      return HomeSliderWidget(sliderList: componentData as List<SliderComponentDataHome>,time: time,countdownBloc: countdownBloc!,);

    }

    else {
      return Container();
    }

  }

}

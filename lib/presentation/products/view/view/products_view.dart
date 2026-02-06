import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/data/network/helper_query.dart';
import 'package:ozon/presentation/main/bloc/offers_bloc/load_more_bloc.dart';

import 'package:ozon/presentation/product_details/bloc/range_bloc/price_range_state.dart';
import 'package:ozon/presentation/products/bloc/products_bloc.dart';
import 'package:ozon/presentation/products/bloc/sort_category_bloc/sort_category_bloc.dart';

import '../../../../app/constants.dart';
import '../../../../app/user_prefrences.dart';
import '../../../../domain/model/products_model.dart';
import '../../../../domain/model/sorting_category_model.dart';
import '../../../main/bloc/offers_bloc/load_more_event.dart';
import '../../../main/bloc/offers_bloc/load_more_state.dart';
import '../../../product_details/bloc/range_bloc/price_range_bloc.dart';
import '../../../product_details/bloc/range_bloc/price_range_event.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/langauge_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/appbar_iconbutton.dart';
import '../../../widgets/appbar_title.dart';
import '../../../widgets/product_widget.dart';
import '../widgets/gridmaskgroup_item_widget.dart';

class ProductsView extends StatefulWidget {
  String categoryName;
  String categoryId;

  ProductsView(
      {super.key, required this.categoryName, required this.categoryId});

  @override
  State<ProductsView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductsView> {
  int page=1;
  LoadMoreBloc? loadMoreBloc  = instance<LoadMoreBloc>();
  SortCategoryBloc sortCategoryBloc = instance<SortCategoryBloc>();
  PriceRangeBloc? priceRangeBloc = instance<PriceRangeBloc>();
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  HelperQuery helperQuery = HelperQuery();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();
    // if(userPreferences.userToken!.isEmpty){
    userToken = Constants.headerValue;
    sortCategoryBloc.add(SortCategoryFetched(int.parse(widget.categoryId), userToken));
    map=    helperQuery.buildFilterQueryParams(categoryId: widget.categoryId,sortDirection: 'DESC',pageSize: 10,page: 1);
    print(map);

    loadMoreBloc!.add(LoadInitialData(map,userToken));
  }
  Map<String,dynamic> map ={};
String userToken="";
  @override
  Widget build(BuildContext context) {


    ;
    // }else{
    //   userToken = userPreferences.userToken!;
    // }


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
                  text: widget.categoryName.tr(),
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

              body: BlocBuilder<SortCategoryBloc, SortCategoryState>(
      bloc: sortCategoryBloc,
              builder: (context, sortCategoryState) {
            if(sortCategoryState is SortCategoryLoading){
              return Container(
                alignment: AlignmentDirectional.center,
                child:    SizedBox(
                    height: 150.w,
                    width: 150.w,
                    child: Lottie.asset(ImageAssets.loadingView)),

              );
            }else if(sortCategoryState is SortCategoryFailure){
              return Container(
                color: Colors.white,
                alignment: AlignmentDirectional.center,
                child: Text(sortCategoryState.message,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.w500

                  ),),
              );
            }
            else if(sortCategoryState is SortCategorySuccess){

              return Column(
                children: [
                  SizedBox(height: 10.w,),
                  Container(height: 50.w,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    width: ScreenUtil().screenWidth,
                    child: Row(
                      children: [
                        Expanded(flex:1,child: InkWell(
                          onTap: (){
                            showPositionBottomSheet(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: ColorManager.lightGrey,
                                  width: 1,

                                ),
                                borderRadius: BorderRadius.circular(5.w)
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill( child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                 sortCategoryState.sortingOptionModel.sortName,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: ColorManager.black900,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ScreenUtil().setSp(14),



                                    ),),
                                )),
                                Positioned.directional(textDirection: Directionality.of(context),top: 0,
                                  bottom: 0,
                                  end: 10.w,
                                  child: SvgPicture.asset(
                                    ImageAssets.imgArrowdown,
                                    color: ColorManager.amber900,
                                  ),)

                              ],
                            ),
                          ),
                        )),
                        InkWell(
                          onTap: (){
                            if(sortCategoryState.sortBy == "DESC"){
                              sortCategoryBloc.add(SortBySelect("ASC"));

                            }else{
                              sortCategoryBloc.add(SortBySelect("DESC"));
                            }
                            print("areAllValuesEmpty ---> ${areAllValuesEmpty(sortCategoryState.filterMap)}");
                            if(areAllValuesEmpty(sortCategoryState.filterMap)){

                              map=    helperQuery.buildFilterQueryParams(categoryId: widget.categoryId,sortOrder:sortCategoryState.sortingOptionModel.sortCode,sortDirection: sortCategoryState.sortBy,page: 1,pageSize: 10);
                            }else{
                              map=    helperQuery.buildFilterQueryParams(sortOrder:sortCategoryState.sortingOptionModel.sortCode,sortDirection: sortCategoryState.sortBy,searchCriteriaMap: sortCategoryState.filterMap,
                                  page: 1,pageSize: 10);
                            }
                            loadMoreBloc!.add(LoadInitialData(map,userToken));


                          },
                          child: Container(width: 30.w,
                            margin: EdgeInsets.all(5.w),
                            alignment: Alignment.center,
                            child:sortCategoryState.sortBy =="DESC"?Icon(Icons.arrow_downward_outlined,size: 30.w,
                              color: ColorManager.primary,) :
                            Icon(Icons.arrow_upward_outlined,size: 30.w,
                              color: ColorManager.primary,)),
                        ),
                        InkWell(
                          onTap: (){
        showFilterBottomSheet(context);
                          },
                          child: Container(width: 30.w,
                              margin: EdgeInsets.all(5.w),
                              alignment: Alignment.center,
                              child:
                              Icon(Icons.filter_alt,size: 30.w,
                                color: ColorManager.primary,)),
                        )
                      ],
                    ),),
                  SizedBox(height: 10.w,),
                  Expanded(
                    flex: 1,
                    child: BlocBuilder<LoadMoreBloc, LoadMoreState>(
                      bloc: loadMoreBloc!,
                      builder: (context, state) {
                        if(state is DataLoading){
                          return Container(
                            alignment: AlignmentDirectional.center,
                            child:    SizedBox(
                                height: 150.w,
                                width: 150.w,
                                child: Lottie.asset(ImageAssets.loadingView)),

                          );
                        }
                        else if(state is DataError){
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
                        }
                        else if(state is DataLoaded){

                          return  SingleChildScrollView(
                            controller: _createScrollController(context),
                            child: Container(
                              margin: EdgeInsets.all(20.w),
                              child: Column(
                                children: [
                                  GridView.builder(


                                    // padding: getPadding(left: 20, top: 25, right: 20,
                                    //     bottom: 20),
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,



                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                                          childAspectRatio: 3 / 4),


                                      itemCount: state.items.length
                                      ,
                                      itemBuilder: (context, index) {

                                        ProductItemModel model = state.items![index];
                                        return Container(
                                            margin: EdgeInsets.all(5),
                                            child: ProductItemWidget(categoryProductsModelObj: model,));
                                      }),
                                  Container(
                                      child: !state.hasReachedMax?GridTile(
                                        child: Center(

                                          child:    SizedBox(
                                              height: 150.w,
                                              width: 150.w,
                                              child: Lottie.asset(ImageAssets.loadingView)),

                                        ),
                                      ):Container()

                                  )


                                ],
                              ),
                            ),
                          );

                        }else {
                          return Container(

                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            }else{
              return Container();
            }

              },
            ),
            ),
          ),
    );
  }
  ScrollController _createScrollController(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !(loadMoreBloc!.state as DataLoaded).hasReachedMax) {
        page++;
        map['searchCriteria[currentPage]']= page;

        loadMoreBloc!.add(LoadMoreData(map,userToken));
      }
    });
    return _scrollController;
  }
  void showPositionBottomSheet(BuildContext context){
    showModalBottomSheet(enableDrag: false,
      isDismissible: false,
      context: context,

      isScrollControlled: true, // Important for wrap content behavior
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(

        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context){
      return BlocBuilder<SortCategoryBloc, SortCategoryState>(
        bloc: sortCategoryBloc,
  builder: (context, state) {
          if(state is SortCategorySuccess){
            return Container(
              height: 250.w,
              child: Column(
                children: [
                  Container(height: 50.w,
                    width: ScreenUtil().screenWidth,


                    child: Stack(
                      children: [
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          child: InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close,color: ColorManager.primary,size: 30.w,))
                          ,
                          top: 0,
                          bottom: 0,
                          end: 10.w,),
                        Positioned.fill(

                          child: Center(
                            child: Text(AppStrings.arrang.tr(),
                              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(16),
                                fontWeight: FontWeight.w500,

                              ),),
                          ),
                        ),

                      ],
                    ),),
                  Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),

                  Expanded(
                    flex: 1,
                    child: ListView.separated(

                        itemBuilder: (context,index){

                      return InkWell(
                        onTap: (){
                          sortCategoryBloc.add(SortCategorySelect(state.sortingCategoryModel.sortOptionList![index], index));
                          if(areAllValuesEmpty(state.filterMap)){

                            map=    helperQuery.buildFilterQueryParams(searchCriteriaMap: state.filterMap,sortOrder:state.sortingCategoryModel.sortOptionList![index].sortCode,sortDirection: state.sortBy,page: 1,pageSize: 10);
                          }else{
                            map=    helperQuery.buildFilterQueryParams(categoryId: widget.categoryId,sortOrder:state.sortingCategoryModel.sortOptionList![index].sortCode,sortDirection: state.sortBy,page: 1,pageSize: 10);
                          }

                          loadMoreBloc!.add(LoadInitialData(map,userToken));
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50.w,
                          child: Stack(
                            children: [
                              Positioned.directional(textDirection: Directionality.of(context),
                                  top:0,
                                  bottom:0,
                                  start:10.w,
                                  child:Container(
                                    alignment: Alignment.center,
                                    child: Text(state.sortingCategoryModel.sortOptionList![index].sortName,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.black900,
                                        fontWeight: FontWeight.normal,
                                        fontSize: ScreenUtil().setSp(14),



                                      ),),
                                  ) ),
                              Positioned.directional(textDirection: Directionality.of(context),top: 0,
                                bottom: 0,
                                end: 10.w,
                                child: Icon(state.position == index?
                                Icons.check_box_outlined    :Icons.check_box_outline_blank,
                                color: ColorManager.primary,
                                size: 30.w,),)


                            ],
                          ),

                        ),
                      );
                    }, separatorBuilder: (context,index){
                      return Container(height: 1,
                      width: ScreenUtil().screenWidth,
                      color: ColorManager.lightGrey,);
                    }, itemCount: state.sortingCategoryModel.sortOptionList!.length),
                  ),
                ],
              ),
            );
          }else{
            return Container();
          }

  },
);
      }
    );
  }
  void showFilterBottomSheet(BuildContext parentContext){
    showModalBottomSheet(enableDrag: false,
        isDismissible: false,
        context: parentContext,

        isScrollControlled: true, // Important for wrap content behavior
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(

          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context){
          return BlocBuilder<SortCategoryBloc, SortCategoryState>(
            bloc: sortCategoryBloc,



          builder: (context, state) {
            print('New state emitted: $state');
            if(state is SortCategorySuccess){

              return Container(
                height: 400.w,
                child: Column(
                  children: [
                    Container(height: 50.w,
                      width: ScreenUtil().screenWidth,


                      child: Stack(
                        children: [
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close,color: ColorManager.primary,size: 30.w,))
                            ,
                            top: 0,
                            bottom: 0,
                            end: 10.w,),
                          Positioned.fill(

                            child: Center(
                              child: Text(AppStrings.filter.tr(),
                                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: Colors.black,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w500,

                                ),),
                            ),
                          ),
                          Positioned.directional(
                            textDirection: Directionality.of(context),
                            child: InkWell(
                                onTap: (){
                                  userToken = Constants.headerValue;
                                  sortCategoryBloc.add(SortCategoryFetched(int.parse(widget.categoryId), userToken));
                                  map=    helperQuery.buildFilterQueryParams(categoryId: widget.categoryId,sortDirection: 'DESC',page: 1,pageSize: 10);

                                  loadMoreBloc!.add(LoadInitialData(map,userToken));               Navigator.pop(context);
                                },
                                child: Icon(Icons.refresh,color:
                               ColorManager.primary,size: 30.w,))
                            ,
                            top: 0,
                            bottom: 0,
                            start: 10.w,),

                        ],
                      ),),
                    Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),

                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(5.w),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                               ListView.separated(
                                 shrinkWrap: true,
                                   physics: NeverScrollableScrollPhysics(),
                                   itemBuilder: (context,index){
                                 return Container(
                                   child: Column(
                                     children: [
                                       Container(
                                         alignment: AlignmentDirectional.centerStart,
                                         child: Text(state.sortingCategoryModel.availableFilterList![index].filterName!,
                                           style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                               color: ColorManager.black,
                                               fontSize: ScreenUtil().setSp(14),
                                               fontWeight: FontWeight.normal
                                           ),),
                                       ),
                                       SizedBox(height: 4.w),
                                       Container(
                                         child:
                                         state.sortingCategoryModel.availableFilterList![index].filterCode == "price"?
                                         BlocBuilder<PriceRangeBloc, PriceRangeState>(
                                           bloc: priceRangeBloc!..add(LoadInitialRange(RangeValues(state.filterMap['startPrice'].toDouble(),state.filterMap['endPrice'].toDouble()))),
                                           builder: (context, rangeState) {
                                             return Column(
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                             RangeSlider(
                                               values: rangeState.range,
                                               min: state.sortingCategoryModel.availableFilterList![index].minPrice!.toDouble(),
                                               max: state.sortingCategoryModel.availableFilterList![index].maxPrice!.toDouble(),
                                               divisions: state.sortingCategoryModel.availableFilterList![index].maxPrice!,
                                               activeColor: ColorManager.primary,
                                               inactiveColor: Colors.grey.shade300,
                                               onChanged: (RangeValues newValues) {
                                                 priceRangeBloc!
                                                     .add(UpdatePriceRange(newValues));
                                                 state.filterMap['startPrice'] = newValues.start;
                                                 state.filterMap['endPrice'] = newValues.end;
                                                 sortCategoryBloc.add(filterFetch(state.filterMap));



                                               },
                                             ),
                                             Padding(
                                               padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                               child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Text(
                                                       '${
                                             rangeState.range.start.toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                                                       style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                           color: Colors.black,
                                                           fontWeight: FontWeight.normal,
                                                           fontSize: ScreenUtil().setSp(14)
                                                       )
                                                   ),
                                                   Text(
                                                     '${rangeState.range.end.toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                                                     style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                       color: Colors.black,
                                                       fontWeight: FontWeight.normal,
                                                       fontSize: ScreenUtil().setSp(14)
                                                     )
                                                   ),

                                                 ],
                                               ),
                                             ),
                                           ],
                                         );
                                           },
                                         ):

                                         GridView.builder(scrollDirection: Axis.vertical,



                                           shrinkWrap: true,
                                           physics: const NeverScrollableScrollPhysics(),
                                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,
                                               childAspectRatio: 4 / 2),
                                           itemCount:state.sortingCategoryModel.availableFilterList![index].filterOptionList!.length ,
                                           itemBuilder: (context,i){
                                             return InkWell(
                                               onTap: (){
                                                 List<String> types=[];
                                                 Map<String,dynamic> map = state.filterMap;

                                                 if(!map.containsKey(state.sortingCategoryModel.availableFilterList![index].filterCode)){

                                                   types.add(state.sortingCategoryModel.availableFilterList![index].filterOptionList![i].filterId);
                                                   map[state.sortingCategoryModel.availableFilterList![index].filterCode!] = types;
                                                   sortCategoryBloc.add(filterFetch(map));
                                                 }else{
                                                   types = map[state.sortingCategoryModel.availableFilterList![index].filterCode!];
                                                   bool isExists = false;
                                                   int pos = 0;
                                                   for(int j =0;j<types.length;j++){
                                                     if(types[j]== state.sortingCategoryModel.availableFilterList![index].filterOptionList![i].filterId){
                                                       // types.removeAt(j);
                                                       isExists= true;
                                                       pos = j;
                                                       break;
                                                     }
                                                   }
                                                   if(isExists){
                                                     types.removeAt(pos);
                                                   }else{
                                                     types.add(state.sortingCategoryModel.availableFilterList![index].filterOptionList![i].filterId);

                                                   }
                                                   map[state.sortingCategoryModel.availableFilterList![index].filterCode!] = types;

                                                   sortCategoryBloc.add(filterFetch(map));

                                                 }




                                               },
                                               child: Container(
                                                 margin: EdgeInsetsDirectional.symmetric(vertical: 4.w,horizontal: 5.w),

                                                 child: Container(
                                                   alignment: AlignmentDirectional.center,
                                                   height: 30.w,
                                                   decoration: BoxDecoration(
                                                       color:isSelected(state.filterMap,state.sortingCategoryModel.availableFilterList![index].filterCode!,state.sortingCategoryModel.availableFilterList![index].filterOptionList![i].filterId)?
                                                       ColorManager.primary:ColorManager.gray300
                                                   ),
                                                   child: Text(state.sortingCategoryModel.availableFilterList![index].filterOptionList![i].name,
                                                     textAlign: TextAlign.center,

                                                     style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                         color: isSelected(state.filterMap,state.sortingCategoryModel.availableFilterList![index].filterCode!,state.sortingCategoryModel.availableFilterList![index].filterOptionList![i].filterId)?
                                                         Colors.white:ColorManager.black,
                                                         fontWeight: FontWeight.normal,
                                                         fontSize: ScreenUtil().setSp(8)

                                                     ),),

                                                 ),
                                               ),
                                             );
                                           },
                                         ),
                                       )
                                     ],
                                   ),
                                 );
                               }, separatorBuilder:
                               (context,index){
                                 return Container(height: 5.w,);
                               } , itemCount: state.sortingCategoryModel.availableFilterList!.length)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w,),
                    InkWell(
                      onTap: (){
                        if(state.filterMap.isNotEmpty){

                            if (state.sortingOptionModel.sortCode == "") {
                              print(state.filterMap);
                              map = helperQuery.buildFilterQueryParams(
                                  searchCriteriaMap: state.filterMap,
                                  sortDirection: state.sortBy,page: 1,pageSize: 10);
                            } else {
                              map = helperQuery.buildFilterQueryParams(
                                  searchCriteriaMap: state.filterMap,
                                  sortOrder: state.sortingOptionModel.sortCode,
                                  sortDirection: state.sortBy,page: 1,pageSize: 10);
                            }


                            loadMoreBloc!.add(LoadInitialData(map, userToken));
                            Navigator.pop(context);
                          }



                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        height: 50.w,
                        width: ScreenUtil().screenWidth,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(5.w)
                        ),
                        child: Text(AppStrings.apply.tr(),
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                          ),),

                      ),
                    ),
                    SizedBox(height: 10.w,),
                  ],
                ),
              );
            }else{
              return Container();
            }

          },
                    );
        }
    );
  }
  bool isSelected(Map<String,dynamic> map,String key,String optionId){
    bool isSelect = false;
    print(map);
    if(map.containsKey(key)){
      List<String> types=map[key];
      for(int i =0;i<types.length;i++){
        if(types[i] == optionId){
          isSelect = true;
          break;




        }


      }


    }else{
      isSelect = false;
    }

    return isSelect;
  }
  bool areAllValuesEmpty(Map<String, dynamic> map) {
    for (var value in map.values) {
      if (value is List && value.isNotEmpty) return false;
          }
    return true;
  }
}

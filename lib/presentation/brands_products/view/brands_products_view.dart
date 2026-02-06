import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/domain/model/products_model.dart';

import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../../data/network/helper_query.dart';

import '../../main/bloc/offers_bloc/load_more_bloc.dart';
import '../../main/bloc/offers_bloc/load_more_event.dart';
import '../../main/bloc/offers_bloc/load_more_state.dart';
import '../../products/view/widgets/gridmaskgroup_item_widget.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/product_widget.dart';
class BrandsProductsView extends StatefulWidget {
  final String brandId;
  final String brandName;
  const BrandsProductsView({super.key,required this.brandId,required this.brandName});

  @override
  State<BrandsProductsView> createState() => _BrandsProductsViewState();
}

class _BrandsProductsViewState extends State<BrandsProductsView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  HelperQuery helperQuery = HelperQuery();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Map<String,dynamic> map ={};
  int page =1;
  int pageSize = 10;
  LoadMoreBloc loadMoreBloc  = instance<LoadMoreBloc>();
  String userToken="";
  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();
    // if(userPreferences.userToken!.isEmpty){
    userToken = Constants.headerValue;
    // }else{
    //   userToken = userPreferences.userToken!;
    // }
    map=    helperQuery.buildFilterQueryParams(brandId: widget.brandId,page: 1,pageSize: 10);

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
              text: widget.brandName,
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
          body: BlocBuilder<LoadMoreBloc, LoadMoreState>(
            bloc: loadMoreBloc!..add(LoadInitialData(map,userToken)),
            builder: (context, state) {
              if(state is DataLoading){
                return Container(
                  alignment: AlignmentDirectional.center,
                  child:    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              } if(state is DataError){
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
              } if(state is DataLoaded){
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
      ),
    );
  }
  ScrollController _createScrollController(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !(loadMoreBloc.state as DataLoaded).hasReachedMax) {
        page++;
        map=    helperQuery.buildFilterQueryParams(brandId: widget.brandId,page:page,pageSize: 10);

        loadMoreBloc.add(LoadMoreData(map,userToken));
      }
    });
    return _scrollController;
  }
}

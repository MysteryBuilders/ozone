import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:alphabet_slider/alphabet_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/domain/model/brands_model.dart';
import 'package:ozon/presentation/brands/bloc/brand_select_bloc/brand_select_bloc.dart';
import 'package:ozon/presentation/brands/bloc/brands_bloc.dart';
import 'package:ozon/presentation/brands/widget/grid_brand_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../main/view/widgets/gridticket1_item_widget.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';


class BrandsView extends StatefulWidget {
  const BrandsView({super.key});

  @override
  State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> {
  final ScrollController _scrollController = ScrollController();
  BrandsBloc ?_brandsBloc = instance<BrandsBloc>();
  BrandSelectBloc ?_brandSelectBloc = instance<BrandSelectBloc>();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();

  /// Callback function when a letter is selected in the AlphabetSlider.
  int selectedIndex = 0;

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
          body: BlocBuilder<BrandsBloc, BrandsState>(
            bloc: _brandsBloc!
              ..add(BrandsFetched(Constants.headerValue)),
            builder: (context, state) {
              if (state is BrandsStateLoading) {
                return Container(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              } else if (state is BrandsStateFailure) {
                return Center(child: Text(' ${state.message}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal
                  ),));
              } else if (state is BrandsStateSuccess) {
              return Container(
                child: BlocBuilder<BrandSelectBloc, BrandSelectState>(
                  bloc: _brandSelectBloc!..add(BrandsSelectFetched(0)),
                builder: (context, brandSelectState) {
                    if(brandSelectState is BrandSelectSuccess){
                      return Column(
                        children: [
                          Expanded(
                            flex:1,
                            child: Container(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return InkWell(
                                      onTap: (){
                                        _brandSelectBloc!.add(BrandsSelectFetched(index));
                                      },
                                      child: Container(
                                        height: ScreenUtil().screenHeight,
                                        width: 50.w,
                                        alignment: AlignmentDirectional.center,
                                        decoration:brandSelectState.index == index?
                                        BoxDecoration(
                                            color: Colors.white,
                                            border: Border(bottom: BorderSide(
                                                color: ColorManager.primary,
                                                width:1
                                            ))
                                        )
                                        :BoxDecoration(
                                          color: Colors.white,
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: ColorManager.seperatorColor,
                                                    width: 0.5

                                                )
                                            )

                                        ),
                                        child: Text(

                                          state.brandsList[index].title.toString(),
                                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: brandSelectState.index == index?ColorManager.primary: ColorManager.secondaryBlack,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500
                                          ),),

                                      ),
                                    );
                                  }, itemCount: state.brandsList.length),
                            ),
                          ),
                          Expanded(flex:9,child: Container(
                            child:SingleChildScrollView(
                              child:
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(20.w),
                                    child: GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                                            childAspectRatio: 3 / 3),
                                        // physics: BouncingScrollPhysics(),
                                        itemCount: state.brandsList[brandSelectState.index].brandsList!.length,
                                        itemBuilder: (context, index) {
                                          BrandItemModel model = state.brandsList[brandSelectState.index].brandsList![index];
                                          return Container(
                                            margin: EdgeInsets.all(5.w),
                                              child: GridBrandView(model));
                                        }),
                                  ),
                                  Container(height: 80.w,)
                                ],
                              ),
                            ) ,
                          ))
                        ],
                      );
                    }else{
                      return Container();
                    }

                },
                            ),


              );
              } else {
                return Container();
              }
            },
          ),

        ),
      ),
    );
  }
}


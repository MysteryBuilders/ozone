import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_bloc.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_event.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_state.dart';

import '../../../../app/constants.dart';
import '../../../../app/functions.dart';
import '../../../../domain/model/category_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../bloc/category_bloc/category_bloc.dart';
import '../../bloc/category_bloc/category_event.dart';
import '../../bloc/category_bloc/category_state.dart';

class SlidingView extends StatefulWidget {
  GlobalKey<SliderDrawerState> sliderDrawerKey;
   SlidingView({super.key,required this.sliderDrawerKey});

  @override
  State<SlidingView> createState() => _SlidingViewState();
}

class _SlidingViewState extends State<SlidingView> {
  CategoriesBloc _categoriesBloc = instance<CategoriesBloc>();
  CategoryBloc _categoryBloc = instance<CategoryBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        bloc: _categoriesBloc..add(CategoriesFetched(Constants.headerValue)),
        builder: (context, state) {
          if(state is CategoriesLoading){
            return Container(
              alignment: AlignmentDirectional.center,
              child:    SizedBox(
                  height: 150.w,
                  width: 150.w,
                  child: Lottie.asset(ImageAssets.loadingView)),

            );
          }else if(state is CategoriesFailure){
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
          }else if(state is CategoriesSuccess){
            return BlocProvider.value(
              value: _categoryBloc,
  child: BlocBuilder<CategoryBloc, CategoryState>(
    builder: (context, categoryState) {
      return ListView(
        children: state.categoryModel.childrenData.map((category) {
          return _buildParentCategory(context, category, categoryState.expandedParentCategoryId);
        }).toList(),
      );
    },
  )
);
          }else{
            return Container();
          }

        },
      ),

    );
  }
  Widget _buildParentCategory(BuildContext context, CategoryModel categoryModel, int? expandedParentCategoryId) {
    List<CategoryModel> children = categoryModel.childrenData ?? [];
    bool isExpanded = expandedParentCategoryId == categoryModel.id;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: PageStorageKey<int>(categoryModel.id!), // Ensures ExpansionTile rebuilds correctly
        title: Text(categoryModel.name!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        leading: CachedNetworkImage(
          height: 30.w,
          width: 30.w,
          fit: BoxFit.fill,
          imageUrl: handleEndpointImage(categoryModel.image ?? ""),
          placeholder: (context, url) => SizedBox(
            height: 30,
            width: 30,
            child: LinearProgressIndicator(
              color: Colors.grey.shade200,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/image_not_found.png',
            height: 30.w,
            width: 30.w,
            fit: BoxFit.contain,
          ),
        ),
        initiallyExpanded: isExpanded, // Ensures only one parent expands
        onExpansionChanged: (bool expanded) {
          if(categoryModel.childrenData.isEmpty){

            if(children.isEmpty){
              if(widget.sliderDrawerKey.currentState!.isDrawerOpen){
                widget.sliderDrawerKey.currentState?.closeSlider();
              }
              Map<String, dynamic> map = {};
              map['categoryName'] = categoryModel.name;
              map['categoryId'] = categoryModel.id.toString();
              map['title']= categoryModel.name;
              Routes.pushAndRemoveUntilKeepingFirst( Routes.productsRoute,arguments: map);


            }

          }
          if (expanded) {
            _categoryBloc.add(ExpandParentCategory(categoryModel.id!));
          } else {
            _categoryBloc.add(ExpandParentCategory(-1)); // Collapse parent
          }
        },
        children: children.map((child) => _buildChildCategory(child)).toList(),
      ),
    );
  }

  /// Builds Child Categories (independent of the parent expansion)
  Widget _buildChildCategory(CategoryModel categoryModel) {
    List<CategoryModel> children = categoryModel.childrenData ?? [];

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: PageStorageKey<int>(categoryModel.id!), // Ensures state consistency
        title: Text(categoryModel.name!, style: TextStyle(fontSize: 16)),

        leading: categoryModel.image != null
            ? CachedNetworkImage(
          height: 25.w,
          width: 25.w,
          fit: BoxFit.fill,
          imageUrl: handleEndpointImage(categoryModel.image!),
        )
            : const Icon(Icons.category, size: 25),
        children: children.isNotEmpty
            ? children.map((child) => _buildChildCategory(child)).toList()
            : [Container()],
        onExpansionChanged: (bool isExpanded){
          if(categoryModel.childrenData.isEmpty){

              if(children.isEmpty){
                if(widget.sliderDrawerKey.currentState!.isDrawerOpen){
                  widget.sliderDrawerKey.currentState?.closeSlider();
                }
                Map<String, dynamic> map = {};
                map['categoryName'] = categoryModel.name;
                map['categoryId'] = categoryModel.id.toString();
                map['title']= categoryModel.name;

                Routes.pushAndRemoveUntilKeepingFirst( Routes.productsRoute,arguments: map);

              }

          }

        },


      ),
    );
  }
}

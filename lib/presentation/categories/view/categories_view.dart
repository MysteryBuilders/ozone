import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/categories/widget/grid_category_view.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_bloc.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_state.dart';

import '../../../app/constants.dart';
import '../../../domain/model/category_model.dart';
import '../../main/bloc/categories_bloc/categories_event.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_title.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  CategoriesBloc _categoriesBloc = instance<CategoriesBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.w,
        title: AppbarTitle(
          text: AppStrings.category.tr(),
        ),
        leading:

        InkWell(
          onTap: () {
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
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
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
              return Container(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,


                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                        childAspectRatio: 3 / 3),
                    // physics: BouncingScrollPhysics(),
                    itemCount: state.categoryModel.childrenData.length,
                    itemBuilder: (context, index) {
                      CategoryModel model =  state.categoryModel.childrenData[index];
                      return Container(
                          margin: EdgeInsets.all(5.w),
                          child: GridCategoryView(model));
                    }),
              );
            }else{
              return Container();

            }

          },
        ),
      ),
    );
  }
}

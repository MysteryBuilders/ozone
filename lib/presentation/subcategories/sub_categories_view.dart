
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/domain/model/category_model.dart';

import '../../app/functions.dart';
import '../categories/widget/grid_category_view.dart';
import '../main/view/widgets/gridticket1_item_widget.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/langauge_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../widgets/app_decoration.dart';
import '../widgets/appbar_iconbutton.dart';
import '../widgets/appbar_image_1.dart';
import '../widgets/appbar_title.dart';
import '../widgets/custom_app_bar.dart';

class SubCategoriesView extends StatefulWidget {
  CategoryModel? categoryModel;
   SubCategoriesView({super.key,required this.categoryModel});

  @override
  State<SubCategoriesView> createState() => _SubCategoriesViewState();
}

class _SubCategoriesViewState extends State<SubCategoriesView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
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
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.w,
            title: AppbarTitle(
              text: widget.categoryModel!.name!,
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
          body:    Container(
        margin: EdgeInsets.all(10.w),
        child:  GridView.builder(
            scrollDirection: Axis.vertical,


            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: 3 / 3),
            // physics: BouncingScrollPhysics(),
            itemCount: widget.categoryModel!.childrenData.length,
            itemBuilder: (context, index) {
              CategoryModel model =  widget.categoryModel!.childrenData[index];
              return Container(
                  margin: EdgeInsets.all(5.w),
                  child: GridCategoryView(model));
            }),
        ),

        ),
      ),
    );
  }
}

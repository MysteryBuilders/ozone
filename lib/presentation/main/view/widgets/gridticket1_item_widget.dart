import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/functions.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/presentation/resources/color_manager.dart';

import '../../../resources/common_image_view.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/app_decoration.dart';
import '../../../widgets/custom_icon_button.dart';

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Gridticket1ItemWidget extends StatelessWidget {
  Gridticket1ItemWidget(this.gridCategoryModelObj);

  CategoryModel gridCategoryModelObj;




  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: GestureDetector(
        onTap: (){
          if(gridCategoryModelObj.childrenData.isNotEmpty) {
            Map<String, dynamic> map = {};
            map['categoryModel'] =
                gridCategoryModelObj;
            map['tile']= gridCategoryModelObj.name;
            // Navigator.pushNamed(
            //     context, Routes.subCategoriesRoute,
            //     arguments: map);
            Routes.navigateTo( Routes.subCategoriesRoute,arguments: map);
          }
          else if(gridCategoryModelObj.productCount!>0){
            Map<String, dynamic> map = {};
            map['categoryName'] = gridCategoryModelObj.name;
            map['categoryId'] = gridCategoryModelObj.id.toString();
            map['tile']= gridCategoryModelObj.name;
            // Navigator.pushNamed(
            //     context, Routes.productsRoute,
            //     arguments: map);
            Routes.navigateTo( Routes.productsRoute,arguments: map);
          }
        },
        child: Container(
          width: double.infinity,
          decoration: AppDecoration.fillWhiteA700ab.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconButton(
                height: 50,
                width: 50,

                margin: EdgeInsets.only(left: 15.w,top: 15.h,right: 15.w),
                variant: IconButtonVariant.OutlineRed100,
                shape: IconButtonShape.CircleBorder25,
                child: CommonImageView(
                  url: handleEndpointImage(gridCategoryModelObj.image.toString()),
                ),
              ),
              Padding(

                padding: EdgeInsetsDirectional.only(start: 15.w,end: 15.w,top: 8.h),
                child: Text(
                 gridCategoryModelObj.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 2,

                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorManager.black,
                    fontSize: 12.sp,



                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(

                padding: EdgeInsetsDirectional.only(start: 15.w,end: 15.w,top: 3.h,bottom: 20.h),
                child: Text(
                  '${gridCategoryModelObj.productCount.toString()} ${AppStrings.product.tr()}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: ColorManager.gray401,
                    fontSize: 10.sp,

                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
     
     
     
      )
    );
  }


}

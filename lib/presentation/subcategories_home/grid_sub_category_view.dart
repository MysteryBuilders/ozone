import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/model/home_screen_model.dart';
import '../resources/color_manager.dart';
import '../resources/common_image_view.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';
import '../widgets/app_decoration.dart';
import '../widgets/custom_icon_button.dart';

class GridSubCategoryView extends StatelessWidget {
  GridSubCategoryView(this.categoryChildHome);

  CategoryChildHome categoryChildHome;




  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.centerStart,
        child: GestureDetector(
          onTap: (){

              Map<String, dynamic> map = {};
              map['categoryName'] = categoryChildHome.name;
              map['categoryId'] = categoryChildHome.categoryId.toString();
              map['title']= categoryChildHome.name;
              Routes.navigateTo( Routes.productsRoute,arguments: map);
              // Navigator.pushNamed(
              //     context, Routes.productsRoute,
              //     arguments: map);

          },
          child: Container(
            padding: EdgeInsets.all(10.w),
            width: double.infinity,
            height: 150.w,
            decoration: AppDecoration.fillWhiteA700ab.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(

                    width: 90.w,
                    height: 90.w,
                    child: Card(
                      elevation: AppSize.s1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                              color: ColorManager.primary.withOpacity(0.5),
                              width: AppSize.s1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          width: ScreenUtil().screenWidth,

                          fit: BoxFit.fill,
                          imageUrl: categoryChildHome.image!,
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                  width: ScreenUtil().screenWidth,


                                  decoration: BoxDecoration(


                                    image: DecorationImage(


                                        fit: BoxFit.fill,
                                        image: imageProvider),
                                  )
                              ),
                          placeholder: (context, url) => Container(
                            height: 90,
                            width: 90,
                            child: LinearProgressIndicator(
                              color: Colors.grey.shade200,
                              backgroundColor: Colors.grey.shade100,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/image_not_found.png",
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),

                        ),


                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h,),
                Expanded(
                  flex: 2,
                  child: Text(
                    categoryChildHome.name.toString(),
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

              ],
            ),
          ),



        )
    );
  }


}
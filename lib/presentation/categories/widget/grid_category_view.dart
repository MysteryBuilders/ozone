import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/functions.dart';
import 'package:ozon/domain/model/brands_model.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/presentation/resources/color_manager.dart';



import 'package:flutter/material.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';

import '../../resources/common_image_view.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/custom_icon_button.dart';


// ignore: must_be_immutable
class GridCategoryView extends StatelessWidget {
  GridCategoryView(this.categoryModel);

  CategoryModel categoryModel;




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.w),
      child: Align(

          alignment: AlignmentDirectional.centerStart,
          child: InkWell(
              onTap: (){
                if(categoryModel.childrenData.isEmpty){
                  Map<String, dynamic> map = {};
                  map['categoryName'] = categoryModel.name;
                  map['categoryId'] = categoryModel.id.toString();
                  map['title']= categoryModel.name;

                  Navigator.pushNamed(context, Routes.productsRoute,arguments: map);


                }else{
                  Map<String,dynamic> map = {};
                  map['categoryModel']= categoryModel;
                  Navigator.pushNamed(context, Routes.subCategoriesRoute,arguments: map);

                }

              },
              child: Container(


                width: ScreenUtil().screenWidth,
                child: Column(
                  children: [

                    Expanded(flex:4,child: Container(
                      child:
                      Container(
                        alignment: AlignmentDirectional.center,

                        child: CachedNetworkImage(
                          width:ScreenUtil().screenWidth,
                          height: ScreenUtil().screenHeight,


                          imageUrl:handleEndpointImage(categoryModel.image!),
                          imageBuilder: (context, imageProvider) => Container(



                              decoration: BoxDecoration(



                                image: DecorationImage(



                                    image: imageProvider),
                              )
                          ),
                          placeholder: (context, url) =>
                              Container(
                                height: 30,
                                width: 30,
                                child: LinearProgressIndicator(
                                  color: Colors.grey.shade200,
                                  backgroundColor: Colors.grey.shade100,
                                ),
                              ),


                          errorWidget: (context, url, error) =>
                              SizedBox(
                                width:ScreenUtil().screenWidth,
                                height: ScreenUtil().screenHeight,
                                child: Image.asset(
                                  'assets/images/image_not_found.png',
                                  height: 30.w,
                                  width: 30.w,

                                ),
                              ),

                        ),
                      ),
                    )),
                    Container(height: 10.w,),
                    Expanded(flex:2,
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 10.w),
                            child: Text(categoryModel.name.toString(),
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: ColorManager.mainBlack,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal
                              ),),
                          ),

                        )),
                    Expanded(flex:1,
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 10.w),
                            child: Text('${categoryModel.productCount.toString()} ${AppStrings.product.tr()}',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: ColorManager.secondaryBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal
                              ),),
                          ),

                        ))
                  ],
                ),

              )



          )
      ),
    );
  }


}

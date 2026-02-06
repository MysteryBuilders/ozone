import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/domain/model/my_orders_model.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/strings_manager.dart';

class CartItemOrderWidget extends StatelessWidget {
  final ProductMyItemModel productMyItemModel;
  final String currency;
  const CartItemOrderWidget({super.key,required this.productMyItemModel,required this.currency});

  @override
  Widget build(BuildContext context) {
    print("image ---> ${productMyItemModel.imageExtension.product_image}");
    return Container(
      height: 120.h,
      width: ScreenUtil().screenWidth,
      // padding: getPadding(
      //   top: 20.0,
      //   bottom: 20.0,
      // ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 84.w,
            width: 84.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: CommonImageView(
                    svgPath: ImageAssets.imgForward,
                    height: 84.w,
                    width: 84.w,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(

                    // padding: getPadding(
                    //   left: 14,
                    //   top: 11,
                    //   right: 14,
                    //   bottom: 9,
                    // ),
                    padding: EdgeInsetsDirectional.only(
                        start: 14.w,
                        top:11.h,
                        end: 14.w,
                        bottom: 9.h

                    ),
                    child: CommonImageView(
                      url:productMyItemModel.imageExtension.product_image,
                      height: 63.h,
                      width: 63.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: ScreenUtil().screenWidth,
              margin: EdgeInsets.all(10.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: ScreenUtil().screenWidth,

                    margin: EdgeInsetsDirectional.only(top: 4.h),
                    child: Text(
                      productMyItemModel.name!,
                      maxLines: null,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorManager.black,
                        fontSize: 14.sp,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: ScreenUtil().screenWidth,
                    margin:EdgeInsets.only(top: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          // padding: getPadding(
                          //   top: 1,
                          //   bottom: 2,
                          // ),
                          padding: EdgeInsets.only(top: 1.h,bottom: 2.h),
                          child: Row(
                            children: [
                              Text(' ${currency} ${productMyItemModel.base_row_total.toString()}'
                                ,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,

                                style:productMyItemModel.discount_amount ==0?
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: ColorManager.amber900,

                                  fontSize:14.sp,
                                  decorationThickness: 1.0,


                                  fontWeight: FontWeight.w500,
                                )
                                    :
                                Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  // color: ColorManager.amber900,
                                  color: ColorManager.black,
                                  fontSize:10.sp,
                                  decoration: TextDecoration.lineThrough,  // Adds strikethrough
                                  decorationColor: Colors.red,             // Optional: Set color of the line
                                  decorationThickness: 10.w,

                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 5.w,),
                              Container(
                                child: productMyItemModel.discount_amount ==0?
                                Container():
                                Text(
                                  ' ${currency} ${(productMyItemModel.base_row_total!-productMyItemModel.discount_amount!).toStringAsFixed(3)}',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorManager.amber900,
                                    fontSize:14.sp,

                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                                child: Container(
                                  alignment: Alignment.center,

                                  child: Text("${AppStrings.quantity.tr()} ${productMyItemModel.qty_ordered.toString()}",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: ColorManager.black900,
                                        fontSize: 16.sp,

                                        fontWeight: FontWeight.w500,
                                      )),
                                )),



                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
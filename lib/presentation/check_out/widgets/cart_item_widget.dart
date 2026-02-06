import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/domain/model/check_out_model.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../domain/model/order_model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';

class CartItemWidget extends StatelessWidget {
  final CheckOutItemModel cartListItem;
  final String currency;
  const CartItemWidget({super.key,required this.cartListItem,required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.w,
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
            alignment: AlignmentDirectional.center,
            child: CachedNetworkImage(
              width:100.w,
              height: 100.w,


              imageUrl:cartListItem.extenstionAttibutesModel!.image_url!,
              imageBuilder: (context, imageProvider) => Container(
                  width: ScreenUtil().screenWidth,


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
                    width: 30.w,
                    height: 30.w,
                    child: Image.asset(
                      'assets/images/image_not_found.png',
                      height: 30.w,
                      width: 30.w,

                    ),
                  ),

            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: ScreenUtil().screenWidth,
              margin: EdgeInsets.all(5.w),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Expanded(
                    flex:2,
                    child: Container(
                      width: ScreenUtil().screenWidth,
                      child: Container(
                        alignment: AlignmentDirectional.centerStart,


                        child: Text(
                          cartListItem.name!,
                          maxLines: null,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorManager.mainBlack,
                            fontSize: 14.sp,

                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(


                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight,
                      alignment: AlignmentDirectional.centerStart,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Text(
                            '${cartListItem.price.toString()} ${AppStrings.kd.tr()}',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: ColorManager.primary,
                              fontSize:14.sp,

                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        ],
                      ),
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

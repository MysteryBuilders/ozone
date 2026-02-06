import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/domain/model/my_orders_model.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../../app/constants.dart';
import '../../../products/view/widgets/order_status.dart';
import '../../../resources/common_image_view.dart';
import '../../../resources/langauge_manager.dart';
import '../../../widgets/app_decoration.dart';

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Listforward1ItemWidget extends StatelessWidget {
  Listforward1ItemWidget(this.myOrdersHistoryListItem,
      {this.onTapImgOverflowmenu,
   
      });

  MyItemModel myOrdersHistoryListItem;



  VoidCallback? onTapImgOverflowmenu;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 84.w,


      child: Row(

        children: [
         Container(
           width: 84.w,
           height: 84.w,
           child: CachedNetworkImage(
             width:84.w,
             height: 84.w,

             fit: BoxFit.fill,
             imageUrl:myOrdersHistoryListItem.products[0].imageExtension.product_image,
             imageBuilder: (context, imageProvider) => Container(
                 width: ScreenUtil().screenWidth,


                 decoration: BoxDecoration(



                   image: DecorationImage(


                       fit: BoxFit.fill,
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
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenUtil().screenHeight,
                    margin: EdgeInsets.symmetric(vertical: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex:1,
                          child: Row(
                            children: [
                              Text('${limitWithEllipsis(myOrdersHistoryListItem.products[0].name)}',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp
                              ),),Container(
                                child: myOrdersHistoryListItem.products.length>1?
                                Text('+${myOrdersHistoryListItem.products.length-1}',
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: Color(0xFF000000),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp
                                  ),):SizedBox.shrink()
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('${AppStrings.quantity.tr()} ${myOrdersHistoryListItem.total_qty_ordered}',
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.secondaryBlack,
                            fontWeight: FontWeight.normal,
                            fontSize: 12.sp
                          ),),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(' ${myOrdersHistoryListItem.base_grand_total} ${AppStrings.kd.tr()}',
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.mainBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp
                            ),),
                        ),
                      ],
                    ),

                  ),
                ),
                // Container(
                //   alignment: AlignmentDirectional.bottomCenter,
                //   child:generateText(myOrdersHistoryListItem.state) ==""?Container():
                //   InkWell(
                //     onTap: (){
                //       Map<String,dynamic> map ={};
                //       map['myItemModel']= myOrdersHistoryListItem;
                //       Navigator.pushNamed(context, Routes.leaveReviewRoute,arguments: map);
                //     },
                //     child: Container(
                //       width: 80.w,
                //       height: 30.w,
                //       alignment: AlignmentDirectional.center,
                //       decoration: BoxDecoration(
                //         color: ColorManager.primary,
                //         borderRadius: BorderRadius.circular(15.w),
                //       ),
                //       child: Text(generateText(myOrdersHistoryListItem.state),
                //         textAlign: TextAlign.center,style: Theme.of(context).textTheme.displayMedium!.copyWith(
                //         color: ColorManager.white,
                //         fontSize: 12.sp,
                //         fontWeight: FontWeight.w500
                //       ),),
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getReadableOrderStatus(String status) {
    Map statusMap = {
      'pending':  '${AppStrings.pending.tr()}',
      'pending_payment': AppStrings.pendingPayment.tr(),
      'processing': AppStrings.processing.tr(),
      'complete': AppStrings.compeletedOrders.tr(),
      'closed': AppStrings.closed.tr(),
      'canceled': AppStrings.cancel.tr(),
      'holded': AppStrings.holded.tr(),
      'payment_review': AppStrings.payment_review.tr(),
      'fraud': AppStrings.fraud.tr(),
    };

    return statusMap[status] ?? 'Unknown Status';
  }


  Color getStatusColor(String status) {
    switch (status) {
      case 'pending':
      case 'pending_payment':
        return Colors.orangeAccent; // Waiting for action
      case 'processing':
        return Colors.blue; // In progress
      case 'complete':
        return Colors.green; // Success
      case 'closed':
        return Colors.grey; // Archived
      case 'canceled':
        return Colors.redAccent; // Cancelled
      case 'holded':
        return Colors.deepPurple; // On hold
      case 'payment_review':
        return Colors.amber; // Awaiting verification
      case 'fraud':
        return Colors.black87; // Danger / Fraud
      default:
        return Colors.grey; // Unknown
    }
  }


  String generateText(String status ) {

    if(status=="pending_payment")
    return AppStrings.payNow.tr();
    else if(status=="pending")
      return AppStrings.pending.tr();
    else if (status == "complete")
      return AppStrings.leaveReview.tr();
    else if (status == "closed")
      return AppStrings.re_order.tr();
    else if (status == "canceled")
      return AppStrings.re_order.tr();
    else if (status == "holded")
      return "";
    else if (status == "payment_review")
      return "";
    else return "";

  }
  String getDate(String date,BuildContext context){
    DateTime parsedDate = DateTime.parse(date);

    // Convert to desired format
    String formattedDate = DateFormat("d MMM  hh:mm a",isRtl(context)?"ar":"en").format(parsedDate);
    return formattedDate;

  }
  bool isRtl(BuildContext context) {
    return context.locale == ARABIC_LOCAL;
  }
  String limitWithEllipsis(String text, {int maxLength = 10}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }


}

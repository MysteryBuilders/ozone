
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/order_details/bloc/check_status_bloc.dart';
import 'package:ozon/presentation/order_details/bloc/time_line_order_bloc/time_line_bloc.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';

import '../../../app/user_prefrences.dart';
import '../../../domain/model/my_orders_model.dart';
import '../../../domain/model/status_model.dart';
import '../../check_out/widgets/cart_item_widget.dart';
import '../../check_out/widgets/forward_arrow.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../widget/cart_item_order_widget.dart';

class OrderDetailsView extends StatefulWidget {
  final MyItemModel myItemModel;
  const OrderDetailsView({super.key,required this.myItemModel});

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final TextEditingController _voucherController = TextEditingController();
  CheckStatusBloc _checkStatusBloc = instance<CheckStatusBloc>();
  TimeLineBloc _timeLineBloc = instance<TimeLineBloc>();
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();

  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  String getFirstTwoConcatenated(String text) {
    final words = text.split(' ');
    final first = words.isNotEmpty ? words[0] : '';
    final second = words.length > 1 ? words[1] : '';
    return '$first $second';
  }
  List<int> dangerIndexes = [3, 4, 5];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _voucherController.text = widget.myItemModel.coupon_code;
    print("id ---> ${widget.myItemModel.entity_id}");
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
              text: AppStrings.trackOrder.tr(),
            ),
            leading:

            InkWell(
              onTap: (){
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

          body: BlocBuilder<TimeLineBloc, TimeLineState>(
            bloc: _timeLineBloc..add(TimeLineFetched( Constants.headerValue,widget.myItemModel.products[0].order_id.toString())),
  builder: (context, timeLineState) {
              if(timeLineState is TimeLineLoading){
                return Container(
                  alignment: AlignmentDirectional.center,
                  child:    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              }else if(timeLineState is TimeLineFailure){
                return Container(
                  color: Colors.white,
                  alignment: AlignmentDirectional.center,
                  child: Text(timeLineState.message,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.w500

                    ),),
                );

              }else if(timeLineState is TimeLineSuccess){
                print("timeLineState --> ${timeLineState.timeLine.timeline.length}");;
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppStrings.orderList.tr(),
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.mainBlack,
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10.w,),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),

                            itemBuilder: (context,index){

                              return InkWell(
                                onTap: (){
                                  Map<String,dynamic> map ={};
                                  map['myItemModel']= widget.myItemModel.products[index];
                                  Navigator.pushNamed(context, Routes.leaveReviewRoute,arguments: map);
                                },
                                child: Container(
                                  width: ScreenUtil().screenWidth,
                                  height: 84.w,


                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Row(

                                          children: [
                                            Container(
                                              width: 84.w,
                                              height: 84.w,
                                              child: CachedNetworkImage(
                                                width:84.w,
                                                height: 84.w,

                                                fit: BoxFit.fill,
                                                imageUrl:widget.myItemModel.products[index].imageExtension.product_image,
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
                                                            flex:2,
                                                            child: Text('${widget.myItemModel.products[index].name}',
                                                              maxLines: 3,

                                                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                                  color: ColorManager.mainBlack,
                                                                  fontWeight: FontWeight.normal,
                                                                  fontSize: 12.sp
                                                              ),),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text('${AppStrings.quantity.tr()} ${widget.myItemModel.products[index].qty_ordered}',
                                                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                                  color: ColorManager.secondaryBlack,
                                                                  fontWeight: FontWeight.normal,
                                                                  fontSize: 12.sp
                                                              ),),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Row(
                                                              children: [
                                                                Text(' ${widget.myItemModel.products[index].base_row_total.toString()} ${AppStrings.kd.tr()}'
                                                                  ,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  textAlign: TextAlign.start,

                                                                  style:widget.myItemModel.products[index].discount_amount ==0?
                                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                    color: ColorManager.primary,

                                                                    fontSize:14.sp,
                                                                    decorationThickness: 1.0,


                                                                    fontWeight: FontWeight.w500,
                                                                  )
                                                                      :
                                                                  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                    // color: ColorManager.amber900,
                                                                    color: ColorManager.mainBlack,
                                                                    fontSize:14.sp,
                                                                    decoration: TextDecoration.lineThrough,  // Adds strikethrough
                                                                    decorationColor: Colors.red,             // Optional: Set color of the line
                                                                    decorationThickness: 10.w,

                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                                SizedBox(width: 5.w,),
                                                                Container(
                                                                  child: widget.myItemModel.products[index].discount_amount ==0?
                                                                  Container():
                                                                  Text(
                                                                    ' ${(widget.myItemModel.products[index].base_row_total!-widget.myItemModel.products[index].discount_amount!).toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                                                                    overflow: TextOverflow.ellipsis,
                                                                    textAlign: TextAlign.start,
                                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                      color: ColorManager.primary,
                                                                      fontSize:14.sp,

                                                                      fontWeight: FontWeight.w500,
                                                                    ),
                                                                  ),
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
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned.directional(textDirection: Directionality.of(context),
                                          top: 0,
                                          bottom:0,
                                          end :20.w,

                                          child: InkWell(
                                            onTap :(){

                                            },

                                            child: Icon(Icons.star,
                                              size: 30.w,

                                              color: Colors.amberAccent,),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }, separatorBuilder: (context,index){
                          return Container(height: 10.w,);

                        }, itemCount: widget.myItemModel.products.length),
                        SizedBox(height: 20.w,),
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 0.5,
                          color: ColorManager.seperatorColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.orderDetails.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.mainBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500

                                ),),
                              SizedBox(height: 20.w,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppStrings.deliveryDate.tr(),
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: 14.sp,
                                        fontWeight:FontWeight.normal

                                    ),),
                                  Text(widget.myItemModel.updated_at,
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.mainBlack,
                                        fontSize: 14.sp,
                                        fontWeight:FontWeight.w500

                                    ),)


                                ],
                              ),
                              SizedBox(height: 10.w,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppStrings.trackOrder.tr(),
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: 14.sp,
                                        fontWeight:FontWeight.normal

                                    ),),
                                  Text(widget.myItemModel.quote_id.toString(),
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.mainBlack,
                                        fontSize: 14.sp,
                                        fontWeight:FontWeight.w500

                                    ),)


                                ],
                              ),


                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 0.5,
                          color: ColorManager.seperatorColor,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.orderStatus.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.mainBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500

                                ),),
                              SizedBox(height: 20.w,),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:timeLineState.timeLine.timeline.length,
                                itemBuilder: (context, index) {
                                  final isDangerIndex = dangerIndexes.contains(index);
                                  final isChecked = timeLineState.timeLine.timeline[index].reached;
                                  final isNextChecked = index < timeLineState.timeLine.timeline.length - 1
                                      ? timeLineState.timeLine.timeline[index + 1].reached
                                      : false;

                                  final Color lineTopColor = index == 0
                                      ? Colors.transparent
                                      : isChecked!
                                      ? ColorManager.primary
                                      : ColorManager.gray300;

                                  final Color circleColor = isDangerIndex && isChecked!
                                      ? ColorManager.redA700
                                      : isChecked!
                                      ? ColorManager.primary
                                      : ColorManager.gray300;

                                  final Color lineBottomColor = (index == timeLineState.timeLine.timeline.length - 1)
                                      ? Colors.transparent
                                      : isNextChecked!
                                      ? ColorManager.primary
                                      : ColorManager.gray300;

                                  final IconData iconData = isDangerIndex && isChecked
                                      ? Icons.close
                                      : Icons.check;

                                  return Container(
                                    height: 60.w,
                                    width: ScreenUtil().screenWidth,
                                    child: Row(
                                      children: [
                                        /// LEFT side - line + circle
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 10.w,
                                                width: 4.w,
                                                color: lineTopColor,
                                              ),
                                              Container(
                                                width: 20.w,
                                                height: 20.w,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: circleColor,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  iconData,
                                                  color: ColorManager.white,
                                                  size: 15.w,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 4.w,
                                                  color: lineBottomColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        /// RIGHT side - status text
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            alignment: AlignmentDirectional.topStart,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5.w),
                                                Text(
                                                  timeLineState.timeLine.timeline[index].status!,
                                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],

                          ),
                        ),
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 0.5,
                          color: ColorManager.seperatorColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.clientDetails.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.mainBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500

                                ),),
                              Container(
                                margin: EdgeInsets.all(20.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppStrings.ordererName.tr(),
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.mainBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w500,



                                      ),),
                                    SizedBox(height: 10.w,),
                                    Text('${widget.myItemModel.extenstionAttributesOrderResponse.shippingAssignmentList![0].shippingOrderResponse!.shippingOrderAddressResponse!.firstname} ${widget.myItemModel.extenstionAttributesOrderResponse.shippingAssignmentList![0].shippingOrderResponse!.shippingOrderAddressResponse!.lastname}',

                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal,



                                      ),),
                                    SizedBox(height: 20.w,),
                                    Text(AppStrings.phone.tr(),
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.mainBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w500,



                                      ),),
                                    SizedBox(height: 10.w,),
                                    Text( widget.myItemModel.extenstionAttributesOrderResponse.shippingAssignmentList![0].shippingOrderResponse!.shippingOrderAddressResponse!.telephone!,
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal,



                                      ),),
                                    SizedBox(height: 20.w,),
                                    Text(AppStrings.shippingAddress.tr(),
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.mainBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.w500,



                                      ),),
                                    SizedBox(height: 10.w,),
                                    Text('${widget.myItemModel.extenstionAttributesOrderResponse.shippingAssignmentList![0].shippingOrderResponse!.shippingOrderAddressResponse!.street![0]} \n'
                                        '${widget.myItemModel.extenstionAttributesOrderResponse.shippingAssignmentList![0].shippingOrderResponse!.shippingOrderAddressResponse!.region} ,${widget.myItemModel.extenstionAttributesOrderResponse.shippingAssignmentList![0].shippingOrderResponse!.shippingOrderAddressResponse!.country_id} ${widget.myItemModel.extenstionAttributesOrderResponse.shippingAssignmentList![0].shippingOrderResponse!.shippingOrderAddressResponse!.postcode}',
                                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                        color: ColorManager.secondaryBlack,
                                        fontSize: ScreenUtil().setSp(12),
                                        fontWeight: FontWeight.normal,



                                      ),),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),


                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 0.5,
                          color: ColorManager.seperatorColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.paymentMethod.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.mainBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500

                                ),),

                              Container(
                                margin: EdgeInsets.all(20.w),

                                child: Text( getFirstTwoConcatenated(widget.myItemModel.extenstionAttributesOrderResponse.paymentAdditionalList![0].value!) ,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.secondaryBlack,
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.normal,



                                  ),),
                              ),


                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 0.5,
                          color: ColorManager.seperatorColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.shippingMethods.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.mainBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500

                                ),),

                              Container(
                                margin: EdgeInsets.all(20.w),
                                child: Text( widget.myItemModel.shipping_description ,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.secondaryBlack,
                                    fontSize: ScreenUtil().setSp(12),
                                    fontWeight: FontWeight.normal,



                                  ),),
                              ),


                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 0.5,
                          color: ColorManager.seperatorColor,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 30.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.priceDetails.tr(),
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.mainBlack,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500

                                ),),
                              Container(
                                margin: EdgeInsets.all(20.w),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(AppStrings.subtotal.tr(),
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,

                                          ),),
                                        Text('${widget.myItemModel.subtotal} ${AppStrings.kd.tr()}',
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,

                                          ),)
                                      ],
                                    ),
                                    SizedBox(height: 10.w,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(AppStrings.shippingCost.tr(),
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,

                                          ),),
                                        Text('${widget.myItemModel.base_shipping_amount} ${AppStrings.kd.tr()}',
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,

                                          ),)
                                      ],
                                    ),
                                    SizedBox(height: 10.w,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(AppStrings.voucher.tr(),
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,

                                          ),),
                                        Text('${widget.myItemModel.discount_amount} ${AppStrings.kd.tr()}',
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.normal,

                                          ),)
                                      ],
                                    ),
                                    SizedBox(height: 10.w,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Text(AppStrings.total.tr(),
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.secondaryBlack,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.w500,

                                          ),),
                                        Text('${widget.myItemModel.grand_total} ${AppStrings.kd.tr()}',
                                          maxLines: 1,
                                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                            color: ColorManager.black,
                                            fontSize: ScreenUtil().setSp(14),
                                            fontWeight: FontWeight.normal,

                                          ),)
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )

                      ],

                    ),

                  ),
                );
              }else{
                return Container();
              }


  },
),
        ),
      ),
    );
  }
}

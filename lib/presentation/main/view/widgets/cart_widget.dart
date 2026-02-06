import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/order_model.dart';
import 'package:ozon/presentation/main/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_local/cart_local_bloc.dart';
import 'package:ozon/presentation/main/bloc/check_cart/check_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/delete_item_cart/delete_item_cart_bloc.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../../app/user_prefrences.dart';
import '../../../resources/common_image_view.dart';

import 'package:flutter/material.dart';

import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';


// ignore: must_be_immutable
class CartWidget extends StatefulWidget {

  CartWidget(this.cartListItem,{required this.index,required this.currency,required this.checkCartBloc});
  OrderItemModel cartListItem;
  String currency;
  int index;
  CheckCartBloc checkCartBloc;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget>with SingleTickerProviderStateMixin {
final DeleteItemCartBloc deleteItemCartBloc = instance<DeleteItemCartBloc>();
SlidableController? slidableController ;
final AddToCartBloc addToCartBloc = instance<AddToCartBloc>();

  final AddToCartBloc add2ToCartBloc = instance<AddToCartBloc>();

     // CartLocalBloc cartLocalBloc;
 final UserPreferences userPreferences = GetIt.I<UserPreferences>();
@override
void initState() {
  slidableController = SlidableController(this);
  // TODO: implement initState
  super.initState();
  // _triggerSlideEffect();
}
@override
void dispose() {
  slidableController!.dispose();
  super.dispose();
}
void _triggerSlideEffect() {
  Future.delayed(Duration(milliseconds: 500), () {
    if (mounted) slidableController!.openStartActionPane();
  });

  Future.delayed(Duration(milliseconds: 1500), () {
    if (mounted) slidableController!.openEndActionPane();
  });

  Future.delayed(Duration(milliseconds: 2500), () {
    if (mounted) slidableController!.close();
  });
}
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Slidable(
          controller: slidableController,

          key:  ValueKey(widget.cartListItem),

          endActionPane: ActionPane(
              dragDismissible: true,
              extentRatio: 0.2,
              motion: BehindMotion(), children: [
            InkWell(
              onTap: (){
                Slidable.of(context)?.close();
                String userLoginToken = userPreferences.userToken!;
                _showDeleteBottomSheet(context,widget.cartListItem,userLoginToken);

                // _showDeleteBottomSheet(context,widget.cartDetailsItemModel);
              },
              child: Container(
                width: 0.2*ScreenUtil().screenWidth-10.w,
                color: Color(0xFFfbd8d9),
                child: Center(
                  child: Icon(Icons.delete,color: Colors.red,
                    size: 30.w,),
                ),
              ),
            ),
          ]),
          startActionPane: ActionPane(
              dragDismissible: true,
              extentRatio: 0.2,
              motion: BehindMotion(), children: [
            InkWell(
              onTap: (){
                Slidable.of(context)?.close();
                Map<String,dynamic> map ={};
                map['productId']= widget.cartListItem.itemId.toString();
                Navigator.pushNamed(context, Routes.productDetailsHomeRoute,arguments: map);
              },
              child: Container(
                width: 0.2*ScreenUtil().screenWidth-10.w,
                color: ColorManager.primary22,
                child: Center(
                  child: Icon(Icons.remove_red_eye,color: Colors.white,
                    size: 30.w,),
                ),
              ),
            ),
          ]),
        child: Container(
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


                  imageUrl:widget.cartListItem.extensionAttirbuteImage!.imageUrl,
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
                              widget.cartListItem.name!,
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
                                '${widget.cartListItem.price.toString()} ${AppStrings.kd.tr()}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: ColorManager.primary,
                                  fontSize:14.sp,

                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  BlocListener<AddToCartBloc, AddToCartState>(
                                    bloc: addToCartBloc,
                                            listener: (context, state) {
                        if(state is AddToCartLoading){
                          showLoadingDialog(context);
                        }else if(state is AddToCartFailure){
                          // Navigator.pop(context);
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }else if(state is AddToCartSuccess){
                          // Navigator.pop(context);
                          Navigator.pop(context);
                          // cartListItem.qty = state.addToCartModel.qty;
                          GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));
                          widget.checkCartBloc.add(CheckCartFetched(userPreferences.userToken!));

                          // cartLocalBloc.add(DecreaseCartLocalItem(cartListItem));
                        }
                                            },
                                            child: Container(
                                      // margin: getMargin(
                                      //     left: 11, bottom: 2),
                                    margin: EdgeInsetsDirectional.only(start: 11.w,end: 2.h),
                                      child: Container(
                                        height: 24.w,
                                        width: 24.w,
                                        child:   InkWell(
                                          onTap: (){
                                            if(widget.cartListItem.qty!>1) {
                                              print("minus");
                                              String userLoginToken = userPreferences
                                                  .userToken!;
                                              Map<String, dynamic> cartMap = {};
                                              cartMap['item_id'] =
                                                  widget.cartListItem.itemId;
                                              cartMap['qty'] = widget.cartListItem.qty! - 1;
                                              cartMap['quote_id'] =
                                              widget.cartListItem.quoteId!;
                                              Map<String, dynamic> map = {};
                                              map['cartItem'] = cartMap;
                                              addToCartBloc.add(AddToCartFetched(
                                                  userLoginToken, map));
                                            }
                                            // controller.changeCounter(isAdd: false,index: index);
                                          },
                                          child: CommonImageView(
                                            imagePath:ImageAssets.add ,
                                            height: 24.w,
                                            width: 24.w,
                                          ),
                                        ),

                                      )
                                  ),
                                          ),
                                  Padding(
                                      padding: EdgeInsets.only(bottom: 1.h),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        child: Text(widget.cartListItem.qty.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: ColorManager.black900,
                                              fontSize: 16.sp,

                                              fontWeight: FontWeight.w500,
                                            )),
                                      )),
                                  Container(
                                      margin:EdgeInsets.only(bottom: 2.h),
                                      child: BlocListener<AddToCartBloc, AddToCartState>(
                                        bloc: add2ToCartBloc,
                                            listener: (context, state) {
                        if(state is AddToCartLoading){
                          showLoadingDialog(context);
                        }else if(state is AddToCartFailure){
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }else if(state is AddToCartSuccess){
                          Navigator.pop(context);
                          print("plus");
                          widget.cartListItem.qty = state.addToCartModel.qty;
                          GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));
                          widget.checkCartBloc.add(CheckCartFetched(userPreferences.userToken!));

                          // cartLocalBloc.add(AddCartLocalItem(cartListItem));
                        }
                                            },
                                            child: Container(
                                        height: 24.w,
                                        width: 24.w,
                                        child:   InkWell(
                                          onTap: (){
                                            print("plus");
                                            String userLoginToken = userPreferences.userToken!;
                                            Map<String,dynamic> cartMap ={};
                                            cartMap['item_id'] = widget.cartListItem.itemId;
                                            cartMap['qty'] = widget.cartListItem.qty!+1;
                                            cartMap['quote_id'] = widget.cartListItem.quoteId!;
                                            Map<String,dynamic> map ={};
                                            map['cartItem'] = cartMap;
                                            add2ToCartBloc.add(AddToCartFetched(userLoginToken,map));

                                          },
                                          child: CommonImageView(
                                            imagePath:ImageAssets.add2 ,
                                            height: 24.w,
                                            width: 24.w,
                                          ),
                                        ),

                                      ),
                                          )
                                  ),


                                ],
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
        ),
            ),
      );
  }

  void dismissDeleteDialog(BuildContext dialogContext) {
    if (Navigator.canPop(dialogContext)) {
      Navigator.of(dialogContext).pop(); // Dismiss only the dialog
    } else {
      print("No dialog to dismiss!");
    }
  }

  Future<void> _showDeleteCartDialog(BuildContext context,int id,String authorization) async {
    final navigatorState = Routes.getCurrentNavigatorState();
    if (navigatorState != null) {
      return showDialog<void>(
        context: navigatorState.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return

            BlocListener<DeleteItemCartBloc, DeleteItemCartState>(
              bloc: deleteItemCartBloc,
              listener: (context, state) {

                if(state is DeleteItemCartLoading){
                  showLoadingDialog(context);
                }else if(state is DeleteItemCartFailure){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }else if(state is DeleteItemCartSuccess){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  print("minus");
                  GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));
                  widget.checkCartBloc.add(CheckCartFetched(userPreferences.userToken!));
                  // GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));

                  // cartLocalBloc.add(RemoveCartLocalItem(cartListItem));
                }
              },
              child: AlertDialog(

                content: Container(
                  height: 50.h,
                  alignment: AlignmentDirectional.center,
                  child: Text(AppStrings.deleteCart.tr(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,

                    ),),
                ),
                actions: <Widget>[
                  TextButton(
                    child:  Text(AppStrings.yes.tr(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Color(0xFF5CB852),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(18),

                      ),),
                    onPressed: () {
                      deleteItemCartBloc.add(DeleteItemCartButtonPressed(itemId: id, authorization: authorization));

                    },
                  ),
                  TextButton(
                    child:  Text(AppStrings.no.tr(),
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Color(0xFFDB3562),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(18),

                      ),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
        },
      );
    }

  }

void _showDeleteBottomSheet(BuildContext context,OrderItemModel cartDetailsItemModel,String authorization){
  CartBloc cartBloc = instance<CartBloc>();

  UserPreferences userPreferences = GetIt.I<UserPreferences>();
  showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Important for wrap content behavior
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(

        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context){
        return Wrap(
          children: [
            Container(height: 70.w,
              width: ScreenUtil().screenWidth,
              alignment: Alignment.center,

              child: Text(AppStrings.removeFromCart.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.normal
                ),),),
            Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),
            Container(
              height: 120.w,

              margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
              child: Row(
                children: [
                  Container(
                    child:  Container(
                      alignment: AlignmentDirectional.center,
                      child: CachedNetworkImage(
                        width:100.w,
                        height: 100.w,


                        imageUrl:cartDetailsItemModel.extensionAttirbuteImage!.imageUrl,
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
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(flex:1,child: Container(
                    height: 90.w,
                    child: Column(
                      children: [
                        Expanded(flex:2,child: Container(
                          alignment: AlignmentDirectional.topStart,
                          child: Row(
                            children: [
                              Expanded(
                                flex:3,
                                child: Text(cartDetailsItemModel.name!,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: Colors.black,

                                      fontWeight: FontWeight.normal,
                                      fontSize: ScreenUtil().setSp(12)
                                  ),),
                              ),

                            ],
                          ),
                        )),
                        Expanded(flex:2,child: Container(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.centerStart,
                                child:
                                Text('${cartDetailsItemModel.price!} ${AppStrings.kd.tr()}',
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: ColorManager.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(12)
                                  ),)

                              )

                            ],
                          ),
                        )),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            SizedBox(height: 20.w,),
            Container(height: 40.w,
              width: ScreenUtil().screenWidth,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(flex:1,child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      color: ColorManager.gray300,
                      height: ScreenUtil().screenHeight,
                      child: Text(AppStrings.cancelString.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.primary,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal
                        ),),
                    ),
                  )),
                  SizedBox(width: 20.w,),
                  Expanded(flex:1,child: InkWell(
                    onTap: (){
                      deleteItemCartBloc.add(DeleteItemCartButtonPressed(itemId: cartDetailsItemModel.itemId!, authorization: authorization));

                    },
                    child:
                    BlocListener<DeleteItemCartBloc, DeleteItemCartState>(
                      bloc: deleteItemCartBloc,
                      listener: (context, state) {

                        if(state is DeleteItemCartLoading){
                          showLoadingDialog(context);
                        }else if(state is DeleteItemCartFailure){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }else if(state is DeleteItemCartSuccess){
                          Navigator.pop(context);
                          Navigator.pop(context);
                          print("minus");
                          GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));
                          widget.checkCartBloc.add(CheckCartFetched(userPreferences.userToken!));
                          // GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));

                          // cartLocalBloc.add(RemoveCartLocalItem(cartListItem));
                        }
                      },
                      child: Container(
                        color: ColorManager.primary,
                        alignment: AlignmentDirectional.center,
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.yesRemove.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal
                          ),),
                      ),
                    ),
                  )),


                ],
              ),),
            Container(height: 30.w,
              color: Color(0x00000000),)


          ],
        );
      }
  );

}
}

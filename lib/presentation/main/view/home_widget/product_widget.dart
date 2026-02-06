import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/domain/model/order_model.dart' as OrderModel;
import 'package:ozon/domain/model/product_model.dart';
import 'package:ozon/presentation/main/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/check_cart/check_cart_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/stock_info_bloc.dart';
import 'package:ozon/presentation/product_details_home_view/view/product_details_home_view.dart';
import 'package:ozon/presentation/products/bloc/add_item_to_wish_list/add_item_to_wish_list_bloc.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../../app/constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/user_prefrences.dart';

import '../../../../domain/model/add_to_cart_model.dart';
import '../../../main/bloc/cart_local/cart_local_bloc.dart';
import '../../../resources/common_image_view.dart';

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ProductWidget extends StatelessWidget {
  ProductWidget(this.categoryProductsModelObj,
      );

  ProductHome categoryProductsModelObj;

  String userToken="";

  StockInfoBloc stockInfoBloc  = instance<StockInfoBloc>();
  CheckCartBloc checkCartBloc  = instance<CheckCartBloc>();



  AddToCartBloc addToCartBloc  = instance<AddToCartBloc>();

  AddItemToWishListBloc addItemToWishListBloc = instance<AddItemToWishListBloc>();

  double getDiscountPrice(){
    String description =categoryProductsModelObj.discount;
    if(description.trim().isEmpty){
      description = "0";
    }

    return double.parse(description);
  }

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();
    // CartBloc cartBloc = instance<CartBloc>();
    userToken = userPreferences.userToken!;
    String off =categoryProductsModelObj.discount;

    return Align(
        alignment: AlignmentDirectional.centerStart,
        child: InkWell(
          onTap: () {
            Map<String,dynamic> map = {};
            map['productId'] = categoryProductsModelObj.productId;
            map['title']= categoryProductsModelObj.name;
            // Navigator.pushNamed(context, Routes.productDetailsHomeRoute,arguments: map);
            // onTapImgMaskgroup!();
            Routes.navigateTo( Routes.productDetailsHomeRoute,arguments: map);
          },
          child: Container(
            height: 251.h,
            width: 160.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(

                    height: 251.h,
                    width: 160.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //
                        //   children: [
                        //     BlocListener<StockInfoBloc, StockInfoState>(
                        //       bloc: stockInfoBloc,
                        //       listenWhen: (previous, current) => previous != current,
                        //       listener: (context, state) {
                        //         if(state is StockInfoLoading){
                        //           showLoadingDialog(context);
                        //
                        //         }else if(state is StockInfoSuccess){
                        //          Navigator.pop(context);
                        //           if(state.stockModel.list.isEmpty){
                        //             ScaffoldMessenger
                        //                 .of(context)
                        //                 .showSnackBar(
                        //               SnackBar(content: Text(
                        //                   AppStrings.OutOfStock.tr())),
                        //             );
                        //           }else {
                        //             bool productInStock = state.stockModel
                        //                 .list[0].quantity! > 1;
                        //             if (productInStock) {
                        //               checkCartBloc.add(
                        //                   CheckCartFetched(userToken));
                        //             } else {
                        //               ScaffoldMessenger
                        //                   .of(context)
                        //                   .showSnackBar(
                        //                 SnackBar(content: Text(
                        //                     AppStrings.OutOfStock.tr())),
                        //               );
                        //             }
                        //           }
                        //         }else if(state is StockInfoFailure){
                        //          Navigator.pop(context);
                        //           ScaffoldMessenger.of(context).showSnackBar(
                        //             SnackBar(content: Text(state.message)),
                        //           );
                        //
                        //         }
                        //       },
                        //       child: BlocListener<CheckCartBloc, CheckCartState>(
                        //         bloc: checkCartBloc,
                        //
                        //           listenWhen: (previous, current) => previous != current,
                        //           listener: (context, cartState) {
                        //             if(cartState is CheckCartLoading){
                        //               showLoadingDialog(context);
                        //
                        //             }else
                        //             if(cartState is CheckCartSuccess){
                        //              Navigator.pop(context);
                        //               Map<String,dynamic> map = {};
                        //               Map<String,dynamic> cartItemMap ={};
                        //               cartItemMap['sku'] = categoryProductsModelObj.sku;
                        //               cartItemMap['qty']=1;
                        //               cartItemMap['quote_id']=cartState.orderModel.id;
                        //               map['cartItem'] = cartItemMap;
                        //               addToCartBloc.add(AddToCartFetched(userToken,map));
                        //
                        //             }else  if(cartState is CheckCartFailure){
                        //              Navigator.pop(context);
                        //               ScaffoldMessenger.of(context).showSnackBar(
                        //                 SnackBar(content: Text(cartState.message)),
                        //               );
                        //             }
                        //
                        //
                        //           },child: BlocListener<AddToCartBloc, AddToCartState>(
                        //         bloc: addToCartBloc,
                        //         listenWhen: (previous, current) => previous != current,
                        //         listener: (context, addToCartState) {
                        //           if(addToCartState is AddToCartLoading){
                        //             showLoadingDialog(context);
                        //
                        //           }
                        //           else  if(addToCartState is AddToCartSuccess){
                        //            Navigator.pop(context);
                        //             ScaffoldMessenger.of(context).showSnackBar(
                        //               SnackBar(content: Text(AppStrings.itemAddedToCart.tr())),
                        //             );
                        //             ExtensionAttirbuteImageModel? image = addToCartState.addToCartModel.extensionAttirbuteImageModel;
                        //             OrderModel.OrderItemModel orderItemModel =  OrderModel.OrderItemModel(itemId: addToCartState.addToCartModel.itemId, sku: addToCartState.addToCartModel.sku, qty: addToCartState.addToCartModel.qty, name: addToCartState.addToCartModel.name, price: addToCartState.addToCartModel.price, productType: addToCartState.addToCartModel.productType, quoteId: addToCartState.addToCartModel.quoteId, extensionAttirbuteImage: OrderModel.ExtensionAttirbuteImageModel(imageUrl: image!.imageUrl), );
                        //             // cartLocalBloc.add(AddCartLocalItem(orderItemModel));
                        //             GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));
                        //
                        //
                        //           }else  if(addToCartState is AddToCartFailure){
                        //            Navigator.pop(context);
                        //             ScaffoldMessenger.of(context).showSnackBar(
                        //               SnackBar(content: Text(addToCartState.message)),
                        //             );
                        //
                        //           }
                        //         },
                        //         child: InkWell(
                        //           onTap: (){
                        //             if(userToken.isNotEmpty){
                        //               if(categoryProductsModelObj.salableQty>=1) {
                        //                 stockInfoBloc.add(StockInfoFetched(
                        //                     categoryProductsModelObj.sku!,
                        //                     Constants.headerValue));
                        //               }else{
                        //                 ScaffoldMessenger.of(context).showSnackBar(
                        //                   SnackBar(content: Text(AppStrings.OutOfStock.tr())),
                        //                 );
                        //               }
                        //
                        //
                        //             }else{
                        //               _showLoginDialog(context);
                        //
                        //             }
                        //
                        //           },
                        //           child: Container(
                        //             // padding: getPadding(
                        //             //   left: 5,
                        //             //   top: 5,
                        //             //
                        //             // ),
                        //
                        //             width: 40.w,
                        //             height: 40.w,
                        //
                        //             child: Container(
                        //
                        //
                        //               child:Image.asset(
                        //                 ImageAssets.addToCartImage,
                        //
                        //                height: 30.w,
                        //                 width: 30.w,
                        //
                        //
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //       ),
                        //     )
                        //
                        //   ],
                        // )



                      ],
                    ),
                  ),
                ),


                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    // padding: getPadding(
                    //   left: 15,
                    //   top: 11,
                    //   right: 10,
                    //   bottom: 9,
                    // ),
                    padding: EdgeInsetsDirectional.only(
                        start: 15.w,
                        top: 11.h,
                        end: 10.w,
                        bottom: 9.w
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:
                    categoryProductsModelObj.salableQty<=0?

                    Container(
                      alignment: AlignmentDirectional.center,
                      width: 50.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                          color: Color(0xFF474747),
                          borderRadius: BorderRadius.circular(5.w)
                      ),
                      child: Text('${AppStrings.finished.tr()}'
                        ,
                        style: TextStyle(

                            color: ColorManager.white,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                        :
                              Column(
                                children: [
                                  Container(
                                    child:  off==""?SizedBox():   Container(
                                      alignment: AlignmentDirectional.center,
                                      width: 50.w,
                                      height: 20.h,

                                      decoration: BoxDecoration(
                                          color: ColorManager.primary,
                                          borderRadius: BorderRadius.circular(5.w)
                                      ),
                                      child: Text('${off} ${AppStrings.off.tr()}'
                                        ,
                                        style: TextStyle(

                                            color: ColorManager.white,
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(height: 4.w,),
                                  Container(
                                    child: categoryProductsModelObj.onSale == "yes"?
                                    Container(
                                      alignment: AlignmentDirectional.center,
                                      width: 50.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                          color: ColorManager.green800,
                                          borderRadius: BorderRadius.circular(5.w)
                                      ),
                                      child: Text('${AppStrings.onsale.tr()}'
                                        ,
                                        style: TextStyle(

                                            color: ColorManager.white,
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ):Container() ,

                                  )
                                ],
                              ),
                            ),


                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    if(userToken.trim().isNotEmpty){
                                      addItemToWishListBloc.add(AddItemToWishListFetched(userToken,categoryProductsModelObj.productId.toString()));
                                    }else{
                                      print("ss");
                                      _showLoginDialog(context);
                                    }
                                  },
                                  child: BlocListener<AddItemToWishListBloc, AddItemToWishListState>(
                                    bloc: addItemToWishListBloc,
                                    listener: (context, state) {
                                      if(state is AddItemToWishListLoading){
                                        showLoadingDialog(context);
                                      }
                                      else if(state is AddItemToWishListFailure){
                                       Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(state.message)),
                                        );
                                      }
                                      else if(state is AddItemToWishListSuccess){
                                       Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(state.addItemToWishListModel.message)),
                                        );
                                      }

                                    },
                                    child: Icon(Icons.favorite_border_outlined,color: ColorManager.primary,
                                      size: 24.w,)
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                  categoryProductsModelObj.productId;
                                    categoryProductsModelObj.name;
                                    // Navigator.pushNamed(context, Routes.productDetailsHomeRoute,arguments: map);
                                    // onTapImgMaskgroup!();
                                    // Routes.navigateTo( Routes.productDetailsHomeRoute,arguments: map);
                                    showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel: "Custom Full Dialog",
                                      pageBuilder: (context, _, __) {
                                        return ProductDetailsHomeView(productId: categoryProductsModelObj.productId); // <- StatefulWidget with Scaffold
                                      },
                                    );

                                  },
                                  child: Icon(Icons.visibility_outlined,color: ColorManager.primary,
                                  size: 24.w,),
                                )
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              // padding: getPadding(
                              //   left: 10,
                              //   top: 2,
                              //   right: 10,
                              // ),
                              padding: EdgeInsetsDirectional.only(
                                  start: 10.w,
                                  end: 10.w,top: 2.h
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: CommonImageView(
                                      url:categoryProductsModelObj.image,


                                    ),
                                  ),
                                  Positioned.directional(
                                    bottom: 0.w,
                                      start: 0.w,
                                      textDirection: Directionality.of(context), child:
                                  BlocListener<StockInfoBloc, StockInfoState>(
                                    bloc: stockInfoBloc,
                                    listenWhen: (previous, current) => previous != current,
                                    listener: (context, state) {
                                      if(state is StockInfoLoading){
                                        showLoadingDialog(context);

                                      }else if(state is StockInfoSuccess){
                                       Navigator.pop(context);
                                        if(state.stockModel.list.isEmpty){
                                          ScaffoldMessenger
                                              .of(context)
                                              .showSnackBar(
                                            SnackBar(content: Text(
                                                AppStrings.OutOfStock.tr())),
                                          );
                                        }else {
                                          bool productInStock = state.stockModel
                                              .list[0].quantity! > 0;
                                          if (productInStock) {
                                            checkCartBloc.add(
                                                CheckCartFetched(userToken));
                                          } else {
                                            ScaffoldMessenger
                                                .of(context)
                                                .showSnackBar(
                                              SnackBar(content: Text(
                                                  AppStrings.OutOfStock.tr())),
                                            );
                                          }
                                        }
                                      }else if(state is StockInfoFailure){
                                       Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(state.message)),
                                        );

                                      }
                                    },
                                    child: BlocListener<CheckCartBloc, CheckCartState>(
                                        bloc: checkCartBloc,

                                        listenWhen: (previous, current) => previous != current,
                                        listener: (context, cartState) {
                                          if(cartState is CheckCartLoading){
                                            showLoadingDialog(context);

                                          }else
                                          if(cartState is CheckCartSuccess){
                                           Navigator.pop(context);
                                            Map<String,dynamic> map = {};
                                            Map<String,dynamic> cartItemMap ={};
                                            cartItemMap['sku'] = categoryProductsModelObj.sku;
                                            cartItemMap['qty']=1;
                                            cartItemMap['quote_id']=cartState.orderModel.id;
                                            map['cartItem'] = cartItemMap;
                                            addToCartBloc.add(AddToCartFetched(userToken,map));

                                          }else  if(cartState is CheckCartFailure){
                                           Navigator.pop(context);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(cartState.message)),
                                            );
                                          }


                                        },child: BlocListener<AddToCartBloc, AddToCartState>(
                                      bloc: addToCartBloc,
                                      listenWhen: (previous, current) => previous != current,
                                      listener: (context, addToCartState) {
                                        if(addToCartState is AddToCartLoading){
                                          showLoadingDialog(context);

                                        }
                                        else  if(addToCartState is AddToCartSuccess){
                                         Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(AppStrings.itemAddedToCart.tr())),
                                          );
                                          ExtensionAttirbuteImageModel? image = addToCartState.addToCartModel.extensionAttirbuteImageModel;
                                          OrderModel.OrderItemModel orderItemModel =  OrderModel.OrderItemModel(itemId: addToCartState.addToCartModel.itemId, sku: addToCartState.addToCartModel.sku, qty: addToCartState.addToCartModel.qty, name: addToCartState.addToCartModel.name, price: addToCartState.addToCartModel.price, productType: addToCartState.addToCartModel.productType, quoteId: addToCartState.addToCartModel.quoteId, extensionAttirbuteImage: OrderModel.ExtensionAttirbuteImageModel(imageUrl: image!.imageUrl), );
                                          // cartLocalBloc.add(AddCartLocalItem(orderItemModel));
                                          GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));


                                        }else  if(addToCartState is AddToCartFailure){
                                         Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(addToCartState.message)),
                                          );

                                        }
                                      },

                                      child: InkWell(
                                        onTap: (){
                                          if(userToken.isNotEmpty){
                                            if(categoryProductsModelObj.salableQty>=1) {
                                              stockInfoBloc.add(StockInfoFetched(
                                                  categoryProductsModelObj.sku!,
                                                  Constants.headerValue));
                                            }else{
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(AppStrings.OutOfStock.tr())),
                                              );
                                            }


                                          }else{
                                            _showLoginDialog(context);

                                          }

                                        },
                                        child: Container(
                                          // padding: getPadding(
                                          //   left: 5,
                                          //   top: 5,
                                          //
                                          // ),

                                          width: 40.w,
                                          height: 40.w,

                                          child: Container(


                                            child:Image.asset(
                                              ImageAssets.addToCartImage,

                                              height: 30.w,
                                              width: 30.w,


                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    ),
                                  )
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width:119.w,
                            // margin: getMargin(
                            //   top: 16,
                            //   right: 10,
                            // ),
                            margin: EdgeInsetsDirectional.only(top: 16.h,end: 10.w),
                            child: Text(
                              categoryProductsModelObj.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: ColorManager.black,
                                fontSize: 12.sp,

                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Padding(
                            // padding: getPadding(
                            //   top: 10,
                            //   right: 10,
                            // ),
                            padding: EdgeInsetsDirectional.only(top: 5.h,end: 5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(categoryProductsModelObj.discount.isNotEmpty?'${convertPrice(categoryProductsModelObj.specialPrice!)} ${AppStrings.kd.tr()}':'${convertPrice(categoryProductsModelObj.price)} ${AppStrings.kd.tr()}'
                                  ,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorManager.primary,
                                    fontSize: 13.sp,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                off==""?SizedBox():  Padding(
                                  // padding: getPadding(
                                  //   left: 5,
                                  //   top: 6,
                                  //   bottom: 2,
                                  // ),
                                  padding: EdgeInsetsDirectional.only(start: 5.w,top: 6.h,bottom: 2.h),
                                  child: Text(
                                    '${convertPrice(categoryProductsModelObj.price)} ${AppStrings.kd.tr()}',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    // style: AppStyle.txtPoppinsRegular12Gray403
                                    //     .copyWith(
                                    //   decoration: TextDecoration.lineThrough,
                                    // ),
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: ColorManager.gray800,
                                      fontSize: 13.sp,
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.w400,
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
              ],
            ),
          ),
        ),
      );
  }

  String getProductImageUrlByName(domain, imageName) {
    return '$domain/pub/media/catalog/product/$imageName';
  }

  Future<void> _showLoginDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return

          AlertDialog(

            content: Container(
              height: 50.h,
              alignment: AlignmentDirectional.center,
              child: Text(AppStrings.cartLogin.tr(),
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
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.loginRoute);

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
          );
      },
    );
  }

  String convertPrice(String price){
    double priceDouble = double.parse(price);
    String formattedNumber = priceDouble.toStringAsFixed(3);
    return formattedNumber;

  }
}

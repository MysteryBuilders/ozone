import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/order_model.dart' as OrderModel;
import 'package:ozon/domain/model/product_model.dart';
import 'package:ozon/presentation/main/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/check_cart/check_cart_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/stock_info_bloc.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';
import 'package:ozon/presentation/wishlist/bloc/remove_wish_list_bloc/remove_wish_list_bloc.dart';
import 'package:ozon/presentation/wishlist/bloc/wish_list_bloc.dart';

import '../../../../app/constants.dart';
import '../../../../app/functions.dart';
import '../../../../app/user_prefrences.dart';
import '../../../app/app_prefrences.dart';
import '../../../domain/model/add_to_cart_model.dart';
import '../../../domain/model/wishlist_model.dart';


import 'package:flutter/material.dart';

import '../../main/bloc/cart_local/cart_local_bloc.dart';
import '../../products/bloc/add_item_to_wish_list/add_item_to_wish_list_bloc.dart';
import '../../resources/common_image_view.dart';


// ignore: must_be_immutable
class WishListItem extends StatelessWidget {
  WishListItem(this.categoryProductsModelObj,
      );

  WishListItemsModel categoryProductsModelObj;
  String userToken="";
  StockInfoBloc stockInfoBloc  = instance<StockInfoBloc>();

  CheckCartBloc cartBloc  = instance<CheckCartBloc>();
  AddToCartBloc addToCartBloc  = instance<AddToCartBloc>();
  RemoveWishListBloc  removeWishListBloc = instance<RemoveWishListBloc>();
  final WishListBloc wishListBloc = instance<WishListBloc>();


  double getDiscountPrice(){
    String description ="";
    for(int i =0;i<categoryProductsModelObj.productItemModel!.customerAttributeList!.length;i++){
      if(categoryProductsModelObj.productItemModel!.customerAttributeList![i].attributeCode=="minimal_price"){
        description = categoryProductsModelObj.productItemModel!.customerAttributeList![i].value!;
        break;
      }

    }
    return double.parse(description);
  }

  @override
  Widget build(BuildContext context) {

    UserPreferences userPreferences =  GetIt.I<UserPreferences>();

    userToken = userPreferences.userToken!;
    double off =100-((100*getDiscountPrice()) /categoryProductsModelObj.productItemModel!.price!);
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: Column(
        children: [
          Expanded(flex:3,child: Container(
            child: Stack(
              children: [
                Positioned.fill(child:
                ClipRect(


                  child: CachedNetworkImage(

                    imageUrl:getImage("image",categoryProductsModelObj.productItemModel!.customerAttributeList!),
                    imageBuilder: (context, imageProvider) => Container(



                        decoration: BoxDecoration(



                          image: DecorationImage(


                           
                              image: imageProvider),
                        )
                    ),
                    placeholder: (context, url) =>
                        Container(
                          height: 50,
                          width: 50,
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
                )
                ),
                Positioned.directional(
                    top: 10.w,
                    start: 10.w,
                    textDirection: Directionality.of(context), child:off == 0?
                SizedBox.shrink():
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text('${off.toStringAsFixed(1)} ${AppStrings.lblOff.tr()}'
                    ,
                    style: TextStyle(

                        color: ColorManager.white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                )),
                Positioned.directional(textDirection: Directionality.of(context),
                    top: 10.w,
                    end: 10.w,child: InkWell(

                      child: BlocListener<RemoveWishListBloc, RemoveWishListState>(
                        bloc: removeWishListBloc,
                        listener: (context, state) {
                          if(state is RemoveWishListLoading){
                            showLoadingDialog(context);
                          }
                          else if(state is RemoveWishListFailure){
                           Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                          else if(state is RemoveWishListSuccess){
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.removeWishListModel.message)),
                            );
                          }
                        },
                        child: InkWell(
                          onTap: (){
                            print("tapp");
                            if(userToken.trim().isNotEmpty){
                              _showRemoveDialog(context,userToken,categoryProductsModelObj.id!);
                                    }
                          },
                          child: Container(
                            width: 40, // Width of the circle
                            height: 40, // Height of the circle (same as width)
                            decoration: BoxDecoration(
                              color: Colors.white54, // Background color
                              shape: BoxShape.circle, // Makes the container circular

                            ),
                            child: Center(
                              child: Icon(Icons.favorite,color: ColorManager.primary,size: 20.w,),
                            ),
                          ),
                        ),
                      ),
                    )),
                Positioned.directional(textDirection: Directionality.of(context),
                    bottom:  10.w,
                    start: 10.w,child: InkWell(

                      child: BlocListener<StockInfoBloc, StockInfoState>(
                          bloc: stockInfoBloc,
                          listenWhen: (previous, current) => previous != current,
                          listener: (context, state) {
                            if(state is StockInfoLoading){
                              showLoadingDialog(context);

                            }else if(state is StockInfoSuccess){
                              dismissLoadingDialog();
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
                                  cartBloc.add(
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
                              dismissLoadingDialog();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );

                            }
                          },
                          child: BlocListener<CheckCartBloc, CheckCartState>(
                            bloc: cartBloc,

                            listenWhen: (previous, current) => previous != current,
                            listener: (context, cartState) {
                              if(cartState is CheckCartLoading){
                                showLoadingDialog(context);

                              }else
                              if(cartState is CheckCartSuccess){
                                dismissLoadingDialog();
                                Map<String,dynamic> map = {};
                                Map<String,dynamic> cartItemMap ={};
                                cartItemMap['sku'] = categoryProductsModelObj.productItemModel!.sku!;
                                cartItemMap['qty']=1;
                                cartItemMap['quote_id']=cartState.orderModel.id;
                                map['cartItem'] = cartItemMap;
                                addToCartBloc.add(AddToCartFetched(userToken,map));

                              }else  if(cartState is CheckCartFailure){
                                dismissLoadingDialog();
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
                                dismissLoadingDialog();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.itemAddedToCart.tr())),
                                );
                                ExtensionAttirbuteImageModel? image = addToCartState.addToCartModel.extensionAttirbuteImageModel;
                                OrderModel.OrderItemModel orderItemModel =  OrderModel.OrderItemModel(itemId: addToCartState.addToCartModel.itemId, sku: addToCartState.addToCartModel.sku, qty: addToCartState.addToCartModel.qty, name: addToCartState.addToCartModel.name, price: addToCartState.addToCartModel.price, productType: addToCartState.addToCartModel.productType, quoteId: addToCartState.addToCartModel.quoteId, extensionAttirbuteImage: OrderModel.ExtensionAttirbuteImageModel(imageUrl: image!.imageUrl), );
                                // cartLocalBloc.add(AddCartLocalItem(orderItemModel));
                                GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));


                              }else  if(addToCartState is AddToCartFailure){
                                dismissLoadingDialog();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(addToCartState.message)),
                                );

                              }
                            },
                            child: InkWell(
                              onTap: (){
                                if(userToken.isNotEmpty){

                                  stockInfoBloc.add(StockInfoFetched(
                                      categoryProductsModelObj.productItemModel!.sku!,
                                      Constants.headerValue));



                                }else{
                                  _showLoginDialog(context,AppStrings.cartLogin.tr());

                                }
                              },
                              child: Container(
                                width: 40, // Width of the circle
                                height: 40, // Height of the circle (same as width)
                                decoration: BoxDecoration(
                                  color: ColorManager.primary, // Background color
                                  shape: BoxShape.circle, // Makes the container circular

                                ),
                                child: Center(
                                  child: Icon(Icons.shopping_bag_rounded,color: ColorManager.white,size: 20.w,),
                                ),
                              ),
                            ),
                          ),
                          )),
                    ))



              ],
            ),
          )),
          Expanded(flex:1,child: Container(
            child: Column(
              children: [
                Expanded(flex:2,child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('${categoryProductsModelObj.productItemModel!.name!}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: ColorManager.mainBlack,
                        fontWeight: FontWeight.normal,
                        fontSize: ScreenUtil().setSp(14)
                    ),),
                )),
                Expanded(flex:1,child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  child:Row(
                    children: [
                      Text('${getDiscountPrice().toStringAsFixed(3)} ${AppStrings.kd.tr()}',

                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: ColorManager.mainBlack,

                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(14)
                        ),),
                      SizedBox(width: 3.w,),
                      Container(
                        child: off == 0?
                        SizedBox():
                        Text('${categoryProductsModelObj.productItemModel!.price!.toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.mainBlack,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(14)
                          ),),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ))
        ],
      ),
    );
  }

  String getImage(String attributeName,List<CustomerAttributeItemModel> customAttirbuteList){
    String imageUrl ="";

    for(int i =0;i<customAttirbuteList.length;i++){
      if(customAttirbuteList![i].attributeCode == attributeName){
        String imageName = categoryProductsModelObj.productItemModel!.customerAttributeList![i].value!;
        if(imageName.contains("http")){
          imageUrl = imageName;
          break;

        }else{
          imageUrl = getProductImageUrlByName(Constants.domain, imageName);
          break;

        }


      }

    }
    print("url ---> ${imageUrl}");

    return imageUrl;

  }
  String getProductImageUrlByName(domain, imageName) {
    return '$domain/pub/media/catalog/product/$imageName';
  }

  void _showLoginDialog(BuildContext context,String text){
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
              Container(height: 40.w,
                width: ScreenUtil().screenWidth,
                alignment: Alignment.center,

                child: Text(AppStrings.login.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal
                  ),),),
              Container(width:ScreenUtil().screenWidth ,height: 0.5,color: ColorManager.gray300,),


              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
                child: Text(text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: ColorManager.secondaryBlack,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.normal,

                  ),),
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
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: ColorManager.primary,
                                width: 1
                            )
                        ),
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.no.tr(),
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
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Routes.loginRoute);

                      },
                      child: Container(
                        color: ColorManager.primary,
                        alignment: AlignmentDirectional.center,
                        height: ScreenUtil().screenHeight,
                        child: Text(AppStrings.yes.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal
                          ),),
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
  Future<void> _showRemoveDialog(BuildContext context,String authorization,int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return BlocListener<RemoveWishListBloc, RemoveWishListState>(
          bloc: removeWishListBloc,
  listener: (context, state) {
            if(state is RemoveWishListLoading){
              showLoading(context);
            }else if(state is RemoveWishListFailure){
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }else if(state is RemoveWishListSuccess){
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.removeWishListModel.message)),
              );
              wishListBloc.add(WishListFetched(authorization));
            }
    // TODO: implement listener
  },
  child: AlertDialog(

          content: Container(
            height: 50.h,
            alignment: AlignmentDirectional.center,
            child: Text(AppStrings.deleteFromWishList.tr(),
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
                removeWishListBloc.add(RemoveWishListFetched(authorization,id.toString()));


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

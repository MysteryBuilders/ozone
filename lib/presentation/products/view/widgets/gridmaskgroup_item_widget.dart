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
class GridmaskgroupItemWidget extends StatelessWidget {
  GridmaskgroupItemWidget(this.categoryProductsModelObj,
    );

  ProductModel categoryProductsModelObj;
  String userToken="";
  StockInfoBloc stockInfoBloc  = instance<StockInfoBloc>();

  CheckCartBloc cartBloc  = instance<CheckCartBloc>();
  AddToCartBloc addToCartBloc  = instance<AddToCartBloc>();
  AddItemToWishListBloc addItemToWishListBloc = instance<AddItemToWishListBloc>();


  double getDiscountPrice(){
    String description ="0";
    for(int i =0;i<categoryProductsModelObj.customAttributes!.length;i++){
      if(categoryProductsModelObj.customAttributes![i].attributeCode=="minimal_price"){
        description = categoryProductsModelObj.customAttributes![i].value;
        break;
      }

    }
    return double.parse(description);
  }

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();

    userToken = userPreferences.userToken!;
    double off =100-((100*getDiscountPrice()) /categoryProductsModelObj.price!);
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: InkWell(
         onTap: () {
           Map<String,dynamic> map = {};
           map['productDetails'] = categoryProductsModelObj;
           map['title']= categoryProductsModelObj!.name;

           // Navigator.pushNamed(context, Routes.productDetailsRoute,arguments: map);
          Navigator.pushNamed(context, Routes.productDetailsRoute,arguments: map);
                    // onTapImgMaskgroup!();
                  },
        child: Container(

          child: Stack(
            alignment: Alignment.center,
            children: [

             
             
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
                          off==0?SizedBox():   Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Text('${off.toStringAsFixed(1)} ${AppStrings.lblOff.tr()}'
                              ,
                              style: TextStyle(

                                  color: ColorManager.black,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              if(userToken.trim().isNotEmpty){
                                addItemToWishListBloc.add(AddItemToWishListFetched(userToken,categoryProductsModelObj.id.toString()));
                              }else{
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
                                  dismissLoadingDialog();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                }
                                else if(state is AddItemToWishListSuccess){
                                  dismissLoadingDialog();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.addItemToWishListModel.message)),
                                  );
                                }

  },
  child: CommonImageView(
                              svgPath: ImageAssets.imgFavorite,
                              height: 24.h,
                              width: 24.w,
                            ),
),
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
                                    url: getImage("image",categoryProductsModelObj.customAttributes!),

                                    height: 100.h,
                                    width: 86.w,
                                  ),
                                ),
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                    bottom: 0,
                                    start: 0,
                                    child: BlocListener<StockInfoBloc, StockInfoState>(
                                      bloc: stockInfoBloc,
                                      listener: (context, state) {
                                        if(state is StockInfoLoading){
                                          showLoadingDialog(context);

                                        }else if(state is StockInfoSuccess) {
                                          dismissLoadingDialog();
                                          if (state.stockModel.list.isNotEmpty) {
                                            bool productInStock = state.stockModel.list[0].quantity! > 0;
                                            if (productInStock) {
                                              cartBloc.add(CheckCartFetched(userToken));
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text(AppStrings.OutOfStock.tr())),
                                              );
                                            }
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(AppStrings.OutOfStock.tr())),
                                            );
                                          }
                                        } else if (state is StockInfoFailure) {
                                          dismissLoadingDialog();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(state.message)),
                                          );
                                        }

                                      },
                                      child: BlocListener<CheckCartBloc, CheckCartState>(
                                          bloc: cartBloc,
                                          listener: (context, cartState) {
                                            if(cartState is CheckCartLoading){
                                              showLoadingDialog(context);

                                            }else
                                            if(cartState is CheckCartSuccess){
                                              dismissLoadingDialog();
                                              Map<String,dynamic> map = {};
                                              Map<String,dynamic> cartItemMap ={};
                                              cartItemMap['sku'] = categoryProductsModelObj.sku;
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


                                          },
                                          child: BlocListener<AddToCartBloc, AddToCartState>(
                                            bloc: addToCartBloc,
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
                                                  stockInfoBloc.add(StockInfoFetched(categoryProductsModelObj.sku!,Constants.headerValue));


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
                                    ) )
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
                              Text('${getDiscountPrice()} ${AppStrings.kd.tr()}'
                                 ,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: ColorManager.primary,
                                  fontSize: 10.sp,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              off==0?SizedBox():
                              Padding(
                                // padding: getPadding(
                                //   left: 5,
                                //   top: 6,
                                //   bottom: 2,
                                // ),
                                padding: EdgeInsetsDirectional.only(start: 5.w,top: 6.h,bottom: 2.h),
                                child: Text(
                                  '${categoryProductsModelObj.price} ${AppStrings.kd.tr()}',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  // style: AppStyle.txtPoppinsRegular12Gray403
                                  //     .copyWith(
                                  //   decoration: TextDecoration.lineThrough,
                                  // ),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: ColorManager.gray403,
                                    fontSize: 8.sp,
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

  String getImage(String attributeName,List<CustomAttributeModel> customAttirbuteList){
    String imageUrl ="";

    for(int i =0;i<customAttirbuteList.length;i++){
      if(customAttirbuteList![i].attributeCode == attributeName){
      String imageName = categoryProductsModelObj.customAttributes![i].value!;
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
                  Map<String,dynamic> map ={};
                  map['title']="";
                   Navigator.of(context,rootNavigator: true).pushNamed( Routes.loginRoute);


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
}

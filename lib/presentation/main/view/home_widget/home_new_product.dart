

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/domain/model/order_model.dart' as OrderModel;

import '../../../../app/constants.dart';
import '../../../../app/di.dart';
import '../../../../app/user_prefrences.dart';
import '../../../../domain/model/add_to_cart_model.dart';
import '../../../../domain/model/home_screen_model.dart';
import '../../../../domain/model/product_model.dart';
import '../../../product_details/bloc/stock_info_bloc.dart';
import '../../../products/bloc/add_item_to_wish_list/add_item_to_wish_list_bloc.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/loading_view.dart';
import '../../bloc/add_to_cart/add_to_cart_bloc.dart';
import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../bloc/check_cart/check_cart_bloc.dart';

class HomeNewProductWidget extends StatelessWidget {
  HomeNewProductWidget({super.key,required this.categoryProductsModelObj});
  ProductHome categoryProductsModelObj;
  String userToken="";
  StockInfoBloc stockInfoBloc  = instance<StockInfoBloc>();
  CheckCartBloc checkCartBloc  = instance<CheckCartBloc>();
  CheckCartBloc cartBloc  = instance<CheckCartBloc>();
  AddToCartBloc addToCartBloc  = instance<AddToCartBloc>();
  AddItemToWishListBloc addItemToWishListBloc = instance<AddItemToWishListBloc>();
  String getDiscountPrice(){
    String description =categoryProductsModelObj.discount;
    print("description ---> ${description}");
    if(description.trim().isEmpty){
      description = "0";
    }

    return description;
  }
  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();

    userToken = userPreferences.userToken!;
    String off =categoryProductsModelObj.discount;
    return InkWell(
      onTap: (){
        Map<String,dynamic> map = {};
         map['productId'] = categoryProductsModelObj.productId;
        // map['productId'] = '16862';
        map['title']= categoryProductsModelObj.name;
        print("product Details ---> ${categoryProductsModelObj.name}");
        // Navigator.pushNamed(context, Routes.productDetailsHomeRoute,arguments: map);
        // onTapImgMaskgroup!();
        Navigator.pushNamed( context,Routes.productDetailsHomeRoute,arguments: map);

      },
      child: Container(
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


                      imageUrl:categoryProductsModelObj.image,
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
                      textDirection: Directionality.of(context), child:Column(
                        children: [
                          off == ""?
                                          SizedBox.shrink():
                                          Container(
                                            padding: EdgeInsets.all(8.w),
                                            decoration: BoxDecoration(
                            color: ColorManager.primary,
                            borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Text('${off} ${AppStrings.off.tr()}'
                          ,
                          style: TextStyle(

                              color: ColorManager.white,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.normal
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
                                  borderRadius: BorderRadius.circular(10.w)
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
                      )),
                  Positioned.directional(textDirection: Directionality.of(context),
                      top: 10.w,
                      end: 10.w,child: InkWell(

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
                          child: InkWell(
                            onTap: (){
                              print("tapp");
                              if(userToken.trim().isNotEmpty){
                                addItemToWishListBloc.add(AddItemToWishListFetched(userToken,categoryProductsModelObj.productId));
                              }else{
                                _showLoginDialog(context,AppStrings.addToWishList.tr());
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
                                child: Icon(Icons.favorite_border_rounded,color: ColorManager.primary,size: 20.w,),
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
                                        categoryProductsModelObj.sku!,
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
                    child: Row(
                      children: [
                        Expanded(
                          flex:3,
                          child: Text('${categoryProductsModelObj.name}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.mainBlack,
                                fontWeight: FontWeight.normal,
                                fontSize: ScreenUtil().setSp(14)
                            ),),
                        ),

                      ],
                    ),
                  )),
                  Expanded(flex:1,child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    child:Row(
                      children: [
                        Text('${off == ""?double.parse(categoryProductsModelObj.price).toStringAsFixed(3):double.parse(categoryProductsModelObj.specialPrice!).toStringAsFixed(3)} ${AppStrings.kd.tr()}',

                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.mainBlack,

                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(14)
                          ),),
                        SizedBox(width: 3.w,),
                        Container(
                          child: off == ""?
                          SizedBox():
                          Text('${double.parse(categoryProductsModelObj.price).toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.mainBlack,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 5.h,
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
      ),
    );
  }
  String convertPrice(String price){
    double priceDouble = double.parse(price);
    String formattedNumber = priceDouble.toStringAsFixed(3);
    return formattedNumber;

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
}

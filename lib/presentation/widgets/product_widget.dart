import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/domain/model/bundle_product_options_model.dart';
import 'package:ozon/domain/model/order_model.dart' as OrderModel;
import '../../app/app_prefrences.dart';
import '../../app/constants.dart';
import '../../app/di.dart';
import '../../app/user_prefrences.dart';
import '../../domain/model/add_to_cart_model.dart';

import '../../domain/model/products_model.dart';
import '../main/bloc/add_to_cart/add_to_cart_bloc.dart';
import '../main/bloc/cart_bloc/cart_bloc.dart';
import '../main/bloc/check_cart/check_cart_bloc.dart';
import '../product_details/bloc/stock_info_bloc.dart';
import '../products/bloc/add_item_to_wish_list/add_item_to_wish_list_bloc.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import 'loading_view.dart';

class ProductItemWidget extends StatefulWidget {
  ProductItemWidget({super.key, required this.categoryProductsModelObj});

  ProductItemModel categoryProductsModelObj;
  String? sourceCode;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  UserPreferences userPreferences = GetIt.I<UserPreferences>();
  String sourceCode ="";
  String convertedSourceCode ="";
  List<String> productLabels = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initView();
  }
  initView()async{
    sourceCode = userPreferences.sourceCode!;
    convertedSourceCode = normalizeCode(sourceCode);
     productLabels = widget.categoryProductsModelObj.extensionAttributes!.codazonLabels!;
    productLabels = productLabels.toSet().toList();

  }
  String normalizeCode(String input) {
    return input.replaceAll('-', '').toLowerCase();
  }

  String userToken = "";

  StockInfoBloc stockInfoBloc = instance<StockInfoBloc>();

  CheckCartBloc checkCartBloc = instance<CheckCartBloc>();

  CheckCartBloc cartBloc = instance<CheckCartBloc>();

  AddToCartBloc addToCartBloc = instance<AddToCartBloc>();

  AddItemToWishListBloc addItemToWishListBloc =
      instance<AddItemToWishListBloc>();

  double getDiscountPrice() {
    String description = "0";
    for (int i = 0;
        i < widget.categoryProductsModelObj.customAttributes!.length;
        i++) {
      if (widget.categoryProductsModelObj.customAttributes![i].attributeCode ==
          "special_price") {
        description = widget.categoryProductsModelObj.customAttributes![i].value;
        break;
      }
    }
    return double.parse(description);
  }

  @override
  Widget build(BuildContext context) {
    int getQuantity(ProductItemModel productModel){
      int quantity =0;

      for(int i =0;i<productModel.customAttributes!.length;i++){
        if(productModel.customAttributes![i].attributeCode =='salability_${convertedSourceCode}'){
          quantity = double.parse(productModel.customAttributes![i].value).toInt();
          break;
        }
        print("quantity ---> ${quantity}");

      }
      return quantity;
    }
    String printProductLinksQtyExpression(List<BundleProductOptionsModel> options) {
      final qtyList = options
          .expand((option) => option.productLinks as List<ProductLinksModel>)
          .map((link) => link.qty as int)
          .toList();

      final qtyString = qtyList.join(" + ");
      final total = qtyList.fold(0, (sum, qty) => sum + qty);

      return ("$qtyString = $total");
    }

    UserPreferences userPreferences = GetIt.I<UserPreferences>();

    userToken = userPreferences.userToken!;
    double off =getDiscountPrice()== 0?0:
        100 - ((100 * getDiscountPrice()) / widget.categoryProductsModelObj.price!);
    return InkWell(
      onTap: () {
        Map<String, dynamic> map = {};
        map['productId'] = widget.categoryProductsModelObj.id.toString();
        map['title'] = widget.categoryProductsModelObj.name;
        print("product Details ---> ${widget.categoryProductsModelObj.name}");
        // Navigator.pushNamed(context, Routes.productDetailsHomeRoute,arguments: map);
        // onTapImgMaskgroup!();
        Navigator.pushNamed(context, Routes.productDetailsHomeRoute,
            arguments: map);
      },
      child: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: ClipRect(
                        child: CachedNetworkImage(
                          imageUrl: getImage("image",
                              widget.categoryProductsModelObj.customAttributes!),
                          imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                            image: DecorationImage(image: imageProvider),
                          )),
                          placeholder: (context, url) => Container(
                            height: 50,
                            width: 50,
                            child: LinearProgressIndicator(
                              color: Colors.grey.shade200,
                              backgroundColor: Colors.grey.shade100,
                            ),
                          ),
                          errorWidget: (context, url, error) => SizedBox(
                            width: 30.w,
                            height: 30.w,
                            child: Image.asset(
                              'assets/images/image_not_found.png',
                              height: 30.w,
                              width: 30.w,
                            ),
                          ),
                        ),
                      )),
                      Positioned.directional(
                          top: 10.w,
                          start: 10.w,
                          textDirection: Directionality.of(context),
                          child:  SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: productLabels
                                  .map((item) => Padding(
                                    padding: EdgeInsets.only(bottom: 2.w),
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                                                  width:50.w,
                                                                  height: 20.h,
                                                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.w),
                                    color: Colors.green,
                                                                  ),
                                      child: Text(
                                                                    item,
                                                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(8),
                                      fontWeight: FontWeight.normal,
                                                                    ),
                                                                  ),
                                    ),
                                  ))
                                  .toList(),
                            ),
                          ),),
                      Positioned.directional(
                          textDirection: Directionality.of(context),
                          top: 10.w,
                          end: 10.w,
                          child: InkWell(
                            child: BlocListener<AddItemToWishListBloc,
                                AddItemToWishListState>(
                              bloc: addItemToWishListBloc,
                              listener: (context, state) {
                                if (state is AddItemToWishListLoading) {
                                  showLoadingDialog(context);
                                } else if (state is AddItemToWishListFailure) {
                                  dismissLoadingDialog();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.message)),
                                  );
                                } else if (state is AddItemToWishListSuccess) {
                                  dismissLoadingDialog();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(state
                                            .addItemToWishListModel.message)),
                                  );
                                }
                              },
                              child: InkWell(
                                onTap: () {
                                  print("tapp");
                                  if (userToken.trim().isNotEmpty) {
                                    addItemToWishListBloc.add(
                                        AddItemToWishListFetched(
                                            userToken,
                                            widget.categoryProductsModelObj.id
                                                .toString()));
                                  } else {
                                    _showLoginDialog(
                                        context, AppStrings.addToWishList.tr());
                                  }
                                },
                                child: Container(
                                  width: 40, // Width of the circle
                                  height:
                                      40, // Height of the circle (same as width)
                                  decoration: BoxDecoration(
                                    color: Colors.white54, // Background color
                                    shape: BoxShape
                                        .circle, // Makes the container circular
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.favorite_border_rounded,
                                      color: ColorManager.primary,
                                      size: 20.w,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      Positioned.directional(
                          textDirection: Directionality.of(context),
                          bottom: 10.w,
                          start: 10.w,
                          child: InkWell(
                            child: BlocListener<StockInfoBloc, StockInfoState>(
                                bloc: stockInfoBloc,
                                listenWhen: (previous, current) =>
                                    previous != current,
                                listener: (context, state) {
                                  if (state is StockInfoLoading) {
                                    showLoadingDialog(context);
                                  } else if (state is StockInfoSuccess) {
                                    dismissLoadingDialog();
                                    if (state.stockModel.list.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                AppStrings.OutOfStock.tr())),
                                      );
                                    } else {
                                      bool productInStock =
                                          state.stockModel.list[0].quantity! >
                                              0;
                                      if (productInStock) {
                                        checkCartBloc
                                            .add(CheckCartFetched(userToken));
                                      }
                                      else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  AppStrings.OutOfStock.tr())),
                                        );
                                      }
                                    }
                                  } else if (state is StockInfoFailure) {
                                    dismissLoadingDialog();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)),
                                    );
                                  }
                                },
                                child:
                                    BlocListener<CheckCartBloc, CheckCartState>(
                                  bloc: checkCartBloc,
                                  listenWhen: (previous, current) =>
                                      previous != current,
                                  listener: (context, cartState) {
                                    if (cartState is CheckCartLoading) {
                                      showLoadingDialog(context);
                                    } else if (cartState is CheckCartSuccess) {
                                      dismissLoadingDialog();
                                      Map<String, dynamic> map = {};
                                      Map<String, dynamic> cartItemMap = {};
                                      cartItemMap['sku'] =
                                          widget.categoryProductsModelObj.sku;
                                      cartItemMap['qty'] = 1;
                                      cartItemMap['quote_id'] =
                                          cartState.orderModel.id;
                                      map['cartItem'] = cartItemMap;
                                      addToCartBloc.add(
                                          AddToCartFetched(userToken, map));
                                    } else if (cartState is CheckCartFailure) {
                                      dismissLoadingDialog();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(cartState.message)),
                                      );
                                    }
                                  },
                                  child: BlocListener<AddToCartBloc,
                                      AddToCartState>(
                                    bloc: addToCartBloc,
                                    listenWhen: (previous, current) =>
                                        previous != current,
                                    listener: (context, addToCartState) {
                                      if (addToCartState is AddToCartLoading) {
                                        showLoadingDialog(context);
                                      } else if (addToCartState
                                          is AddToCartSuccess) {
                                        dismissLoadingDialog();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(AppStrings
                                                  .itemAddedToCart
                                                  .tr())),
                                        );
                                        ExtensionAttirbuteImageModel? image =
                                            addToCartState.addToCartModel
                                                .extensionAttirbuteImageModel;
                                        OrderModel.OrderItemModel
                                            orderItemModel =
                                            OrderModel.OrderItemModel(
                                          itemId: addToCartState
                                              .addToCartModel.itemId,
                                          sku:
                                              addToCartState.addToCartModel.sku,
                                          qty:
                                              addToCartState.addToCartModel.qty,
                                          name: addToCartState
                                              .addToCartModel.name,
                                          price: addToCartState
                                              .addToCartModel.price,
                                          productType: addToCartState
                                              .addToCartModel.productType,
                                          quoteId: addToCartState
                                              .addToCartModel.quoteId,
                                          extensionAttirbuteImage: OrderModel
                                              .ExtensionAttirbuteImageModel(
                                                  imageUrl: image!.imageUrl),
                                        );
                                        // cartLocalBloc.add(AddCartLocalItem(orderItemModel));
                                        GetIt.I<CartBloc>().add(CartFetched(
                                            userPreferences.userToken!));
                                      } else if (addToCartState
                                          is AddToCartFailure) {
                                        dismissLoadingDialog();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content:
                                                  Text(addToCartState.message)),
                                        );
                                      }
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        if (userToken.isNotEmpty) {
                                          if(getQuantity(widget.categoryProductsModelObj)>0){

                                              checkCartBloc
                                                  .add(CheckCartFetched(userToken));



                                          }else{
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      AppStrings.OutOfStock.tr())),
                                            );
                                          }

                                        } else {
                                          _showLoginDialog(context,
                                              AppStrings.cartLogin.tr());
                                        }
                                      },
                                      child: Container(
                                        width: 40,
                                        // Width of the circle
                                        height: 40,
                                        // Height of the circle (same as width)
                                        decoration: BoxDecoration(
                                          color: ColorManager
                                              .primary, // Background color
                                          shape: BoxShape
                                              .circle, // Makes the container circular
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.shopping_bag_rounded,
                                            color: ColorManager.white,
                                            size: 20.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ))
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              '${widget.categoryProductsModelObj.name}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: ColorManager.mainBlack,
                                      fontWeight: FontWeight.normal,
                                      fontSize: ScreenUtil().setSp(14)),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            alignment: AlignmentDirectional.centerStart,
                            child:widget.categoryProductsModelObj.typeId =="bundle"?
                            Text(
                              ' ${getDiscountPrice().toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                  color: ColorManager.mainBlack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(14)),
                            ):widget.categoryProductsModelObj.typeId =="grouped"?
                                Container():
                            Row(
                              children: [

                                Row(
                                  children: [
                                    Text(
                                      ' ${getDiscountPrice()==0?widget.categoryProductsModelObj.price!.toStringAsFixed(3):getDiscountPrice().toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              color: ColorManager.mainBlack,
                                              fontWeight: FontWeight.w500,
                                              fontSize: ScreenUtil().setSp(14)),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                  ],
                                ),
                                Container(
                                  child: off == 0
                                      ? SizedBox()
                                      : Text(
                                          '${widget.categoryProductsModelObj.price!.toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  color: ColorManager.mainBlack,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: Colors.red,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      ScreenUtil().setSp(14)),
                                        ),
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

  String getImage(
      String attributeName, List<CustomAttributeModel> customAttirbuteList)
  {
    String imageUrl = "";

    for (int i = 0; i < customAttirbuteList.length; i++) {
      if (customAttirbuteList![i].attributeCode == attributeName) {
        String imageName = widget.categoryProductsModelObj.customAttributes![i].value!;
        if (imageName.contains("http")) {
          imageUrl = imageName;
          break;
        } else {
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

  int getQuantity(ProductItemModel productModel){
    int quantity =0;

    for(int i =0;i<productModel.customAttributes!.length;i++){
      print('salability_${convertedSourceCode}');
      if(productModel.customAttributes![i].attributeCode! =='salability_${convertedSourceCode}'){
        quantity =double.parse(productModel.customAttributes![i].value).toInt() ;
        break;
      }
      print("quantity ---> ${quantity}");

    }
    return quantity;
  }

  void _showLoginDialog(BuildContext context, String text) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // Important for wrap content behavior
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Container(
                height: 40.w,
                width: ScreenUtil().screenWidth,
                alignment: Alignment.center,
                child: Text(
                  AppStrings.login.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal),
                ),
              ),
              Container(
                width: ScreenUtil().screenWidth,
                height: 0.5,
                color: ColorManager.gray300,
              ),
              Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: ColorManager.secondaryBlack,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              SizedBox(
                height: 20.w,
              ),
              Container(
                height: 40.w,
                width: ScreenUtil().screenWidth,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ColorManager.primary, width: 1)),
                            height: ScreenUtil().screenHeight,
                            child: Text(
                              AppStrings.no.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: ColorManager.primary,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.loginRoute);
                          },
                          child: Container(
                            color: ColorManager.primary,
                            alignment: AlignmentDirectional.center,
                            height: ScreenUtil().screenHeight,
                            child: Text(
                              AppStrings.yes.tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: ColorManager.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                height: 30.w,
                color: Color(0x00000000),
              )
            ],
          );
        });
  }
}

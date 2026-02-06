import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/domain/model/products_model.dart';

import 'package:ozon/presentation/main/bloc/add_to_cart/add_to_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/check_cart/check_cart_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/counter_bloc.dart';
import 'package:ozon/presentation/product_details/bloc/counter_event.dart';
import 'package:ozon/presentation/product_details/bloc/counter_state.dart';
import 'package:ozon/presentation/product_details/bloc/stock_info_bloc.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../../data/network/helper_query.dart';
import '../../main/bloc/cart_bloc/cart_bloc.dart';
import '../../products/bloc/add_item_to_wish_list/add_item_to_wish_list_bloc.dart';
import '../../products/bloc/products_bloc.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/loading_view.dart';
import '../bloc/caursel_bloc.dart';
import '../bloc/caursel_event.dart';
import '../bloc/caursel_state.dart';
import '../widgets/background_item_widget.dart';
class ProductDetailsView extends StatefulWidget {
  ProductItemModel productModel;

   ProductDetailsView({super.key,required this.productModel});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  CarouselBloc carouselBloc = instance<CarouselBloc>();
  CounterBloc counterBloc = instance<CounterBloc>();
  StockInfoBloc stockInfoBloc = instance<StockInfoBloc>();
  CheckCartBloc cartBloc = instance<CheckCartBloc>();
  AddToCartBloc addToCartBloc = instance<AddToCartBloc>();
  ProductsBloc? productsBloc  = instance<ProductsBloc>();
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  Map<String,dynamic> map ={};
  HelperQuery helperQuery = HelperQuery();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userToken = Constants.headerValue;
    // }else{
    //   userToken = userPreferences.userToken!;
    // }
    map=    helperQuery.buildFilterQueryParams(entityId: widget.productModel!.id!.toString());

    productsBloc!.add(ProductsFetched(map,userToken));
  }
  @override
  void dispose() {
    carouselBloc.close();
    counterBloc.close();
    stockInfoBloc.close();
    cartBloc.close();
    addToCartBloc.close();
    super.dispose();
  }
  String userToken="";
  AddItemToWishListBloc addItemToWishListBloc = instance<AddItemToWishListBloc>();

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();
    // if(userPreferences.userToken!.isEmpty){
      userToken = Constants.headerValue;
    // }else{
    //   userToken = userPreferences.userToken!;
    // }
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
                text: AppStrings.produtDetails.tr(),
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
            body: BlocBuilder<ProductsBloc, ProductsState>(
              bloc: productsBloc,
  builder: (context, productsState) {
                if(productsState is ProductsLoading){
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child:    SizedBox(
                        height: 150.w,
                        width: 150.w,
                        child: Lottie.asset(ImageAssets.loadingView)),

                  );
                }else if(productsState is ProductsFailure){
                  return Container(
                    color: Colors.white,
                    alignment: AlignmentDirectional.center,
                    child: Text(productsState.message,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w500

                      ),),
                  );
                }else if(productsState is ProductsSuccess){
                  return Container(
                      width: ScreenUtil().screenWidth,
                      child: BlocBuilder<StockInfoBloc, StockInfoState>(
                        bloc: stockInfoBloc..add(StockInfoFetched(widget.productModel.sku!,userToken)),
                        builder: (context, stockState) {
                          if(stockState is StockInfoLoading){
                            return Container(
                              alignment: AlignmentDirectional.center,
                              child:    SizedBox(
                                  height: 150.w,
                                  width: 150.w,
                                  child: Lottie.asset(ImageAssets.loadingView)),

                            );
                          }else if(stockState is StockInfoFailure){
                            return Container(
                              color: Colors.white,
                              alignment: AlignmentDirectional.center,
                              child: Text(stockState.message,
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w500

                                ),),
                            );
                          }else if(stockState is StockInfoSuccess){
                            return Stack(
                              children: [
                                Positioned.fill(
                                  child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                  height: 200.h,
                                                  width: ScreenUtil().screenWidth,
                                                  // margin: getMargin(left: 10, top: 10, right: 10),
                                                  margin: EdgeInsetsDirectional.only(start: 10.w,top: 10.h,end: 10.w,),
                                                  child:
                                                  Stack(
                                                      alignment: Alignment.center, children: [
                                                    Positioned.fill(
                                                      child: Container(
                                                        height: 200.h,
                                                        width: ScreenUtil().screenWidth,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(15.w)
                                                        ),

                                                      ),
                                                    ),




                                                    BlocBuilder<CarouselBloc, CarouselState>(
                                                      bloc: carouselBloc,
                                                      builder: (context, state) {
                                                        return CarouselSlider.builder(
                                                            options: CarouselOptions(
                                                                height: 200.h,
                                                                initialPage: 0,
                                                                autoPlay: false,
                                                                viewportFraction: 1.0,
                                                                enableInfiniteScroll: false,
                                                                scrollDirection: Axis.horizontal,
                                                                onPageChanged: (index, reason) {
                                                                  carouselBloc.add(MoveToIndex(index, widget.productModel.mediaGalleryEntries!.length));
                                                                  // controller.silderIndex.value = index;
                                                                }),
                                                            itemCount: widget.productModel.mediaGalleryEntries!.length,
                                                            itemBuilder: (context, index, realIndex) {
                                                              MediaGalleryEntryModel model = widget.productModel.mediaGalleryEntries![index];
                                                              return BackgroundItemWidget(model,widget.productModel.name!);
                                                            });
                                                      },
                                                    ),
                                                    Positioned.directional(textDirection: Directionality.of(context),
                                                      top:10.w,
                                                      end:10.w,child:    CustomIconButton(
                                                          height: 40,
                                                          width: 40,
                                                          margin: EdgeInsetsDirectional.only(start: 13.w,bottom: 232.h),
                                                          // getMargin(
                                                          //     left: 13, bottom: 232),
                                                          child: InkWell(
                                                            onTap: (){
                                                              UserPreferences userPreferences =  GetIt.I<UserPreferences>();
                                                              String  userLoginToken = userPreferences.userToken!;
                                                              if(userLoginToken.trim().isNotEmpty){
                                                                addItemToWishListBloc.add(AddItemToWishListFetched(userLoginToken,widget.productModel.id.toString()));
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
                                                                  svgPath: ImageAssets
                                                                      .imgFavorite40x40),
                                                            ),
                                                          )),),

                                                  ]))),
                                          Container(
                                            height: 6.h,
                                            margin: EdgeInsetsDirectional.only(top: 10.h,bottom: 10.w)
                                            ,
                                            child: BlocBuilder<CarouselBloc, CarouselState>(
                                              bloc: carouselBloc,
                                              builder: (context, state) {
                                                return AnimatedSmoothIndicator(
                                                  activeIndex: state.currentIndex,
                                                  // activeIndex: controller.silderIndex.value,
                                                  count:widget.productModel.mediaGalleryEntries!.length,
                                                  axisDirection: Axis.horizontal,
                                                  effect: ScrollingDotsEffect(
                                                    spacing: 8,
                                                    activeDotColor:
                                                    ColorManager.deepOrangeA200,
                                                    dotColor: ColorManager.gray400,
                                                    dotHeight: 6.h,
                                                    dotWidth: 6.w,
                                                  ),
                                                );
                                              },
                                            ),


                                          ),



                                          Container(
                                            margin: EdgeInsets.all(10.w),
                                            child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        flex:4,
                                                        child: Container(

                                                            child: Text(
                                                                widget.productModel.name.toString(),
                                                                maxLines: null,
                                                                textAlign: TextAlign.start,
                                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                  color: ColorManager.black,
                                                                  fontSize: 14.sp,

                                                                  fontWeight: FontWeight.w600,
                                                                ))),
                                                      ),
                                                      SizedBox(width: 10.w,),
                                                      BlocBuilder<CounterBloc, CounterState>(
                                                        bloc: counterBloc..add(InitialCountEvent(1)),
                                                        builder: (context, state) {
                                                          return Expanded(
                                                            flex: 2,
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  // margin: getMargin(
                                                                  //     left: 11, top: 65, bottom: 2),

                                                                    child: Container(
                                                                      height: 27.h,
                                                                      width: 27.w,
                                                                      child:   InkWell(
                                                                        onTap: (){
                                                                          counterBloc.add(Decrement(1));
                                                                        },
                                                                        child: CommonImageView(
                                                                          imagePath:ImageAssets.add ,
                                                                          height: 27.h,
                                                                          width: 27.w,
                                                                        ),
                                                                      ),

                                                                    )
                                                                ),
                                                                Container(
                                                                  alignment: Alignment.center,
                                                                  width: 50,
                                                                  child: Text('${state.count}',
                                                                      overflow: TextOverflow.ellipsis,
                                                                      textAlign: TextAlign.center,
                                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                        color: ColorManager.black,
                                                                        fontSize: 20.sp,

                                                                        fontWeight: FontWeight.w500,
                                                                      )),
                                                                ),
                                                                Container(
                                                                  // margin: getMargin(
                                                                  //     top: 65, bottom: 2),

                                                                    child: Container(
                                                                      height: 27.h,
                                                                      width: 27.w,
                                                                      child:   InkWell(
                                                                        onTap: (){
                                                                          counterBloc.add(Increment(stockState.stockModel.list.isEmpty?0:stockState.stockModel.list[0].quantity!));
                                                                        },
                                                                        child: CommonImageView(
                                                                          imagePath:ImageAssets.add2 ,
                                                                          height: 27.h,
                                                                          width:27.w,
                                                                        ),
                                                                      ),

                                                                    )
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),


                                                    ]),
                                                SizedBox(height: 10.h,),
                                                Align(
                                                    alignment: AlignmentDirectional.centerStart,
                                                    child: Text(AppStrings.description.tr(),
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.start,
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                          color: ColorManager.black900,
                                                          fontSize: 12.sp,

                                                          fontWeight: FontWeight.w500,
                                                        ))),
                                                SizedBox(height: 10.h,),
                                                Align(
                                                    alignment: AlignmentDirectional.centerStart,
                                                    child: HtmlWidget(getDescription(),


                                                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                          color: ColorManager.gray800,
                                                          fontSize: 12.sp,

                                                          fontWeight: FontWeight.w400,
                                                        ))),
                                                SizedBox(height: 70.w,)



                                              ],
                                            ),
                                          ),





                                        ]),
                                  ),
                                ),
                                Positioned.directional(textDirection: Directionality.of(context),
                                    bottom: 0,
                                    start: 0,
                                    end: 0,
                                    child:    Container(
                                      color: Colors.white,
                                      padding: EdgeInsetsDirectional.symmetric(vertical: 10.h,horizontal: 10.w),
                                      child: Align(

                                          child: Row(

                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex:3,
                                                  child: Center(
                                                    child: Container(
                                                      alignment: AlignmentDirectional.center,
                                                      width: ScreenUtil().screenWidth,
                                                      child:getDiscountPrice()==0?
                                                      Text(
                                                        textAlign: TextAlign.center,
                                                        '${widget.productModel.price!.toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium!
                                                            .copyWith(
                                                            color: ColorManager.mainBlack,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: ScreenUtil().setSp(14)),
                                                      ):Text(
                                                        textAlign: TextAlign.center,
                                                        '${getDiscountPrice().toStringAsFixed(3)} ${AppStrings.kd.tr()}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displayMedium!
                                                            .copyWith(
                                                            color: ColorManager.mainBlack,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: ScreenUtil().setSp(14)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: BlocListener<CheckCartBloc, CheckCartState>(
                                                      bloc: cartBloc,
                                                      listener: (context, cartState) {
                                                        if(cartState is CheckCartLoading){
                                                          showLoadingDialog(context);

                                                        }
                                                        else
                                                        if(cartState is CheckCartSuccess){
                                                          dismissLoadingDialog();
                                                          Map<String,dynamic> map = {};
                                                          Map<String,dynamic> cartItemMap ={};
                                                          cartItemMap['sku'] = widget.productModel.sku;
                                                          cartItemMap['qty']=counterBloc.state.count;
                                                          cartItemMap['quote_id']=cartState.orderModel.id.toString();
                                                          map['cartItem'] = cartItemMap;
                                                          UserPreferences userPreferences =  GetIt.I<UserPreferences>();
                                                          String  userLoginToken = userPreferences.userToken!;
                                                          addToCartBloc.add(AddToCartFetched(userLoginToken,map));

                                                        }else if(cartState is CheckCartFailure){
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
                                                              GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));

                                                              stockInfoBloc.add(StockInfoFetched(widget.productModel.sku!,userToken));
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(content: Text(AppStrings.itemAddedToCart.tr())),
                                                              );

                                                            }else  if(addToCartState is AddToCartFailure){
                                                              dismissLoadingDialog();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                SnackBar(content: Text(addToCartState.message)),
                                                              );

                                                            }
                                                          },

                                                          child:  CustomButton(
                                                              variant:stockState.stockModel.list.isEmpty?ButtonVariant.FillBlack900:
                                                              stockState.stockModel.list[0].quantity ==0?ButtonVariant.FillGrayDark:ButtonVariant.FillBlack900 ,

                                                              width: ScreenUtil().screenWidth,
                                                              fontStyle:stockState.stockModel.list.isEmpty?ButtonFontStyle.whiteSemiBold:stockState.stockModel.list[0].quantity ==0?ButtonFontStyle.blackSemiBold:ButtonFontStyle.whiteSemiBold ,

                                                              text: stockState.stockModel.list.isEmpty?AppStrings.addToCart.tr():
                                                              stockState.stockModel.list[0].quantity ==0?
                                                              AppStrings.OutOfStock.tr() :     AppStrings.addToCart.tr(),
                                                              onTap: (){
                                                                print("stockState.stockModel.list ---> ${stockState.stockModel.list}");
                                                                if(stockState.stockModel.list.isEmpty){
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(content: Text(AppStrings.OutOfStock.tr())),
                                                                  );
                                                                }else {
                                                                  if (stockState.stockModel.list[0].quantity != 0) {
                                                                    UserPreferences userPreferences = GetIt
                                                                        .I<
                                                                        UserPreferences>();
                                                                    String userLoginToken = userPreferences
                                                                        .userToken!;
                                                                    if (userLoginToken
                                                                        .trim()
                                                                        .isNotEmpty) {
                                                                      cartBloc.add(
                                                                          CheckCartFetched(
                                                                              userLoginToken));
                                                                    } else {
                                                                      _showLoginDialog(
                                                                          context);
                                                                    }
                                                                  }
                                                                }


                                                              })

                                                      )

                                                  ),
                                                )
                                              ]
                                          )
                                      ),
                                    ))
                              ],
                            );
                          }else{
                            return Container();
                          }

                        },
                      )
                  );
                }else{
                  return Container();
                }

  },
)
        ),
      ),
    );
  }

  String getDescription(){
    String description ="";
    for(int i =0;i<widget.productModel.customAttributes!.length;i++){
      if(widget.productModel.customAttributes![i].attributeCode=="short_description"){
        description = widget.productModel.customAttributes![i].value;
        break;
      }

    }
    return description;
  }
  double getDiscountPrice(){
    String description ="0";
    for(int i =0;i<widget.productModel.customAttributes!.length;i++){
      if(widget.productModel.customAttributes![i].attributeCode=="special_price"){
        description = widget.productModel.customAttributes![i].value;
        break;
      }

    }
    return double.parse(description);
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
}


import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/presentation/main/bloc/check_cart/check_cart_bloc.dart';
import 'package:ozon/presentation/main/bloc/offers_bloc/load_more_state.dart';
import 'package:ozon/presentation/product_details/bloc/product_option_bloc/product_option_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app/app_prefrences.dart';
import '../../../app/constants.dart';
import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../../data/network/helper_query.dart';

import '../../../domain/model/products_model.dart';
import '../../main/bloc/add_to_cart/add_to_cart_bloc.dart';
import '../../main/bloc/cart_bloc/cart_bloc.dart';
import '../../product_details/bloc/caursel_bloc.dart';
import '../../product_details/bloc/caursel_event.dart';
import '../../product_details/bloc/caursel_state.dart';
import '../../product_details/bloc/counter_bloc.dart';
import '../../product_details/bloc/counter_event.dart';
import '../../product_details/bloc/counter_state.dart';
import '../../product_details/bloc/product_option_bloc/product_option_bloc.dart';
import '../../product_details/bloc/product_option_bloc/product_option_event.dart';
import '../../product_details/bloc/stock_info_bloc.dart';
import '../../product_details/widgets/background_item_widget.dart';
import '../../products/bloc/add_item_to_wish_list/add_item_to_wish_list_bloc.dart';
import '../../products/bloc/products_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/common_image_view.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/loading_view.dart';

class ProductDetailsHomeView extends StatefulWidget {
 final String productId;
  const ProductDetailsHomeView({super.key,required this.productId});

  @override
  State<ProductDetailsHomeView> createState() => _ProductDetailsHomeViewState();
}

class _ProductDetailsHomeViewState extends State<ProductDetailsHomeView> {
  ProductsBloc? productsBloc  = instance<ProductsBloc>();
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  HelperQuery helperQuery = HelperQuery();
  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  ProductOptionBloc _productOptionBloc = instance<ProductOptionBloc>();
  AppPreferences appPreferences = GetIt.I<AppPreferences>();
  String sourceCode ="";
  String convertedSourceCode ="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
initView();


  }
  initView()async{
    sourceCode = await appPreferences.getSourceCode();
    convertedSourceCode = normalizeCode(sourceCode);
    userToken = Constants.headerValue;

    map=    helperQuery.buildFilterQueryParams(entityId: widget.productId);

    productsBloc!.add(ProductsFetched(map,userToken));

  }
  Map<String,dynamic> map ={};
  String userToken="";
  CarouselBloc carouselBloc = instance<CarouselBloc>();
  CounterBloc counterBloc = instance<CounterBloc>();
  StockInfoBloc stockInfoBloc = instance<StockInfoBloc>();
  CheckCartBloc checkCartBloc = instance<CheckCartBloc>();

  AddToCartBloc addToCartBloc = instance<AddToCartBloc>();
  int productQuanity = 0;

  @override
  void dispose() {
    carouselBloc.close();
    counterBloc.close();
    stockInfoBloc.close();
    checkCartBloc.close();

    addToCartBloc.close();
    super.dispose();
  }
  List<String> productLabels = [];
  AddItemToWishListBloc addItemToWishListBloc = instance<AddItemToWishListBloc>();

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
        builder: (context, productState) {
          if(productState is ProductsLoading){
            return Container(
              alignment: AlignmentDirectional.center,
              child:    SizedBox(
                  height: 150.w,
                  width: 150.w,
                  child: Lottie.asset(ImageAssets.loadingView)),

            );
          }
          else if(productState is ProductsFailure){
            return Container(
              color: Colors.white,
              alignment: AlignmentDirectional.center,
              child: Text(productState.message,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w500

                ),),
            );
          }
          else if(productState is ProductsSuccess){
            final items = productState.productsModel.items;
            if (items != null && items.isNotEmpty) {
              productLabels = items[0].extensionAttributes?.codazonLabels ?? [];
            } else {
              productLabels = [];
            }
            productLabels = productLabels.toSet().toList();
            return Container(
              color: ColorManager.white,
                width: ScreenUtil().screenWidth,
                child:  Stack(
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
                              children: [
                                Positioned.fill(

                                  child: Container(
                                    height: 200.h,
                                    width: ScreenUtil().screenWidth,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10.w)
                                    ),

                                  ),
                                ),
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
                                              carouselBloc.add(MoveToIndex(index, productState.productsModel.items![0].mediaGalleryEntries!.length));
                                              // controller.silderIndex.value = index;
                                            }),
                                        itemCount: productState.productsModel.items![0].mediaGalleryEntries!.length,
                                        itemBuilder: (context, index, realIndex) {

                                          MediaGalleryEntryModel model = productState.productsModel.items![0].mediaGalleryEntries![index];
                                          return Container(
                                              margin: EdgeInsets.all(10.w),
                                              child: BackgroundItemWidget(model,productState.productsModel.items![0].name!));
                                        });
                                  },
                                ),


                              ]))),
                  Container(
                    height: 6.h,
                    margin: EdgeInsetsDirectional.only(top: 10.h,bottom: 10.w)
                    ,
                    child:productState.productsModel.items![0].mediaGalleryEntries!.length == 0?
                    Container():BlocBuilder<CarouselBloc, CarouselState>(
                      bloc: carouselBloc,
                      builder: (context, state) {
                        return AnimatedSmoothIndicator(
                          activeIndex: state.currentIndex,
                          // activeIndex: controller.silderIndex.value,
                          count:productState.productsModel.items![0].mediaGalleryEntries!.length,
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
                    child:
                    Column(
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
                                        productState.productsModel.items![0].name.toString(),
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
                                                onTap: ()async{
                                                  int quantity = await getQuantity(productState.productsModel.items![0]);
                                                  counterBloc.add(Increment(quantity));
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
                            child: HtmlWidget(getDescription(productState.productsModel.items![0]),

                              textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.gray800,
                                fontSize: 12.sp,

                                fontWeight: FontWeight.w400,
                              ),


                            )),
                        SizedBox(height: 10.h,),
                        Container(
                          child: productState.productsModel.items![0].typeId == "bundle"?
                          Column(
                            children: [
                              Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(AppStrings.bundle.tr(),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: ColorManager.black900,
                                        fontSize: 12.sp,

                                        fontWeight: FontWeight.w500,
                                      ))),
                              SizedBox(height: 10.w,),
                              BlocBuilder<ProductOptionBloc, ProductOptionState>(
                                bloc: _productOptionBloc..add(InitProductOptions(productState.productsModel!.items![0].extensionAttributes!.bundleProductOptions!)),
                                builder: (context, state) {
                                  return ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: state.options.map((option) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(option.title!,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                color: ColorManager.black900,
                                                fontSize: 12.sp,

                                                fontWeight: FontWeight.w500,
                                              )),
                                          ...option.productLinks!.map((link) {
                                            return Theme(
                                              data: Theme.of(context).copyWith(
                                                unselectedWidgetColor: Colors.grey,  // color for unselected radio
                                                radioTheme: RadioThemeData(
                                                  fillColor: MaterialStateProperty.all(ColorManager.primary), // selected radio color
                                                ),
                                              ),
                                              child: RadioListTile<String>(
                                                value: link.id!,
                                                groupValue: state.selectedItems[option.optionId],
                                                title: Text(link.sku!,
                                                    overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                      color: ColorManager.black,
                                                      fontSize: 12.sp,

                                                      fontWeight: FontWeight.normal,
                                                    )),
                                                onChanged: (value) {
                                                  _productOptionBloc.add(
                                                    SelectOptionItem(
                                                      optionId: option.optionId!,
                                                      selectedLinkId: link.id!,
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }).toList()
                                        ],
                                      );
                                    }).toList(),
                                  );
                                },
                              )


                            ],

                          ):productState.productsModel.items![0].typeId == "grouped"?Container(
                            child: Column(
                              children: [
                                Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(AppStrings.bundle.tr(),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: ColorManager.black900,
                                          fontSize: 12.sp,

                                          fontWeight: FontWeight.w500,
                                        ))),
                                SizedBox(height: 10.w,),
                                ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: productState.productsModel.items![0].groupOptions!.map((option) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.grey,  // color for unselected radio
                                        radioTheme: RadioThemeData(
                                          fillColor: MaterialStateProperty.all(ColorManager.primary), // selected radio color
                                        ),
                                      ),
                                      child: RadioListTile<String>(
                                        value: option.position.toString(),
                                        groupValue: option.position.toString(),
                                        title: Text(option.sku!,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: ColorManager.black,
                                              fontSize: 12.sp,

                                              fontWeight: FontWeight.normal,
                                            )),
                                        onChanged: (value) {

                                        },
                                      ),
                                    );
                                  }).toList(),
                                )

                              ],
                            ),
                          )
                          :Container(),
                        )



                      ],
                    ),
                  ),
                  SizedBox(height: 70.w,)




                ]),
          ),
          ),
          Positioned.directional(
          textDirection: Directionality.of(context),
          bottom: 0,
          start: 0,
          end: 0,
          child:     Container(
          padding: EdgeInsets.all(10.w),
          alignment: Alignment.center,
          color: Colors.white,
          child: Row(

          children: [
          Expanded(
          flex:2,
          child: BlocBuilder<CounterBloc, CounterState>(
            bloc: counterBloc,
  builder: (context, counterState) {
              double price = getDiscountPrice(productState.productsModel.items![0]);
              if(price == 0.0){
                price= productState.productsModel.items![0].price! ?? 0;
              }

    return Container(
          alignment: AlignmentDirectional.center,
          child:Text(

          ' ${(price*counterState.count).toStringAsFixed(3)} ${AppStrings.kd.tr()}',
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(
          color: ColorManager.mainBlack,
          fontWeight: FontWeight.w500,
          fontSize: ScreenUtil().setSp(14)),
          ),
          );
  },
),
          ),
          Expanded(
          flex: 3,
          child: BlocListener<CheckCartBloc, CheckCartState>(
          bloc:  checkCartBloc,
          listener: (context, cartState) {
          if(cartState is CheckCartLoading){
          showLoadingDialog(context);

          }
          else
          if(cartState is CheckCartSuccess){
          dismissLoadingDialog();
          Map<String,dynamic> map = {};
          Map<String,dynamic> cartItemMap ={};
          cartItemMap['sku'] = productState.productsModel.items![0].sku;
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

          // stockInfoBloc.add(StockInfoFetched(productState.productsModel.items![0].sku!,userToken));
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
          variant:
          getQuantity(productState.productsModel.items![0]) ==0?ButtonVariant.FillGrayDark:ButtonVariant.FillBlack900 ,

          width: ScreenUtil().screenWidth,
          fontStyle:getQuantity(productState.productsModel.items![0])==0?ButtonFontStyle.whiteSemiBold:getQuantity(productState.productsModel.items![0]) ==0?ButtonFontStyle.blackSemiBold:ButtonFontStyle.whiteSemiBold ,

          text:
          getQuantity(productState.productsModel.items![0])==0?
          AppStrings.OutOfStock.tr() :     AppStrings.addToCart.tr(),
          onTap: ()async{
            int quantity = await getQuantity(productState.productsModel.items![0]);

          if(quantity !=0){
          UserPreferences userPreferences =  GetIt.I<UserPreferences>();
          String  userLoginToken = userPreferences.userToken!;
          if(userLoginToken.trim().isNotEmpty){
          checkCartBloc.add(CheckCartFetched(userLoginToken!));
          }else{

          _showLoginDialog(context);
          }




          }else{
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.OutOfStock.tr())),
          );
          }


          })

          )

          ),
          ),

          ]
          )
          )),
          Positioned.directional(textDirection: Directionality.of(context),
          top:10.w,
          end:10.w,child:    InkWell(
          onTap: (){
          UserPreferences userPreferences =  GetIt.I<UserPreferences>();
          String  userLoginToken = userPreferences.userToken!;
          if(userLoginToken.trim().isNotEmpty){
          addItemToWishListBloc.add(AddItemToWishListFetched(userLoginToken,widget.productId));
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
          child: Container(
          width: 40.w, // Width of the circle
          height: 40.w, // Height of the circle (same as width)
          decoration: BoxDecoration(
          color: Colors.white54, // Background color
          shape: BoxShape.circle, // Makes the container circular


          ),
          child: Center(
          child: Icon(Icons.favorite_border_outlined,size: 20.w,
          color: ColorManager.primary,),
          ),
          ),
          ),
          ),),
          ],
          )
            );

          }else {
            return Container(

            );
          }
        },
        ),
        ),
      ),
    );
  }
  String getDescription(ProductItemModel productModel){
    String description ="";
    for(int i =0;i<productModel.customAttributes!.length;i++){
      if(productModel.customAttributes![i].attributeCode=="meta_description"){
        description = productModel.customAttributes![i].value;
        break;
      }

    }
    print("description ---> ${description}");
    return description;
  }
  double getDiscountPrice(ProductItemModel productModel){
    String description ="0";
    for(int i =0;i<productModel.customAttributes!.length;i++){
      if(productModel.customAttributes![i].attributeCode=="special_price"){
        description = productModel.customAttributes![i].value;
        break;
      }


    }
    return double.parse(description);
  }

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
  String normalizeCode(String input) {
    return input.replaceAll('-', '').toLowerCase();
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

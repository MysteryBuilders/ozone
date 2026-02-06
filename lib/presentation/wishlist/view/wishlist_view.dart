import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/wishlist_model.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';
import 'package:ozon/presentation/wishlist/bloc/wish_list_bloc.dart';
import 'package:ozon/presentation/wishlist/view/wish_list_item.dart';

import '../../../app/user_prefrences.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  WishListBloc wishListBloc = instance<WishListBloc>();
  UserPreferences userPreferences = GetIt.I<UserPreferences>();
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
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
              text: AppStrings.wishList.tr(),
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
          body: Container(
            margin: EdgeInsets.all(20.w),
            child: BlocBuilder<WishListBloc, WishListState>(
              bloc: wishListBloc..add(WishListFetched(userPreferences.userToken!)),
              builder: (context, state) {
                if(state is WishListLoading){
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child:    SizedBox(
                        height: 150.w,
                        width: 150.w,
                        child: Lottie.asset(ImageAssets.loadingView)),
            
                  );
                }else if(state is WishListFailure){
                  return Container(
                    color: Colors.white,
                    alignment: AlignmentDirectional.center,
                    child: Text(state.message,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w500
            
                      ),),
                  );
                }else if(state is WishListSuccess){
                  return  GridView.builder(
            
            
                    // padding: getPadding(left: 20, top: 25, right: 20,
                    //     bottom: 20),
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
            
            
            
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                          childAspectRatio: 3 / 4),
            
            
                      itemCount: state.wishListModel.wishList!.length
                      ,
                      itemBuilder: (context, index) {
            
                        WishListItemsModel model = state.wishListModel.wishList![index];
                        return Container(
                            margin: EdgeInsets.all(5),
                            child: WishListItem(model));
                      });
            
                }else{
                  return Container();
                }
              },
            ),
          ),

        ),
      ),
    );
  }
}

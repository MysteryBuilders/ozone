import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/presentation/main/bloc/create_cart_bloc/create_cart_bloc.dart';
import 'package:ozon/presentation/widgets/loading_view.dart';

import '../../../app/di.dart';
import '../../../app/user_prefrences.dart';
import '../../main/bloc/cart_bloc/cart_bloc.dart';
import '../../main/bloc/cart_local/cart_local_bloc.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/langauge_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_title.dart';

class SuccessPayment extends StatefulWidget {
 final  int OrderId;
  const SuccessPayment({super.key,required this.OrderId});

  @override
  State<SuccessPayment> createState() => _SuccessPaymentState();
}

class _SuccessPaymentState extends State<SuccessPayment> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }
  final CartLocalBloc cartLocalBloc = instance<CartLocalBloc>();

  UserPreferences userPreferences =  GetIt.I<UserPreferences>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetIt.I<CreateCartBloc>().add(CreateCartFetched(userPreferences.userToken!));
    GetIt.I<CartBloc>().add(CartFetched(userPreferences.userToken!));

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
          backgroundColor: ColorManager.gray100,

          body: Container(


            child:
            Stack(

              children: [
                Positioned.fill(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.paymentSuccess.tr(),
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w500
                        ),

                      ),
                      Center(
                        child: SizedBox(
                            height: 400.w,
                            width: 400.w,
                            child: Lottie.asset(JsonAssets.success)),
                      ),
                    ],
                  ),
                ),
                Positioned.directional(textDirection: Directionality.of(context),
                    bottom: 0,
                    start: 0,
                    end: 0,
                    child: Container(
                      width: ScreenUtil().screenWidth,

                      height: 100.w,

                      child: Card(
                        color: Colors.white,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.w), // Top corners radius
                          ),
                        ),
                        elevation: 4, // Set elevation

                        surfaceTintColor: Colors.white,
                    child:     InkWell(
                      onTap: (){

                        cartLocalBloc.add(RemoveCartLocal());
                        Map<String,dynamic> map ={};
                        map['type']= "";
                        map['id']="";
                        Navigator.pushReplacementNamed(context, Routes.mainRoute,arguments: map);


                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          height: 40.w,
                          alignment: AlignmentDirectional.center,
                          width: ScreenUtil().screenWidth,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(20.w)

                          ),

                          child: Text(AppStrings.home.tr(),
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.white,
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.normal
                            ),),
                        ),
                      ),
                    ),

                      ),
                    ))


              ],
            ),
          ),
        ),
      ),
    );
  }
}

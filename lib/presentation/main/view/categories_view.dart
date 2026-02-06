import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/domain/model/category_model.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_bloc.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_event.dart';
import 'package:ozon/presentation/main/bloc/categories_bloc/categories_state.dart';
import 'package:ozon/presentation/main/bloc/categories_home_bloc/categories_home_bloc.dart';
import 'package:ozon/presentation/main/view/widgets/gridticket1_item_widget.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../app/functions.dart';
import '../../../app/user_prefrences.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../../widgets/app_decoration.dart';
import '../../widgets/appbar_iconbutton.dart';
import '../../widgets/appbar_image_1.dart';
import '../../widgets/appbar_title.dart';
import '../../widgets/custom_app_bar.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  CategoriesHomeBloc? _categoriesBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoriesBloc = instance<CategoriesHomeBloc>();
  }
  String userToken ="";

  @override
  Widget build(BuildContext context) {
    // UserPreferences userPreferences =  GetIt.I<UserPreferences>();
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
          backgroundColor: ColorManager.gray100,

          body: BlocBuilder<CategoriesHomeBloc, CategoriesHomeState>(
            bloc: _categoriesBloc!..add(CategoriesHomeFetched(userToken)),
            builder: (context, state) {
              if(state is CategoriesHomeLoading){
                return Container(
                  alignment: AlignmentDirectional.center,
                  child:    SizedBox(
                      height: 150.w,
                      width: 150.w,
                      child: Lottie.asset(ImageAssets.loadingView)),

                );
              }
              else if(state is CategoriesHomeSuccess){

               return Container(
                 margin: EdgeInsets.all(10.w),
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       ListView.separated(
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                           itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){

                              Map<String, dynamic> map = {};
                              map['categoryName'] = AppStrings.category.tr();
                              map['categoryId'] = state.categoryHomeModel.items[index].categoryId;
                              map['title']= AppStrings.category.tr();
                              Navigator.pushNamed(context, Routes.productsRoute,arguments: map);
                              // Navigator.pushNamed(
                              //     context, Routes.productsRoute,
                              //     arguments: map);

                          },
                          child: Container(
                             height: 120.w,
                             width: ScreenUtil().screenWidth,
                             child: Stack(
                               children: [
                                 Positioned.directional(textDirection: Directionality.of(context)
                                     ,top: 0,
                                     bottom: 0,
                                     start: 0,
                                     end: 0,
                                     child:  Container(
                                       height: 120.w,
                                       width: ScreenUtil().screenWidth,
                                       child: CachedNetworkImage(

                                         height: 90.w,



                                         imageUrl:state.categoryHomeModel.items[index].categoryImage,
                                         imageBuilder: (context, imageProvider) => Container(



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


                                         errorWidget: (context, url, error) => SizedBox(
                                           width: 30.w,
                                           height: 30.w,
                                           child: Image.asset(
                                             'assets/images/image_not_found.png',
                                             height: 30.w,
                                             width: 30.w,
                                             fit: BoxFit.contain,
                                           ),
                                         ),

                                       ),
                                     )),

                               ],
                             ),

                           ),
                        );
                       }, separatorBuilder: (context,index){return Container(height: 10.w,);}, itemCount: state.categoryHomeModel.items.length),
                       Container(height: 80.w,)
                     ],
                   ),
                 ),
               );

              }else if(state is CategoriesHomeFailure){
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

              }else{
                return Container(

                );
              }

            },
          ),
        ),
      ),
    );;
  }


}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/functions.dart';
import '../../domain/model/home_screen_model.dart';
import '../main/view/widgets/gridticket1_item_widget.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/langauge_manager.dart';
import '../resources/routes_manager.dart';
import '../widgets/appbar_iconbutton.dart';
import '../widgets/appbar_title.dart';
import 'grid_sub_category_view.dart';

class SubCategoriesHomeView extends StatefulWidget {
 final CategoryComponentHome categoryModel;
  const SubCategoriesHomeView({super.key,required this.categoryModel});

  @override
  State<SubCategoriesHomeView> createState() => _SubCategoriesHomeViewState();
}

class _SubCategoriesHomeViewState extends State<SubCategoriesHomeView> {
  bool isRtl() {
    return context.locale == ARABIC_LOCAL;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: ColorManager.gray100,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 3.w,
        //   title:                    AppbarTitle(
        //     text: "",
        //   ),
        //   leading:
        //   AppbarIconbutton(
        //       svgPath: isRtl()?
        //       ImageAssets.imgArrowright   :ImageAssets.imgArrowleft,
        //       onTap: (){
        //         Navigator.pop(context);
        //       }),
        //
        //
        // ),
        body:   Container(
          margin: EdgeInsets.all(10.w),
          child: ListView.separated(itemBuilder: (context,index){
            return InkWell(
              onTap: (){

                  Map<String, dynamic> map = {};
                  map['categoryName'] = widget.categoryModel!.children[index].name;
                  map['categoryId'] = widget.categoryModel!.children[index].categoryId;
                  map['title']= widget.categoryModel!.children[index].name;
                  // Navigator.pushNamed(
                  //     context, Routes.productsRoute,
                  //     arguments: map);
                  Routes.navigateTo( Routes.productsRoute,arguments: map);

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
                            width: ScreenUtil().screenWidth,
                            height: 90.w,

                            fit: BoxFit.fill,

                            imageUrl:widget.categoryModel!.children[index].image!,
                            imageBuilder: (context, imageProvider) => Container(
                                width: ScreenUtil().screenWidth,


                                decoration: BoxDecoration(



                                  image: DecorationImage(


                                      fit: BoxFit.fill,
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
                    Positioned.directional(textDirection: Directionality.of(context),
                        top: 0,
                        bottom: 0,
                        start: 0,
                        end: 0,
                        child: Center(
                          child: Text(widget.categoryModel!.children[index].name!,
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(17),
                                fontWeight: FontWeight.w500

                            ),),
                        ))
                  ],
                ),

              ),
            );
          }, separatorBuilder: (context,index){return Container(height: 10.w,);}, itemCount: widget.categoryModel!.children.length),
        ),

      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/presentation/main/bloc/count_down_bloc/counter_bloc.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../resources/routes_manager.dart';
import 'home_timer_widget.dart';
class HomeCategoriesWidget extends StatelessWidget {

final List<CategoryComponentHome> categoryComponentDataHome;
final CountdownBloc countdownBloc;
final int time;
  const HomeCategoriesWidget({super.key,required this.categoryComponentDataHome,required this.time,required this.countdownBloc});

  @override
  Widget build(BuildContext context) {
    const int numberOfRows = 2;
    // Calculate the number of columns

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.category.tr(),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: ColorManager.mainBlack,
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w500

              ),),

              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Routes.categoriesRoute);

                },
                child: Text(AppStrings.seeAll.tr(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: ColorManager.primary,
                      fontSize: ScreenUtil().setSp(12),
                      fontWeight: FontWeight.normal

                  ),),
              )

            ],
          ),
        ),
        SizedBox(
          height: 100.w, // Adjust height to fit two rows
          child: ListView.builder(

            itemCount:categoryComponentDataHome[0].children.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: ()
                {

                    Map<String, dynamic> map = {};
                    map['categoryName'] = "";
                    map['categoryId'] = categoryComponentDataHome[0].children[index].categoryId;
                    map['title']=   categoryComponentDataHome[0].children[index].name;

                    Navigator.pushNamed(context, Routes.productsRoute,arguments: map);



                },

                child: Container(
                  width: 70.w,



                  child: Column(
                    children: [
                      Expanded(
                        flex:3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.primary.withAlpha(30),
                            shape: BoxShape.circle,


                          ),
                          alignment: AlignmentDirectional.center,
                          child: CachedNetworkImage(
                            width: 50.w,
                            height: 50.w,



                            imageUrl: categoryComponentDataHome[0].children[index].image,
                            imageBuilder: (context, imageProvider) =>
                                Container(



                                    decoration: BoxDecoration(


                                      image: DecorationImage(



                                          image: imageProvider),
                                    )
                                ),
                            placeholder: (context, url) =>
                                Container(
                                  height: 20,
                                  width: 20,
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
                        ),
                      ),
                      Expanded(flex:2,child: Container(
                        alignment: AlignmentDirectional.center,
                          child: Text(' ${categoryComponentDataHome[0].children[index].name}',
                        textAlign: TextAlign.center,

                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorManager.mainBlack,
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w500
                        ),)))
                    ],
                  ),

                ),
              );
            },
            scrollDirection: Axis.horizontal,  // Make grid scroll horizontally
          ),
        ),
        Container(
          child: time == 0?Container(


          ):Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.w,),
              HomeTimerWidget(time: time,countdownBloc: countdownBloc,),
            ],
          ),
        )
      ],
    );
  }
}

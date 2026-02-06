import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../../domain/model/home_screen_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/values_manager.dart';
import '../../bloc/count_down_bloc/counter_bloc.dart';
import 'home_timer_widget.dart';
class GridViewWidget extends StatelessWidget {
  final List<SliderComponentDataHome> sliderList;
  final int time;
  final CountdownBloc countdownBloc;
  const GridViewWidget({super.key,required this.sliderList,required this.time,required this.countdownBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:     GridView.builder(scrollDirection: Axis.vertical,


            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio:0.7),
            itemCount:sliderList.length,

            itemBuilder: (context,index){
              return
                Container(


                    child:
                    InkWell(
                      onTap: (){
                        Map<String,dynamic> map ={};
                        map['categoryId'] = sliderList[index].categoryId;
                        map['title']= AppStrings.offers.tr();
                        // Navigator.pushNamed(context, Routes.myHomeOffersRoute,arguments: map);
                        Navigator.pushNamed( context,Routes.myHomeOffersRoute,arguments: map);
                      },
                        child: buildItem(sliderList[index],context)));
            },
          ),

        ),
        Container(
          child: time == 0?Container():Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.w,),
              HomeTimerWidget(time: time,countdownBloc: countdownBloc,),
            ],
          ),
        )
      ],
    );
  }

  Widget buildItem(SliderComponentDataHome data, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.w),
      child: SizedBox(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.w),
          child:    CachedNetworkImage(
            width: ScreenUtil().screenWidth,

            fit: BoxFit.fill,
            imageUrl:data.image,
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


        ),
      ),
    );

  }

}

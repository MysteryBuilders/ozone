import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/data/response/home_screen_response.dart';
import 'package:ozon/domain/model/home_screen_model.dart';
import 'package:ozon/presentation/main/bloc/count_down_bloc/counter_bloc.dart';
import 'package:ozon/presentation/main/view/home_widget/home_timer_widget.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


import '../../../../app/di.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../../bloc/carousel_slider_bloc/carousel_slider_bloc.dart';
import '../../bloc/carousel_slider_bloc/carousel_slider_event.dart';
import '../../bloc/carousel_slider_bloc/carousel_slider_state.dart';

class HomeSliderWidget extends StatelessWidget {
  final List<SliderComponentDataHome> sliderList;
  final int time;
  final CountdownBloc countdownBloc;

   HomeSliderWidget({super.key, required this.sliderList,required this.time,required this.countdownBloc});

  @override
  Widget build(BuildContext context) {
    CarouselSLiderBloc    carouselBloc = instance<CarouselSLiderBloc>();
    return Column(
      children: [
        Container(
            child: BlocBuilder<CarouselSLiderBloc, CarouselSLiderState>(
              bloc: carouselBloc,
              builder: (context, state) {
                return Container(
                  width: ScreenUtil().screenWidth,
                  height: 200.w,
                  child: Column(
                    children: [
                      Expanded(
                        flex:1,
                        child: CarouselSlider(
                            items: sliderList
                                .map((banner) =>
                                Stack(
                                  children: [
                                    Positioned.directional(
                                      textDirection: Directionality.of(context),
                                      top: 0,
                                      bottom: 0,
                                      start: 0,
                                      end: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          Map<String,dynamic> map ={};
                                          map['categoryId'] = banner.categoryId;
                                          map['title']= AppStrings.offers.tr();
                                         Navigator.pushNamed(context, Routes.myHomeOffersRoute,arguments: map);

                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.w),
                                            child: CachedNetworkImage(

                                              imageUrl: banner.image,
                                              // Directly apply fit here
                                              placeholder: (context, url) => SizedBox(
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
                                                ),
                                              ),
                                            ),
                                          ),
                                        )


                                      ),
                                    ),

                                  ],
                                ))
                                .toList(),
                            options: CarouselOptions(
                                height: ScreenUtil().screenHeight,
                                autoPlay: true,
                                viewportFraction: 1,
                                aspectRatio: 16 / 9,
                                onPageChanged: (index, reason) {
                                  carouselBloc.add(PageChangedEvent(index));
                                },
                                enableInfiniteScroll: false,
                                enlargeCenterPage: false)),
                      ),
                      Center(
                        child: sliderList.length ==1?
                            Container():
                                      AnimatedSmoothIndicator(
                          activeIndex: state.activeIndex,
                          // activeIndex: controller.silderIndex.value,
                          count:sliderList.length,
                          axisDirection: Axis.horizontal,
                          effect: ScrollingDotsEffect(
                            spacing: 8,
                            activeDotColor:
                            ColorManager.deepOrangeA200,
                            dotColor: ColorManager.gray400,
                            dotHeight: 6.h,
                            dotWidth: 6.w,
                          ),
                        ),
                      )
                    ],
                  ),
                );
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
}

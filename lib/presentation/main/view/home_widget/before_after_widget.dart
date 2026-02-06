import 'package:before_after/before_after.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/app/di.dart';
import 'package:ozon/presentation/main/bloc/before_after_bloc/before_after_bloc.dart';
import 'package:ozon/presentation/main/bloc/before_after_bloc/before_after_state.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../../domain/model/home_screen_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/langauge_manager.dart';
import '../../../resources/values_manager.dart';
import '../../bloc/before_after_bloc/before_after_event.dart';
import '../../bloc/count_down_bloc/counter_bloc.dart';

class BeforeAfterWidget extends StatelessWidget {
  final List<SliderComponentDataHome> sliderList;
  final int time;
  final CountdownBloc countdownBloc;
  const BeforeAfterWidget({super.key,required this.sliderList,required this.time,required this.countdownBloc});

  @override
  Widget build(BuildContext context) {
    bool isRtl() {
      return context.locale == ARABIC_LOCAL;
    }
    BeforeAfterBloc beforeAfterBloc = instance<BeforeAfterBloc>();
    return Column(
      children: [
        Container(
          height: 400.w,
          child: BlocBuilder<BeforeAfterBloc, BeforeAfterState>(
            bloc:beforeAfterBloc,
            builder: (context, state) {
              final value = (state as ValueChangedState).value;
              return SizedBox(
                width: double.infinity,
                height: 400.w,
                child: ClipRRect(

                  child: Stack(
                    children: [
                      Positioned.fill(

                        child: BeforeAfter(
                          value: value,

                          trackColor: Colors.white,
                          thumbColor: Colors.white,
                          direction: SliderDirection.horizontal,
                          before: Stack(
                            children: [

                              Positioned.fill(
                                child: CachedNetworkImage(
                                  width: ScreenUtil().screenWidth,

                                  fit: BoxFit.fill,
                                  imageUrl: isRtl()?sliderList[1].image:sliderList[0].image,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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


                            ],
                          ),
                          after: CachedNetworkImage(
                            width: ScreenUtil().screenWidth,

                            fit: BoxFit.fill,
                            imageUrl: isRtl()?sliderList[0].image:sliderList[1].image,
                            imageBuilder: (context, imageProvider) =>
                                Container(
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
                          onValueChanged: (newValue) {
                            beforeAfterBloc
                                .add(UpdateValue(1-newValue)); // Dispatch event
                          },
                        ),
                      ),
                      Positioned.directional(
                        bottom: 10.w,
                          start: 10.w,
                          end: 10.w,

                          textDirection:Directionality.of(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: AlignmentDirectional.center,
                                width: 50.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(150),
                                    borderRadius: BorderRadius.circular(5.w)
                                ),

                                child: Text(AppStrings.after.tr(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                      color: ColorManager.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.center,
                                width: 50.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: BorderRadius.circular(5.w)
                                ),

                                child: Text(AppStrings.before.tr(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                    color: ColorManager.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),

                            ],
                          ))
                    ],
                  ),
                ),
              );
            },
          ),

        )

      ],
    );
  }
}

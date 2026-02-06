import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/presentation/main/bloc/count_down_bloc/counter_state.dart';
import 'package:ozon/presentation/resources/color_manager.dart';
import 'package:ozon/presentation/resources/strings_manager.dart';

import '../../../../app/di.dart';
import '../../bloc/count_down_bloc/counter_bloc.dart';
import '../../bloc/count_down_bloc/counter_event.dart';
class HomeTimerWidget extends StatefulWidget  {
  final int time;
  CountdownBloc countdownBloc;
   HomeTimerWidget({super.key,required this.time,required this.countdownBloc});

  @override
  State<HomeTimerWidget> createState() => _HomeTimerWidgetState();
}


class _HomeTimerWidgetState extends State<HomeTimerWidget>with AutomaticKeepAliveClientMixin {
   CountdownBloc counterdownBloc =  instance<CountdownBloc>();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counterdownBloc.add(StartCountdown(widget.time));
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CountdownBloc, CountdownState>(
      bloc: counterdownBloc,
  builder: (context, state) {
        print("counterdownBloc");


        if(state.seconds == 0 && state.minutes ==0 && state.hours == 0 && state.days == 0){
          return Container();
        }else {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.w),
              width: ScreenUtil().screenWidth,
              height: 24.h,
              child:Row(
                children: [
                  Expanded(flex:1,child: Container(
                    child: Text(AppStrings.flashSale.tr(),
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: ColorManager.mainBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp
                      ),),
                  )),
                  Expanded(flex:1,child: Container(
                    child: Row(
                      children: [
                        Text(AppStrings.closingIn.tr(),
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ColorManager.secondaryBlack,
                              fontWeight: FontWeight.normal,
                              fontSize: 10.sp
                          ),),
                        Container(
                          width: 23.w,
                          alignment: AlignmentDirectional.center,
                          height: 23.w,
                          decoration: BoxDecoration(
                            color: ColorManager.lightPrimaryBackGround,
                            borderRadius: BorderRadius.circular(4.w),

                          ),

                          child: Text(state.seconds.toString(),
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal

                            ),),
                        ),
                        Container(
                          width: 10.w,
                          alignment: AlignmentDirectional.center,
                          child: Text(":",
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                color: ColorManager.mainBlack,
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.normal
                            ),),
                        ),
                        Container(
                          width: 23.w,
                          alignment: AlignmentDirectional.center,
                          height: 23.w,
                          decoration: BoxDecoration(
                            color: ColorManager.lightPrimaryBackGround,
                            borderRadius: BorderRadius.circular(4.w),

                          ),

                          child: Text(state.minutes.toString(),
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal
                            ),),
                        ),
                        Container(
                          width: 10.w,
                          alignment: AlignmentDirectional.center,
                          child: Text(":",
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                color: ColorManager.mainBlack,
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.normal
                            ),),
                        ),
                        Container(
                          width: 23.w,
                          alignment: AlignmentDirectional.center,
                          height: 23.w,
                          decoration: BoxDecoration(
                            color: ColorManager.lightPrimaryBackGround,
                            borderRadius: BorderRadius.circular(4.w),

                          ),

                          child: Text(state.hours.toString(),
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal
                            ),),
                        ),
                        Container(
                          width: 10.w,
                          alignment: AlignmentDirectional.center,
                          child: Text(":",
                            style: Theme
                                .of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                color: ColorManager.mainBlack,
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.normal
                            ),),
                        ),
                        Container(
                          width: 23.w,
                          alignment: AlignmentDirectional.center,
                          height: 23.w,
                          decoration: BoxDecoration(
                            color: ColorManager.lightPrimaryBackGround,
                            borderRadius: BorderRadius.circular(4.w),

                          ),

                          child: Text(state.days.toString(),
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorManager.primary,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.normal
                            ),),
                        ),


                      ],
                    ),
                  )),

                ],
              )

          );
       }
  },
);
  }

  Map<String, int> convertSeconds(int seconds) {
    int days = seconds ~/ (24 * 3600);
    seconds %= (24 * 3600);
    int hours = seconds ~/ 3600;
    seconds %= 3600;
    int minutes = seconds ~/ 60;
    seconds %= 60;

    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

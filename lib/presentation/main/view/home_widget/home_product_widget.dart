import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/presentation/main/view/home_widget/product_widget.dart';

import '../../../../domain/model/home_screen_model.dart';
import '../../bloc/count_down_bloc/counter_bloc.dart';
import 'home_new_product.dart';
import 'home_timer_widget.dart';
class HomeProductWidget extends StatelessWidget {
 final List<ProductHome> productList;
 final String title;
 final int time;
 final CountdownBloc countdownBloc;

  const HomeProductWidget({super.key,required this.productList,required this.title,required this.time,required this.countdownBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: Theme.of(context).textTheme.displayMedium!.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp
        ),),
        SizedBox(height: 10.w,),
        Container(
          height: 251.h,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
            return Container(width: 150.w,
                child: HomeNewProductWidget(categoryProductsModelObj: productList[index]));
          }, separatorBuilder: (context,index){
            return SizedBox(width: 10.w,);
          }, itemCount: productList.length),
        ),
        Container(
          child: time == 0?Container():Column(
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

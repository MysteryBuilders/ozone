import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/domain/model/home_screen_model.dart';

import '../../../resources/routes_manager.dart';
import '../../bloc/count_down_bloc/counter_bloc.dart';
import 'home_timer_widget.dart';
class HomeBrandsWidget extends StatelessWidget {
 final  List<BrandHome> brandList;
 final String title;
 final int time;
 final CountdownBloc countdownBloc;
  const HomeBrandsWidget({super.key,required this.brandList,
  required this.title,required this.time,required this.countdownBloc});

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
       height: 100.w,
       child: ListView.separated(
           scrollDirection: Axis.horizontal,
           itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                String brandId = brandList[index].url!;
                Map<String, dynamic> map = {};
                print("brandId ---> ${brandId}");

                map['brandId'] = brandId;
                map['brandName'] = brandList[index].label;
                map['title']=  brandList[index].label;
                // Navigator.pushNamed(
                //     context, Routes.brandsProductsRoute, arguments: map);
                Navigator.pushNamed( context,Routes.brandsProductsRoute,arguments: map);
              },
              child: Container(
               width: 100.w,
               decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.w),
                border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1),

               ),
               child: Column(
                children: [
                 Expanded(flex:3,
                     child: Center(
                       child: CachedNetworkImage(
                        width: 50.w,
                        height: 50.w,



                        imageUrl: brandList[index].thumbnail,
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
                 Expanded(flex:2,child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(brandList[index].label,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                   color: Colors.black,
                   fontSize: 10.sp,fontWeight: FontWeight.normal
                  ),),
                 ))

                ],
               ),
              ),
            );
           }, separatorBuilder: (context,index){
            return Container(width: 10.w,);
       }, itemCount: brandList.length),
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

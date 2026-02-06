import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../domain/model/home_screen_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../../bloc/count_down_bloc/counter_bloc.dart';
import 'home_timer_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class StraggledGridViewWidget extends StatelessWidget {
  final List<SliderComponentDataHome> sliderList;
  final int time;
  final CountdownBloc countdownBloc;
  const StraggledGridViewWidget({super.key,required this.sliderList,required this.time,required this.countdownBloc});

  @override
  Widget build(BuildContext context) {



    return Column(
      children: [
        GridView.builder(


          // padding: getPadding(left: 20, top: 25, right: 20,
          //     bottom: 20),
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,



            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: 3 / 3),


            itemCount: sliderList.length
            ,
            itemBuilder: (context, index) {

              SliderComponentDataHome model = sliderList[index];
              return Container(
                  margin: EdgeInsets.all(5),
                  child: buildItem(model ,context, index));
            }),


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

  Widget buildItem(SliderComponentDataHome data, BuildContext context, int index) {

    return GestureDetector(
      onTap: (){
        Map<String, dynamic> map = {};
        map['categoryName'] = "";
        map['categoryId'] = data.categoryId;
        map['title']= AppStrings.category.tr();
        // Navigator.pushNamed(
        //     context, Routes.productsRoute,
        //     arguments: map);

        Navigator.pushNamed( context,Routes.productsRoute,arguments: map);
      },
      child: SizedBox(

        child: Container(



          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.w),
            child:    CachedNetworkImage(

          

              imageUrl:data.image,
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
          
          
          ),
        ),
      ),
    );

  }


}
class DynamicWidthGridDelegate extends SliverGridDelegate {
  final List<double> itemWidths;
  final double spacing;

  DynamicWidthGridDelegate({
    required this.itemWidths,
    this.spacing = 8.0,
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    return _DynamicWidthGridLayout(
      constraints: constraints,
      itemWidths: itemWidths,
      spacing: spacing,
    );
  }

  @override
  bool shouldRelayout(DynamicWidthGridDelegate oldDelegate) {
    return itemWidths != oldDelegate.itemWidths || spacing != oldDelegate.spacing;
  }
}
class _DynamicWidthGridLayout extends SliverGridLayout {
  final SliverConstraints constraints;
  final List<double> itemWidths;
  final double spacing;

  List<SliverGridGeometry> geometries = [];

  _DynamicWidthGridLayout({
    required this.constraints,
    required this.itemWidths,
    required this.spacing,
  }) {
    _calculateItemPositions();
  }

  void _calculateItemPositions() {
    double x = 0.0;
    double y = 0.0;
    double rowHeight = 0.0;

    for (int i = 0; i < itemWidths.length; i++) {
      final double itemWidth = itemWidths[i];
      final double itemHeight = 200.0; // Use your dynamic height if needed

      if (x + itemWidth > constraints.crossAxisExtent) {
        // Move to next row
        x = 0.0;
        y += rowHeight + spacing;
        rowHeight = 0.0;
      }

      geometries.add(
        SliverGridGeometry(
          scrollOffset: y,
          crossAxisOffset: x,
          mainAxisExtent: itemHeight,
          crossAxisExtent: itemWidth,
        ),
      );

      x += itemWidth + spacing;
      rowHeight = itemHeight;
    }
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    return geometries[index];
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    for (int i = 0; i < geometries.length; i++) {
      if (geometries[i].scrollOffset + geometries[i].mainAxisExtent > scrollOffset) {
        return i;
      }
    }
    return geometries.length - 1;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    for (int i = geometries.length - 1; i >= 0; i--) {
      if (geometries[i].scrollOffset <= scrollOffset) {
        return i;
      }
    }
    return 0;
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    if (geometries.isEmpty) return 0.0;
    final lastGeometry = geometries.last;
    return lastGeometry.scrollOffset + lastGeometry.mainAxisExtent;
  }
}



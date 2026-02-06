
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

import '../../app/constants.dart';
import '../resources/color_manager.dart';
import '../resources/common_image_view.dart';

class ZoomView extends StatelessWidget {
  final String url;
  const ZoomView({super.key,required this.url});

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: (){
       FocusManager.instance.primaryFocus?.unfocus();
     },
     child: PopScope(
       canPop: false,
       child: Scaffold(
         backgroundColor: ColorManager.white,
         body: SafeArea(child:
         Stack(
           children: [
             Container(
               color: ColorManager.white,
               width: ScreenUtil().screenWidth,
               height: ScreenUtil().screenHeight,
               alignment: AlignmentDirectional.center,
               child: PhotoView(
                 backgroundDecoration: BoxDecoration(
                   color: ColorManager.white,
                 ),
                 imageProvider: NetworkImage(getImage(url)),
                 minScale: PhotoViewComputedScale.contained,
                 maxScale: PhotoViewComputedScale.covered * 2,
               ),
             ),
             Positioned.directional(textDirection: Directionality.of(context),
                 top: 10.w,
                 end: 10.w,
                 child: FloatingActionButton(onPressed: (){
                   Navigator.pop(context);
                 },
                 backgroundColor: ColorManager.primary,
                   mini: true, // Make it smaller for top positioning
                   child: Icon(Icons.close,color: Colors.white,),
                 ))
           ],
         )),
       ),
     ),
   );
  }
  String getImage(String imgurl){
    String imageLink ="";


    if(imgurl.contains("http")){
      imageLink = imgurl;


    }else{
      imageLink = getProductImageUrlByName(Constants.domain, imgurl);


    }
    return imageLink;

  }
  String getProductImageUrlByName(domain, imageName) {
    return '$domain/pub/media/catalog/product/$imageName';
  }
}

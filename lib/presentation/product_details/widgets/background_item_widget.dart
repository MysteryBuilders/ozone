import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/app/app.dart';
import 'package:ozon/presentation/resources/routes_manager.dart';
import 'package:ozon/presentation/zoom_view/zoom_view.dart';

import '../../../app/constants.dart';

import '../../../domain/model/products_model.dart';
import '../../resources/common_image_view.dart';

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class BackgroundItemWidget extends StatelessWidget {
  BackgroundItemWidget(this.model,this.title);

  MediaGalleryEntryModel model ;
  String title;



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Map<String,dynamic> map ={};
        map['url']= model.file;
        map['title']= title;

        // Navigator.pushNamed(context, Routes.zoomRoute,arguments: map);
        Navigator.pushNamed( context,Routes.zoomRoute,arguments: map);
      },
      child: CommonImageView(
                                                url:getImage(model.file!),

                                                    fit: BoxFit.contain,
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

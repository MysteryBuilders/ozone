import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ozon/presentation/resources/color_manager.dart';

import '../../widgets/app_decoration.dart';



class ForwardArrow extends StatelessWidget {
  const ForwardArrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
                                      height: 26.w,
                                      width: 26.w,
                                      decoration: AppDecoration
                                          .fillprimary63
                                          .copyWith(
                                              borderRadius:
                                                  BorderRadiusStyle
                                                      .circleBorder12),
                                      child: Icon(Icons.arrow_forward_ios_rounded,
                                      color: ColorManager.primary,
                                      size: 16,
                      
                                      )
                                                      
                                                      );
                              
  }
}
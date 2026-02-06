import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';


import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/values_manager.dart';

Widget getPopUpDialog(BuildContext context, List<Widget> children) {
  return Dialog(

    elevation: AppSize.s1_5,
    backgroundColor: Colors.transparent,
    child: Container(





      child: _getDialogContent(context, children),
    ),
  );
}

Widget _getDialogContent(BuildContext context, List<Widget> children) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children,
  );
}

Widget _getItemsColumn(List<Widget> children) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: children,
  );
}

Widget getAnimatedImage(String animationName) {
  return SizedBox(
      height: 150.w,
      width: 150.w,
      child: Lottie.asset(ImageAssets.loadingView));
}

Widget getMessage(String message) {
  return Center(
    child: Padding(
      padding:  EdgeInsets.all(AppPadding.p8),
      child: Text(
        message,
        style: getRegularStyle(
            color: ColorManager.black, fontSize: FontSize.s18),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget getRetryButton(String buttonTitle, BuildContext context) {
  return Center(
    child: Padding(
      padding:  EdgeInsets.all(AppPadding.p18),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                // if (stateRendererType ==
                //     StateRendererType.fullScreenErrorState) {
                //   print("retry");
                //   // call retry function
                //   retryActionFunction.call();
                // } else {
                //
                //   print("pop up");
                //   Navigator.pop(context);
                //   // popup error state
                //   // Navigator.of(context).pop();
                //
                // }
                Navigator.pop(context);

              },
              child: Text(buttonTitle))),
    ),
  );
}
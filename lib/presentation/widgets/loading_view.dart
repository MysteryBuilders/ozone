
import 'package:flutter/material.dart';
import 'package:ozon/app/constants.dart';
import 'package:ozon/presentation/widgets/view_helper.dart';


import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
class LoadingStates extends StatelessWidget {
  const LoadingStates({super.key});

  @override
  Widget build(BuildContext context) {
    return  getPopUpDialog(
        context, [getAnimatedImage(JsonAssets.loading)]);;
  }

}
late BuildContext dialogContext;
void showLoading(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  getPopUpDialog(
          context, [getAnimatedImage("assets/images/loading_medecine.json")]);
    },
  );
}
void showLoadingView(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return  getPopUpDialog(
          context, [getAnimatedImage("assets/images/loading_medecine.json")]);
    },
  );
}
void showLoadingDialog(BuildContext context) {
  // showDialog(
  //   context: context,
  //   barrierDismissible: false,
  //   builder: (BuildContext context) {
  //     return  getPopUpDialog(
  //         context, [getAnimatedImage("assets/images/loading_medecine.json")]);
  //   },
  // );

    showDialog(
      context: context, // Use the overlay context of the NavigatorState
      barrierDismissible: false, // Prevent outside dismissal
      builder: (BuildContext context) {
        dialogContext = context;
        return getPopUpDialog(
          dialogContext,
          [getAnimatedImage(JsonAssets.loading)],
        );
      },
    );
  
}
void dismissLoadingDialog() {
  if (Navigator.canPop(dialogContext)) {
    Navigator.of(dialogContext).pop(); // Dismiss only the dialog
  } else {
    print("No dialog to dismiss!");
  }
}



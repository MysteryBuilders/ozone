import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ozon/presentation/main/bloc/user_bloc/user_bloc.dart';
import 'package:ozon/presentation/main/view/widgets/profile_guest_view.dart';
import 'package:ozon/presentation/main/view/widgets/profile_user_view.dart';

import '../../../app/constants.dart';
import '../../../app/user_prefrences.dart';
import '../../resources/color_manager.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String userToken ="";

  @override
  Widget build(BuildContext context) {
    UserPreferences userPreferences =  GetIt.I<UserPreferences>();
    if(userPreferences.userToken!.isEmpty){
      userToken = "";
    }else{
      userToken = userPreferences.userToken!;
    }
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: ColorManager.gray100,
          body: userToken ==""?ProfileGuestView():ProfileUserView(),
        ),
      ),
    );;
  }
}

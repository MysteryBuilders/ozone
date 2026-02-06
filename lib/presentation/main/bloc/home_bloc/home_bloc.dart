import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:ozon/domain/usecases/home_use_case.dart';
import 'package:ozon/presentation/resources/assets_manager.dart';
import 'dart:convert';
 // Import your model
import '../../../../domain/model/home_model.dart';
import 'home_event.dart'; // Import the event class
import 'home_state.dart'; // Import the state class

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase homeUseCase;


  HomeBloc(this.homeUseCase) : super(HomeInitial()) {
    on<HomeFetched>((event, emit) async {
      emit(HomeLoading());
      (await homeUseCase.execute(HomeUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(HomeFailure(message: failure.message)) ;
        },
            (response) async {




          emit(HomeSuccess(screenHome: response));



        },
      );

    });

  }

}

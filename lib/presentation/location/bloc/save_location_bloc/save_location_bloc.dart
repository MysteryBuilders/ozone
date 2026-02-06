import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ozon/domain/model/location_model.dart';
import 'package:ozon/domain/usecases/location_use_case.dart';

part 'save_location_event.dart';
part 'save_location_state.dart';

class SaveLocationBloc extends Bloc<SaveLocationEvent, SaveLocationState> {
  LocationUseCase locationUseCase;
  SaveLocationBloc(this.locationUseCase) : super(SaveLocationInitial()) {
    on<SaveLocationFetched>((event, emit) async {
      emit(SaveLocationLoading());
      (await locationUseCase.execute(LocationUseCaseInput(event.map,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(SaveLocationFailure(message: failure.message)) ;
        },
            (response) async {




          emit(SaveLocationSuccess(locationModel: response));



        },
      );

    });
  }
}

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/app_version_model.dart';
import 'package:ozon/domain/usecases/app_versions_use_case.dart';

part 'app_versions_event.dart';
part 'app_versions_state.dart';

class AppVersionsBloc extends Bloc<AppVersionsEvent, AppVersionsState> {
  final AppVersionsUseCase appVersionsUseCase;


  AppVersionsBloc(this.appVersionsUseCase) : super(AppVersionsInitial()) {
    on<AppVersionsFetched>((event, emit) async {
      emit(AppVersionsLoading());
      (await appVersionsUseCase.execute(AppVersionsUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(AppVersionsStateFailure(message: failure.message)) ;
        },
            (response) async {




          emit(AppVersionsSuccess(appVersionModel: response));



        },
      );

    });

  }
}

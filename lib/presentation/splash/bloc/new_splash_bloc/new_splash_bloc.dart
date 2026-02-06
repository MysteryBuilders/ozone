import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/splash_model.dart';
import 'package:ozon/domain/usecases/splash_use_case.dart';

part 'new_splash_event.dart';
part 'new_splash_state.dart';

class NewSplashBloc extends Bloc<NewSplashEvent, NewSplashState> {
  final SplashUseCase splashUseCase;
   SplashModel? splashModel ;


  NewSplashBloc(this.splashUseCase) : super(NewSplashInitial()) {
    on<NewSplashFetched>((event, emit) async {
      emit(NewSplashLoading());
      (await splashUseCase.execute(SplashUseCaseInput())).fold(
            (failure) {

          print("failture ---> $failure");
          emit(NewSplashFailure(message: failure.message)) ;
        },
            (response) async {
              splashModel = response;




          emit(NewSplashSuccess(splashModel: response,isSplashFinishedLoading: false));



        },
      );

    });
    on<SplashTimeoutFinished>((event, emit) {
      emit(NewSplashSuccess(splashModel: splashModel!,isSplashFinishedLoading: true));
    });

  }
}

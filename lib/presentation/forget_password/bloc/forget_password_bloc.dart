import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/forget_password_usecase.dart';

import 'forget_password_event.dart';
import 'forget_password_state.dart';



class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;

  ForgetPasswordBloc(this.forgetPasswordUseCase) : super(ForgetPasswordInitial()) {
    on<ForgetPasswordButtonPressed>((event, emit) async {
      emit(ForgetPasswordLoading());
      (await forgetPasswordUseCase.execute(ForgetPasswordUseCaseInput(event.email,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(ForgetPasswordFailure(message: failure.message)) ;
        },
            (response) async {




          emit(ForgetPasswordSuccess(success: response));



        },
      );

    });
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozon/domain/usecases/login_usecase.dart';

import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      (await loginUseCase.execute(LoginCaseInput(event.email,event.password,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(LoginFailure(message: failure.message)) ;
        },
            (response) async {




          emit(LoginSuccess(newLoginModel: response));



        },
      );

    });
  }
}
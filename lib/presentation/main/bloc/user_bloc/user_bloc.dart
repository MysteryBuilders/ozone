import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/user_info_model.dart';
import 'package:ozon/domain/usecases/user_info_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserInfoUseCase userInfoUseCase;

  UserBloc(this.userInfoUseCase) : super(UserInitial()) {
    on<UserInfoFetched>((event, emit) async {
      emit(UserLoading());
      (await userInfoUseCase.execute(UserInfoUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(UserFailure(message: failure.message)) ;
        },
            (response) async {




          emit(UserSuccess(userInfoModel: response));



        },
      );

    });
  }

}

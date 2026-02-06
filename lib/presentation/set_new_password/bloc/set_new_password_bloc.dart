import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/update_password_use_case.dart';

part 'set_new_password_event.dart';
part 'set_new_password_state.dart';

class SetNewPasswordBloc extends Bloc<SetNewPasswordEvent, SetNewPasswordState> {
  final UpdatePasswordUseCase updatePasswordUseCase;

  SetNewPasswordBloc(this.updatePasswordUseCase) : super(SetNewPasswordInitial()) {
    on<UpdatePasswordButtonPressed>((event, emit) async {
      emit(SetNewPasswordLoading());
      (await updatePasswordUseCase.execute(UpdatePasswordUseCaseInput(event.newPassword,event.confirmNewPassword,event.currentPassword,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(SetNewPasswordFailure(message: failure.message)) ;
        },
            (response) async {




          emit(SetNewPasswordSuccess(isSuccess: response));



        },
      );

    });
  }

}

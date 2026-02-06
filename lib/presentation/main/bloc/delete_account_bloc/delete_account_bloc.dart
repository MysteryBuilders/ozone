import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/delete_account_use_case.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccountUseCase deleteAccountUseCase;

  DeleteAccountBloc(this.deleteAccountUseCase) : super(DeleteAccountInitial()) {
    on<DeleteAccountButtonPressed>((event, emit) async {
      emit(DeleteAccountLoading());
      (await deleteAccountUseCase.execute(DeleteAccountUseCaseInput(event.userId,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(DeleteAccountFailure(message: failure.message)) ;
        },
            (response) async {




          emit(DeleteAccountSuccess(success: response));



        },
      );

    });
  }

}

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/delete_address_use_case.dart';

part 'delete_address_event.dart';
part 'delete_address_state.dart';

class DeleteAddressBloc extends Bloc<DeleteAddressEvent, DeleteAddressState> {
  final DeleteAddressUseCase deleteAddressUseCase;

  DeleteAddressBloc(this.deleteAddressUseCase) : super(DeleteAddressInitial()) {
    on<DeleteAddressButtonPressed>((event, emit) async {
      emit(DeleteAddressLoading());
      (await deleteAddressUseCase.execute(DeleteAddressUseCaseInput(event.itemId,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(DeleteAddressFailure(message: failure.message)) ;
        },
            (response) async {




          emit(DeleteAddressSuccess(success: response));



        },
      );

    });
  }

}

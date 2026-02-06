import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/delete_coupoun_use_case.dart';

part 'delete_coupoun_event.dart';
part 'delete_coupoun_state.dart';

class DeleteCoupounBloc extends Bloc<DeleteCoupounEvent, DeleteCoupounState> {
  final DeleteCoupounUseCase deleteCoupounUseCase;

  DeleteCoupounBloc(this.deleteCoupounUseCase) : super(DeleteCoupounInitial()) {
    on<DeleteCoupounButtonPressed>((event, emit) async {
      emit(DeleteCoupounLoading());
      (await deleteCoupounUseCase.execute(DeleteCoupounUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(DeleteCoupounFailure(message: failure.message)) ;
        },
            (response) async {




          emit(DeleteCoupounSuccess(success: response));



        },
      );

    });
  }

}

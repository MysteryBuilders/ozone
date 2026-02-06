import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/check_out_model.dart';
import 'package:ozon/domain/usecases/check_out_use_case.dart';

part 'check_out_event.dart';
part 'check_out_state.dart';

class CheckOutBloc extends Bloc<CheckOutEvent, CheckOutState> {
  final CheckOutUseCase checkOutUseCase;

  CheckOutBloc(this.checkOutUseCase) : super(CheckOutInitial()) {
    on<CheckOutFetched>((event, emit) async {
      emit(CheckOutLoading());
      (await checkOutUseCase.execute(CheckOutUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(CheckOutFailure(message: failure.message)) ;
        },
            (response) async {




          emit(CheckOutSuccess(checkOutModel: response));



        },
      );

    });
  }

}

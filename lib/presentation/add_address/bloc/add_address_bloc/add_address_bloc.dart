import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/add_address_use_Case.dart';

import '../../../../domain/model/adresses_model.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddAddressUseCase addAddressUseCase;

  AddAddressBloc(this.addAddressUseCase) : super(AddAddressInitial()) {
    on<AddAddressFetched>((event, emit) async {
      emit(AddAddressLoading(index: event.index));
      (await addAddressUseCase.execute(AddAddressUseCaseInput(event.map,event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(AddAddressFailure(message: failure.message,index: event.index)) ;
        },
            (response) async {




          emit(AddAddressSuccess(customerDomain: response,index: event.index));



        },
      );

    });
  }

}

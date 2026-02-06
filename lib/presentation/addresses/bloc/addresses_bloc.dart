import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/model/adresses_model.dart';
import 'package:ozon/domain/usecases/address_use_case.dart';

part 'addresses_event.dart';
part 'addresses_state.dart';

class AddressesBloc extends Bloc<AddressesEvent, AddressesState> {
  final AddressUseCase addressUseCase;

  AddressesBloc(this.addressUseCase) : super(AddressesInitial()) {
    on<AddressesFetched>((event, emit) async {
      emit(AddressesLoading());
      (await addressUseCase.execute(AddressUseCaseInput(event.authorization))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(AddressesFailure(message: failure.message)) ;
        },
            (response) async {




          emit(AddressesSuccess(customerDomain: response));



        },
      );

    });
  }
}

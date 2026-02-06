import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ozon/domain/usecases/contact_us_use_case.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  final ContactUsUseCase contactUsUseCase;

  ContactUsBloc(this.contactUsUseCase) : super(ContactUsInitial()) {
    on<ContactUsFetched>((event, emit) async {
      emit(ContactUsLoading());
      (await contactUsUseCase.execute(ContactUsUseCaseInput(event.map))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(ContactUsFailure(message: failure.message)) ;
        },
            (response) async {




          emit(ContactUsSuccess(message: response));



        },
      );

    });
  }

}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/model/generate_invoice_model.dart';
import '../../../domain/usecases/generat_invoice_use_case.dart';

part 'generate_invoice_event.dart';
part 'generate_invoice_state.dart';

class GenerateInvoiceBloc extends Bloc<GenerateInvoiceEvent, GenerateInvoiceState> {
  final GenerateInvoiceUseCase generateInvoiceUseCase;

  GenerateInvoiceBloc(this.generateInvoiceUseCase) : super(GenerateInvoiceInitial()) {
    on<GenerateInvoiceFetched>((event, emit) async {
      emit(GenerateInvoiceLoading());
      (await generateInvoiceUseCase.execute(GeneratInvoiceUseCaseInput(event.authoriztion,
          event.invoiceValue,event.customerName,event.countryCode))).fold(
            (failure) {

          print("failture ---> $failure");
          emit(GenerateInvoiceFailure(message: failure.message)) ;
        },
            (response) async {




          emit(GenerateInvoiceSuccess(list: response));



        },
      );

    });
  }
}

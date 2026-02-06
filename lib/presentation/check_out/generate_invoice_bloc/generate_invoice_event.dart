part of 'generate_invoice_bloc.dart';

sealed class GenerateInvoiceEvent extends Equatable {
  const GenerateInvoiceEvent();
}

class GenerateInvoiceFetched extends GenerateInvoiceEvent {

 final  String authoriztion;
 final String invoiceValue;
 final String customerName;
 final String countryCode;


  const GenerateInvoiceFetched({required this.authoriztion,required this.invoiceValue,required this.customerName,required this.countryCode});

  @override
  List<Object> get props => [authoriztion,invoiceValue,customerName,countryCode];
}
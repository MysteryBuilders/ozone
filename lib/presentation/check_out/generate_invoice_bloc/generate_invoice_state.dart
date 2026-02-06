part of 'generate_invoice_bloc.dart';

sealed class GenerateInvoiceState extends Equatable {
  const GenerateInvoiceState();
}

final class GenerateInvoiceInitial extends GenerateInvoiceState {
  @override
  List<Object> get props => [];
}

class GenerateInvoiceLoading extends GenerateInvoiceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GenerateInvoiceSuccess extends GenerateInvoiceState {
  final List<dynamic> list;

  const GenerateInvoiceSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class GenerateInvoiceFailure extends GenerateInvoiceState {
  final String message;

  const GenerateInvoiceFailure({required this.message});

  @override
  List<Object> get props => [message];
}
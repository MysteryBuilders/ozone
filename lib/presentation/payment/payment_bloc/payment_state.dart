import 'package:myfatoorah_flutter/MFModels.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentMethodsLoaded extends PaymentState {
  final List<MFPaymentMethod> methods;
  final String message;
  final int successType;
  PaymentMethodsLoaded(this.methods,this.message,this.successType);
}


abstract class PaymentEvent {}

class FetchPaymentMethods extends PaymentEvent {
  final double amount;
  FetchPaymentMethods(this.amount);
}

class ExecuteSelectedPayment extends PaymentEvent {
  final double amount;
  final int methodId;
  ExecuteSelectedPayment(this.amount, this.methodId);
}

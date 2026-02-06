part of 'contact_us_bloc.dart';

sealed class ContactUsState extends Equatable {
  const ContactUsState();
}

final class ContactUsInitial extends ContactUsState {
  @override
  List<Object> get props => [];
}

class ContactUsLoading extends ContactUsState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class ContactUsSuccess extends ContactUsState {
  final String message;

  const ContactUsSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ContactUsFailure extends ContactUsState {
  final String message;

  const ContactUsFailure({required this.message});

  @override
  List<Object> get props => [message];
}


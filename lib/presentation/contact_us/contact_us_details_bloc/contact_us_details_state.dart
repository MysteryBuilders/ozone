part of 'contact_us_details_bloc.dart';

sealed class ContactUsDetailsState extends Equatable {
  const ContactUsDetailsState();
}

final class ContactUsDetailsInitial extends ContactUsDetailsState {
  @override
  List<Object> get props => [];
}
class ContactUsDetailsLoading extends ContactUsDetailsState {
  @override
  // TODO: implement props
  List<Object?> get props => [Random().nextDouble()];
}

class ContactUsDetailsSuccess extends ContactUsDetailsState {
  final ContactUsModel contactUsModel;

  const ContactUsDetailsSuccess({required this.contactUsModel});

  @override
  List<Object> get props => [contactUsModel];
}

class ContactUsDetailsFailure extends ContactUsDetailsState {
  final String message;

  const ContactUsDetailsFailure({required this.message});

  @override
  List<Object> get props => [message];
}
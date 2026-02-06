part of 'contact_us_details_bloc.dart';

sealed class ContactUsDetailsEvent extends Equatable {
  const ContactUsDetailsEvent();
}
class ContactUsDetailsFetched extends ContactUsDetailsEvent {
  final String authorization;


  const ContactUsDetailsFetched(this.authorization);

  @override
  List<Object> get props => [Random().nextDouble(),authorization];
}
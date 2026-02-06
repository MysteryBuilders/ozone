part of 'contact_us_bloc.dart';

sealed class ContactUsEvent extends Equatable {
  const ContactUsEvent();
}

class ContactUsFetched extends ContactUsEvent {
  final Map<String,dynamic> map;


  const ContactUsFetched(this.map);

  @override
  List<Object> get props => [Random().nextDouble(),map];
}
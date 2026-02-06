class ContactUsDataModel{

  final String contactId;


  final String email;




  final String phone;

  final String address;

  final String latitude;

  final String longitude;
  ContactUsDataModel({required this.contactId,required this.email,required this.phone,
  required this.address,required this.latitude,required this.longitude});
}
class ContactUsModel{
  List<ContactUsDataModel>? contactUsList;
  ContactUsModel({required this.contactUsList});
}
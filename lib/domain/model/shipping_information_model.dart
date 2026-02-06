import 'package:ozon/domain/model/check_out_model.dart';

class ShippingInformationModel {
  final List<PaymentMethodInformationModel> paymentMethods;
  final CheckOutModel checkOutModel;


  ShippingInformationModel({required this.paymentMethods,required this.checkOutModel});

  }
class PaymentMethodInformationModel {
  final String code;
  final String title;

  PaymentMethodInformationModel({required this.code, required this.title});

  }

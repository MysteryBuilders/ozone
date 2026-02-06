import 'package:ozon/domain/model/generate_invoice_model.dart';

import '../response/generate_invoice_response.dart';

extension GenerateInvoiceResponseMapper on GenrateInvoiceResponse?{
  List<dynamic> get invoices {
    return (this?.items
        ?.map((childResponse) => childResponse.toDomain()) ??
        const Iterable.empty())
        .cast<dynamic>()
        .toList();
  }
  GenerateInvoiceModel toDomain(){
    return GenerateInvoiceModel(
        invoices
    );

  }

}
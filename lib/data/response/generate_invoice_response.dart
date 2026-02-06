import 'package:json_annotation/json_annotation.dart';
part 'generate_invoice_response.g.dart';
@JsonSerializable()
class GenrateInvoiceResponse {
  final List<dynamic> items;

  GenrateInvoiceResponse({required this.items});




  factory GenrateInvoiceResponse.fromJson(Map<String, dynamic> json) => _$GenrateInvoiceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenrateInvoiceResponseToJson(this);

}

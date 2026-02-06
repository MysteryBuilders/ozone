import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/group_option_response.dart';
import 'package:ozon/domain/model/group_options_model.dart';

extension GroupOptionResponseMapper on GroupOptionResponse? {
  GroupOptionsModel toDomain() {
    return GroupOptionsModel(
      sku: this?.sku.orEmpty() ?? Constants.empty,
      linkType: this?.linkType.orEmpty() ?? Constants.empty,
      linkedProductSku: this?.linkedProductSku.orEmpty() ?? Constants.empty,
      linkedProductType: this?.linkedProductType.orEmpty() ?? Constants.empty,
      position: this?.position.orZero() ?? Constants.zero,
      extensionAttributesModel: this?.extensionAttributes?.toDomain(),
    );
  }
}

extension GroupOptionListResponseMapper on List<GroupOptionResponse>? {
  List<GroupOptionsModel> toDomain() {
    return (this?.map((response) => response.toDomain()) ?? const Iterable.empty())
        .cast<GroupOptionsModel>()
        .toList();
  }
}

extension ExtensionAttributesMapper on ExtensionAttributes? {
  ExtensionAttributesModel toDomain() {
    return ExtensionAttributesModel(
      qty: this?.qty.orZero() ?? Constants.zero,
    );
  }
}
class CountryModel{

  String? id;

  String? twoLetterAbbreviation;

  String? threeLetterAbbreviation;

  String? fullNameLocale;

  String? fullNameEnglish;
  ExtensionAttributes? extensionAttributes;
  CountryModel(this.id,this.twoLetterAbbreviation,this.threeLetterAbbreviation,this.fullNameLocale,this.fullNameEnglish,this.extensionAttributes);

  /// Convert `CountryModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'twoLetterAbbreviation': twoLetterAbbreviation,
      'threeLetterAbbreviation': threeLetterAbbreviation,
      'fullNameLocale': fullNameLocale,
      'fullNameEnglish': fullNameEnglish,
      'extension_attributes':extensionAttributes?.toJson()
    };
  }

  /// Create `CountryModel` from JSON
  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      json['id'] as String?,
      json['twoLetterAbbreviation'] as String?,
      json['threeLetterAbbreviation'] as String?,
      json['fullNameLocale'] as String?,
      json['fullNameEnglish'] as String?,
      json['extension_attributes'] != null
          ? ExtensionAttributes.fromJson(json['extension_attributes'])
          : null,
    );
  }
}
class ExtensionAttributes {
  String? image;
  ExtensionAttributes(this.image);
  Map<String, dynamic> toJson() {
    return {
      'image': image,

    };
  }
  factory ExtensionAttributes.fromJson(Map<String, dynamic> json) {
    return ExtensionAttributes(
      json['image'] as String?,
    );
  }
}
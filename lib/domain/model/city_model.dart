class CityModel{
  String? entityId;
  String? entityName;
  String? cityName;
  CityModel(this.entityId,this.entityName,this.cityName);
  /// Convert CityModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'entityId': entityId,
      'entityName': entityName,
      'cityName': cityName,
    };
  }

  /// Create CityModel from JSON
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      json['entityId'] as String?,
      json['entityName'] as String?,
      json['cityName'] as String?,
    );
  }

}
class CitiesModel{
  List<CityModel>? citiesModel;
  CitiesModel(this.citiesModel);
}

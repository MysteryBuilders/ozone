class StateModel{
  String? stateId;
  String? name;
  StateModel(this.stateId,this.name);
  /// Convert `StateModel` to JSON
  Map<String, dynamic> toJson() {
    return {
      'stateId': stateId,
      'name': name,
    };
  }

  /// Create `StateModel` from JSON
  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      json['stateId'] as String?,
      json['name'] as String?,
    );
  }
}
class StatesModel{
  List<StateModel>? statesModel;
  StatesModel(this.statesModel);
}
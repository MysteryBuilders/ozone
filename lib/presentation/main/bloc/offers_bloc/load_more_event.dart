abstract class LoadMoreEvent {}

class LoadInitialData extends LoadMoreEvent {
  Map<String,dynamic> map;
  String authorization;
  LoadInitialData(this.map,this.authorization);

  @override
  List<Object> get props => [map];
}

class LoadMoreData extends LoadMoreEvent {
  Map<String,dynamic> map;
  String authorization;
  LoadMoreData(this.map,this.authorization);

  @override
  List<Object> get props => [map];
}

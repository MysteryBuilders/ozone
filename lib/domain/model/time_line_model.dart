class TimeLineModel {
  final String? status;
  final bool? reached;

  TimeLineModel(this.status, this.reached);
}
class TimeLine {
  List<TimeLineModel> timeline;
  TimeLine({required this.timeline});
}
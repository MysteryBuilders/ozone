import 'package:ozon/app/constants.dart';
import 'package:ozon/app/extensions.dart';
import 'package:ozon/data/response/time_line_response.dart';
import 'package:ozon/domain/model/time_line_model.dart';

extension TimelineResponseMapper on Timeline? {
  TimeLineModel toDomain() {
    return TimeLineModel(
      this?.status.orEmpty() ?? Constants.empty,
      this?.reached ?? false,
    );
  }
}

extension TimeLineListResponseMapper on TimeLineResponse? {
  List<TimeLineModel> get list {
    return (this?.timeline
            ?.map((timeline) => timeline.toDomain()) ??
            const Iterable.empty())
        .cast<TimeLineModel>()
        .toList();
  }
  TimeLine toDomain() {
    return TimeLine(
     timeline: list
    );
  }


}

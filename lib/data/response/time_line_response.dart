import 'package:json_annotation/json_annotation.dart';

part 'time_line_response.g.dart';

@JsonSerializable()
class TimeLineResponse {
  @JsonKey(name: "timeline")
  final List<Timeline>? timeline;

  TimeLineResponse ({
    this.timeline,
  });

  factory TimeLineResponse.fromJson(Map<String, dynamic> json) {
    return _$TimeLineResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TimeLineResponseToJson(this);
  }
}

@JsonSerializable()
class Timeline {
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "reached")
  final bool? reached;

  Timeline ({
    this.status,
    this.reached,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return _$TimelineFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TimelineToJson(this);
  }
}



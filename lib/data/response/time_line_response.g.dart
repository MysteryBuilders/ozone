// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_line_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeLineResponse _$TimeLineResponseFromJson(Map<String, dynamic> json) =>
    TimeLineResponse(
      timeline: (json['timeline'] as List<dynamic>?)
          ?.map((e) => Timeline.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimeLineResponseToJson(TimeLineResponse instance) =>
    <String, dynamic>{
      'timeline': instance.timeline,
    };

Timeline _$TimelineFromJson(Map<String, dynamic> json) => Timeline(
      status: json['status'] as String?,
      reached: json['reached'] as bool?,
    );

Map<String, dynamic> _$TimelineToJson(Timeline instance) => <String, dynamic>{
      'status': instance.status,
      'reached': instance.reached,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Point _$PointFromJson(Map<String, dynamic> json) {
  return Point(
      json['type'] as String,
      (json['coordinates'] as List)
          ?.map((e) => (e as num)?.toDouble())
          ?.toList());
}

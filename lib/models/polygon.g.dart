// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'polygon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Polygon _$PolygonFromJson(Map<String, dynamic> json) {
  return Polygon(
      json['type'] as String,
      (json['coordinates'] as List)
          ?.map((e) => (e as List)
              ?.map((e) =>
                  (e as List)?.map((e) => (e as num)?.toDouble())?.toList())
              ?.toList())
          ?.toList());
}

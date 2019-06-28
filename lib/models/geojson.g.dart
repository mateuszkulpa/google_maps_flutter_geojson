// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geojson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoJSON _$GeoJSONFromJson(Map<String, dynamic> json) {
  return GeoJSON((json['features'] as List)
      ?.map(
          (e) => e == null ? null : Feature.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

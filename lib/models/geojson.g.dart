// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geojson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoJSON _$GeoJSONFromJson(Map<String, dynamic> json) => GeoJSON(
      (json['features'] as List<dynamic>)
          .map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

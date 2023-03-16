// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_geojson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomGeoJSON<T> _$CustomGeoJSONFromJson<T extends Properties>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CustomGeoJSON<T>(
      (json['features'] as List<dynamic>)
          .map((e) => Feature<T>.fromJson(
              e as Map<String, dynamic>, (value) => fromJsonT(value)))
          .toList(),
    );

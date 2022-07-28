// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multipolygon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiPolygon _$MultiPolygonFromJson(Map<String, dynamic> json) => MultiPolygon(
      json['type'] as String,
      (json['coordinates'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => (e as List<dynamic>)
                  .map((e) => (e as num).toDouble())
                  .toList())
              .toList())
          .toList(),
    );

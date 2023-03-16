// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_string.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LineString _$LineStringFromJson(Map<String, dynamic> json) => LineString(
      json['type'] as String,
      (json['coordinates'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
    );

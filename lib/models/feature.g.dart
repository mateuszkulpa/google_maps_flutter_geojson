// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feature<T> _$FeatureFromJson<T extends Properties>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Feature<T>(
      json['type'] as String,
      fromJsonT(json['properties']),
      Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    );

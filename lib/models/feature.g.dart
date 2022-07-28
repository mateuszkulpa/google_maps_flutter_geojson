// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feature _$FeatureFromJson(Map<String, dynamic> json) => Feature(
      json['type'] as String,
      Properties.fromJson(json['properties'] as Map<String, dynamic>),
      Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    );

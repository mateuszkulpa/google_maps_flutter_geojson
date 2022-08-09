// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleProperties _$SimplePropertiesFromJson(Map<String, dynamic> json) =>
    SimpleProperties(
      json['title'] as String?,
      json['description'] as String?,
      stroke: json['stroke'] as String?,
      strokeWidth: (json['stroke-width'] as num?)?.toDouble(),
      strokeOpacity: (json['stroke-opacity'] as num?)?.toDouble(),
      fill: json['fill'] as String?,
      fillOpacity: (json['fill-opacity'] as num?)?.toDouble(),
    );

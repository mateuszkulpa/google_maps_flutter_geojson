// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleProperties _$SimplePropertiesFromJson(Map<String, dynamic> json) =>
    SimpleProperties(
      json['title'] as String?,
      json['description'] as String?,
      stroke: _$JsonConverterFromJson<String, Color>(
          json['stroke'], const HexColorConverter().fromJson),
      strokeWidth: (json['stroke-width'] as num?)?.toDouble(),
      strokeOpacity: (json['stroke-opacity'] as num?)?.toDouble(),
      fill: _$JsonConverterFromJson<String, Color>(
          json['fill'], const HexColorConverter().fromJson),
      fillOpacity: (json['fill-opacity'] as num?)?.toDouble(),
    );

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

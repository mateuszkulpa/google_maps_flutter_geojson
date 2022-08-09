import 'package:google_maps_flutter_geojson/models/properties.dart';

import 'geometry.dart';
import 'package:json_annotation/json_annotation.dart';

import 'simple_properties.dart';
part 'feature.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  createToJson: false,
)
class Feature<T extends Properties> {
  final String type;
  final T properties;
  final Geometry geometry;

  Feature(this.type, this.properties, this.geometry);

  factory Feature.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT
    ) =>
      _$FeatureFromJson(json, fromJsonT);
}

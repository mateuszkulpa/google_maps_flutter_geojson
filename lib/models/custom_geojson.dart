import 'package:google_maps_flutter_geojson/models/properties.dart';
import 'package:json_annotation/json_annotation.dart';

import 'feature.dart';
part 'custom_geojson.g.dart';

/// Lets you use custom [T] types extending [Properties] as
/// the inner serialized type
@JsonSerializable(
  genericArgumentFactories: true,
  createToJson: false,
)
class CustomGeoJSON<T extends Properties> {
  final List<Feature<T>> features;
  CustomGeoJSON(this.features);

  factory CustomGeoJSON.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
  ) => _$CustomGeoJSONFromJson(json, fromJsonT);
}
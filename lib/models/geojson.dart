import 'feature.dart';
import 'package:json_annotation/json_annotation.dart';
part 'geojson.g.dart';

@JsonSerializable(createToJson: false)
class GeoJSON {
  final List<Feature> features;
  GeoJSON(this.features);

  factory GeoJSON.fromJson(Map<String, dynamic> json) => _$GeoJSONFromJson(json);

}
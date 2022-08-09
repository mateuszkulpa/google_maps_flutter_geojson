import 'package:google_maps_flutter_geojson/models/properties.dart';
import 'package:json_annotation/json_annotation.dart';
part 'simple_properties.g.dart';

@JsonSerializable(createToJson: false)
/// [Simple Style Spec properties](https://github.com/mapbox/simplestyle-spec/tree/master/1.1.0)
class SimpleProperties extends Properties {
  final String? title;
  final String? description;

  SimpleProperties(this.title, this.description, {
    String? stroke,
    double? strokeWidth,
    double? strokeOpacity,
    String? fill,
    double? fillOpacity
  }) : super(stroke, strokeWidth, strokeOpacity, fill, fillOpacity, title);

  factory SimpleProperties.fromJson(Map<String, dynamic> json) =>
      _$SimplePropertiesFromJson(json);
}

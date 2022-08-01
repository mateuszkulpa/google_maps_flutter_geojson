import 'package:json_annotation/json_annotation.dart';
part 'properties.g.dart';

@JsonSerializable(createToJson: false)
class Properties {
  final String? title;
  final String? description;
  final String? stroke;
  @JsonKey(name: 'stroke-width')
  final double? strokeWidth;
  @JsonKey(name: 'stroke-opacity')
  final double? strokeOpacity;
  final String? fill;
  @JsonKey(name: 'fill-opacity')
  final double? fillOpacity;

  Properties(this.title, this.stroke, this.strokeWidth, this.strokeOpacity, this.fill,
      this.fillOpacity, this.description);

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
}

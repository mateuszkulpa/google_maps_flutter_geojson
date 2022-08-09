import 'package:json_annotation/json_annotation.dart';

abstract class Properties {
  final String? title;
  final String? stroke;
  @JsonKey(name: 'stroke-width')
  final double? strokeWidth;
  @JsonKey(name: 'stroke-opacity')
  final double? strokeOpacity;
  final String? fill;
  @JsonKey(name: 'fill-opacity')
  final double? fillOpacity;

  Properties(this.stroke, this.strokeWidth, this.strokeOpacity, this.fill, this.fillOpacity, this.title);
}
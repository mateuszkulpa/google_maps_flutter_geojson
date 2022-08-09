import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class Properties {
  final String? title;
  @HexColorConverter()
  final Color? stroke;
  @JsonKey(name: 'stroke-width')
  final double? strokeWidth;
  @JsonKey(name: 'stroke-opacity')
  final double? strokeOpacity;
  @HexColorConverter()
  final Color? fill;
  @JsonKey(name: 'fill-opacity')
  final double? fillOpacity;

  Properties(this.stroke, this.strokeWidth, this.strokeOpacity, this.fill, this.fillOpacity, this.title);


}

class HexColorConverter implements JsonConverter<Color, String> {
  const HexColorConverter();

  @override
  Color fromJson(String json) {
    var hexColor = json.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    final c = int.parse(hexColor, radix: 16);
    return Color(c);
  }

  @override
  String toJson(Color object) {
    throw UnimplementedError();
  }

}
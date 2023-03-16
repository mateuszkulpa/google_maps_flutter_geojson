import 'package:json_annotation/json_annotation.dart';

import 'geometry.dart';
part 'multipolygon.g.dart';

@JsonSerializable(createToJson: false)
///{type: 'MultiPolygon', coordinates: [[[[0, 0], [1, 1], [0, 1], [0, 0]]]]}
class MultiPolygon extends Geometry {
  final List<List<List<List<double>>>> coordinates;

  MultiPolygon(String type, this.coordinates) : super(type);

  factory MultiPolygon.fromJson(Map<String, dynamic> json) =>
      _$MultiPolygonFromJson(json);
}
import 'package:json_annotation/json_annotation.dart';
import 'geometry.dart';
part 'polygon.g.dart';

@JsonSerializable(createToJson: false)
class Polygon extends Geometry {
  final List<List<List<double>>> coordinates;
  Polygon(String type, this.coordinates) : super(type);
  
  factory Polygon.fromJson(Map<String, dynamic> json) =>
      _$PolygonFromJson(json);
}

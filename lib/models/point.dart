import 'package:json_annotation/json_annotation.dart';
import 'geometry.dart';
part 'point.g.dart';

@JsonSerializable(createToJson: false)
class Point extends Geometry {
  final List<double>? coordinates;
  Point(String? type, this.coordinates) : super(type);

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
}

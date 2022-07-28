import 'package:json_annotation/json_annotation.dart';
import 'geometry.dart';
part 'line_string.g.dart';

@JsonSerializable(createToJson: false)
class LineString extends Geometry {
  final List<List<double>> coordinates;
  LineString(String type, this.coordinates) : super(type);

  factory LineString.fromJson(Map<String, dynamic> json) =>
      _$LineStringFromJson(json);
}

import 'package:google_maps_flutter_geojson/models/custom_geojson.dart';
import 'package:google_maps_flutter_geojson/models/simple_properties.dart';

/// The default GeoJSON class serializes [SimpleProperties]
class GeoJSON extends CustomGeoJSON<SimpleProperties> {
  GeoJSON(super.features);

  factory GeoJSON.fromJson(Map<String, dynamic> json) {
    // Parse the custom type
    final c = CustomGeoJSON<SimpleProperties>.fromJson(
      json,
      (json) => SimpleProperties.fromJson(json as Map<String, dynamic>)
    );

    // Then use those features
    return GeoJSON(c.features);
  }
}
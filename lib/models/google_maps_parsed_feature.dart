import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_geojson/models/properties.dart';

/// Holds the properties and all of the parsed geometries for that same property
class GoogleMapsParsedFeature<T extends Properties> {
  final T properties;
  final List<Polygon> polygons;
  final List<Marker> markers;
  final List<Polyline> polylines;

  GoogleMapsParsedFeature(
    this.properties,
    this.polygons,
    this.markers,
    this.polylines
  );
}
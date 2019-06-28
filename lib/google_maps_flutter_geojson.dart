library google_maps_flutter_geojson;

import 'models/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/models.dart' as internalModels;

class GeoJSONParser {
  static GeoJSON parse(Map<String, dynamic> json) {
    return GeoJSON.fromJson(json);
  }
}

class GeoJSONGoogleMapsResult {
  final List<Polygon> polygons;
  final List<Marker> markers;
  final List<Polyline> polylines;

  GeoJSONGoogleMapsResult(this.polygons, this.markers, this.polylines);

  factory GeoJSONGoogleMapsResult.fromJson(Map<String, dynamic> json) {
    var parsedJson = GeoJSONParser.parse(json);

    var polygons = parsedJson.features
        .where((x) => x.geometry is internalModels.Polygon)
        .map<Polygon>((x) => _featureToGooglePolygon(x))
        .toList();

    var markers = parsedJson.features
        .where((x) => x.geometry is internalModels.Point)
        .map<Marker>((x) => _featureToGoogleMarker(x))
        .toList();

    var polylines = parsedJson.features
        .where((x) => x.geometry is internalModels.LineString)
        .map<Polyline>((x) => _featureToGooglePolyline(x))
        .toList();

    return GeoJSONGoogleMapsResult(polygons, markers, polylines);
  }

  static Polygon _featureToGooglePolygon(internalModels.Feature feature) {
    return Polygon(
      polygonId: PolygonId('test'),
      points: (feature.geometry as internalModels.Polygon)
          .coordinates
          .first
          .map((x) => LatLng(x[0], x[1]))
          .toList(),
    );
  }

  static Marker _featureToGoogleMarker(internalModels.Feature feature) {
    var cords = (feature.geometry as internalModels.Point).coordinates;
    return Marker(
      markerId: MarkerId('test'),
      position: LatLng(cords[0], cords[1]),
    );
  }

  static Polyline _featureToGooglePolyline(internalModels.Feature feature) {
    var cords = (feature.geometry as internalModels.LineString).coordinates;
    return Polyline(
        polylineId: PolylineId('test'),
        points: cords.map((x) => LatLng(x[0], x[1])).toList());
  }
}

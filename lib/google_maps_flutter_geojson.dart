library google_maps_flutter_geojson;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter_geojson/utils/hex_color.dart';
import 'package:uuid/uuid.dart';
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
      polygonId: PolygonId(Uuid().v4()),
      fillColor: HexColor(feature.properties.fill)
              .withOpacity(feature.properties.fillOpacity ?? 1.0) ??
          Colors.black.withOpacity(0.5),
      strokeWidth: feature.properties.strokeWidth?.toInt() ?? 10,
      strokeColor: HexColor(feature.properties.stroke)
              .withOpacity(feature.properties.strokeOpacity ?? 1.0) ??
          Colors.black.withOpacity(0.5),
      points: (feature.geometry as internalModels.Polygon)
          .coordinates
          .first
          .map((x) => LatLng(x[1], x[0]))
          .toList(),
    );
  }

  static Marker _featureToGoogleMarker(internalModels.Feature feature) {
    var cords = (feature.geometry as internalModels.Point).coordinates;
    return Marker(
      markerId: MarkerId(Uuid().v4()),
      infoWindow: feature.properties.name != null ? InfoWindow(title: feature.properties.name) : InfoWindow.noText,
      position: LatLng(cords[1], cords[0]),
    );
  }

  static Polyline _featureToGooglePolyline(internalModels.Feature feature) {
    var cords = (feature.geometry as internalModels.LineString).coordinates;
    return Polyline(
        polylineId: PolylineId(Uuid().v4()),
        color: HexColor(feature.properties.stroke)
                .withOpacity(feature.properties.strokeOpacity ?? 1.0) ??
            Colors.black.withOpacity(0.5),
        points: cords.map((x) => LatLng(x[1], x[0])).toList());
  }
}

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

    var multipolygons = parsedJson.features
        .where((x) => x.geometry is internalModels.MultiPolygon)
        .map<Polygon>((x) => _featureToGooglePolygon(x))
        .toList();

    polygons.addAll(multipolygons);

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
    // Set fill color
    Color fillColor = Colors.black.withOpacity(0.15);
    if (feature.properties.fill != null) {
      fillColor = HexColor(feature.properties.fill!);
    }
    if (feature.properties.fillOpacity != null) {
      fillColor = fillColor.withOpacity(feature.properties.fillOpacity!);
    }

    // Set stroke color
    Color strokeColor = Colors.black.withOpacity(0.5);
    if (feature.properties.stroke != null) {
      strokeColor = HexColor(feature.properties.stroke!);
    }
    if (feature.properties.strokeOpacity != null) {
      strokeColor = strokeColor.withOpacity(feature.properties.strokeOpacity!);
    }

    late List<LatLng> points;
    List<List<LatLng>> holes = [];
    if (feature.geometry is internalModels.MultiPolygon) {
      ///coordinates: [[[[0, 0], [1, 1], [0, 1], [0, 0]]]]}
      final coordinates = (feature.geometry as internalModels.MultiPolygon).coordinates;
      points = coordinates.first.first.map((x) => LatLng(x[1], x[0])).toList();
      if (coordinates.first.length > 1) {
        holes = coordinates.first.sublist(1)
            .map<List<LatLng>>((h) => h
            .map((p) => LatLng(p[1], p[0]))
            .toList()
        ).toList();
      }

    } else {
      final coordinates = (feature.geometry as internalModels.Polygon).coordinates;
      points = coordinates.first.map((x) => LatLng(x[1], x[0])).toList();
    }

    return Polygon(
      polygonId: PolygonId(Uuid().v4()),
      fillColor: fillColor,
      strokeWidth: feature.properties.strokeWidth?.toInt() ?? 10,
      strokeColor: strokeColor,
      points: points,
      holes: holes,
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

    // Set color
    Color strokeColor = Colors.black.withOpacity(0.5);
    if (feature.properties.stroke != null) {
      strokeColor = HexColor(feature.properties.stroke!);
    }
    if (feature.properties.strokeOpacity != null) {
      strokeColor = strokeColor.withOpacity(feature.properties.strokeOpacity!);
    }

    return Polyline(
        polylineId: PolylineId(Uuid().v4()),
        color: strokeColor,
        width: feature.properties.strokeWidth?.toInt() ?? 10,
        points: cords.map((x) => LatLng(x[1], x[0])).toList()
    );
  }
}

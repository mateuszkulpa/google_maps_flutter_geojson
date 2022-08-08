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

  /// A lookup map of the polygon to feature
  final Map<Polygon, internalModels.Feature> polygonFeatures;

  /// A lookup map of the marker to feature
  final Map<Marker, internalModels.Feature> markerFeatures;

  /// A lookup map of the line to feature
  final Map<Polyline, internalModels.Feature> lineFeatures;

  GeoJSONGoogleMapsResult(this.polygons, this.markers, this.polylines, {
    this.polygonFeatures = const {},
    this.markerFeatures = const {},
    this.lineFeatures = const {},
  });

  factory GeoJSONGoogleMapsResult.fromJson(Map<String, dynamic> json) {
    var parsedJson = GeoJSONParser.parse(json);
    return GeoJSONGoogleMapsResult.fromGeoJson(parsedJson);
  }

  factory GeoJSONGoogleMapsResult.fromGeoJson(GeoJSON parsedJson) {
    final Map<Polygon, internalModels.Feature> _polygonFeatures = {};
    final Map<Marker, internalModels.Feature> _markerFeatures = {};
    final Map<Polyline, internalModels.Feature> _lineFeatures = {};
    var polygons = parsedJson.features
        .where((x) => x.geometry is internalModels.Polygon)
        .map<Polygon>((x) {
            final p = _featureToGooglePolygon(x);
            _polygonFeatures[p] = x;
            return p;
        })
        .toList();

    var multipolygons = parsedJson.features
        .where((x) => x.geometry is internalModels.MultiPolygon)
        .expand<Polygon>((x) {
          final p = _multiPolygonToGooglePolygon(x);
          p.forEach((p) => _polygonFeatures[p] = x);
          return p;
        })
        .toList();

    polygons.addAll(multipolygons);

    var markers = parsedJson.features
        .where((x) => x.geometry is internalModels.Point)
        .map<Marker>((x) {
          final m = _featureToGoogleMarker(x);
          _markerFeatures[m] = x;
          return m;
        })
        .toList();

    var polylines = parsedJson.features
        .where((x) => x.geometry is internalModels.LineString)
        .map<Polyline>((x) {
          final l = _featureToGooglePolyline(x);
          _lineFeatures[l] = x;
          return l;
        })
        .toList();

    return GeoJSONGoogleMapsResult(polygons, markers, polylines,
      polygonFeatures: _polygonFeatures,
      markerFeatures: _markerFeatures,
      lineFeatures: _lineFeatures
    );
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

    final coordinates = (feature.geometry as internalModels.Polygon).coordinates;
    final points = coordinates.first.map((x) => LatLng(x[1], x[0])).toList();
    final List<List<LatLng>> holes = coordinates.length > 1
        ? coordinates.sublist(1)
        .map<List<LatLng>>(
            (h) => h.map<LatLng>(
              (p) => LatLng(p[1], p[0])
            ).toList()
          ).toList()
        : [];

    return Polygon(
      polygonId: PolygonId(Uuid().v4()),
      fillColor: fillColor,
      strokeWidth: feature.properties.strokeWidth?.toInt() ?? 1,
      strokeColor: strokeColor,
      points: points,
      holes: holes,
    );
  }

  static Set<Polygon> _multiPolygonToGooglePolygon(internalModels.Feature feature) {
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

    final coordinates = (feature.geometry as internalModels.MultiPolygon).coordinates;

    return coordinates.where((polygon) {
      return polygon.isNotEmpty;
    }).map<Polygon>((polygon) {
      final points = polygon.first.map((x) => LatLng(x[1], x[0])).toList();
      final List<List<LatLng>> holes = polygon.length > 1
          ? polygon.sublist(1)
          .map<List<LatLng>>(
              (h) => h.map<LatLng>(
                  (p) => LatLng(p[1], p[0])
          ).toList()
      ).toList()
          : [];

       return Polygon(
        polygonId: PolygonId(Uuid().v4()),
        fillColor: fillColor,
        strokeWidth: feature.properties.strokeWidth?.toInt() ?? 1,
        strokeColor: strokeColor,
        points: points,
        holes: holes,
      );
    }).toSet();
  }

  static Marker _featureToGoogleMarker(internalModels.Feature feature) {
    var cords = (feature.geometry as internalModels.Point).coordinates;
    return Marker(
      markerId: MarkerId(Uuid().v4()),
      infoWindow: feature.properties.title != null ? InfoWindow(title: feature.properties.title) : InfoWindow.noText,
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
        width: feature.properties.strokeWidth?.toInt() ?? 1,
        points: cords.map((x) => LatLng(x[1], x[0])).toList()
    );
  }
}

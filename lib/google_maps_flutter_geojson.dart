library google_maps_flutter_geojson;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter_geojson/models/simple_properties.dart';
import 'package:uuid/uuid.dart';
import 'models/custom_geojson.dart';
import 'models/geojson.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/google_maps_parsed_feature.dart';
import 'models/models.dart' as internalModels;
import 'models/properties.dart';

class GeoJSONParser {
  /// The generic parse uses the [SimpleProperty]
  static GeoJSON parse(Map<String, dynamic> json) {
    return GeoJSON.fromJson(json); }

  /// A custom parser accepting [T] types extending [Properties]
  static CustomGeoJSON<T> parseCustom<T extends Properties>(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT
  ) {
    return CustomGeoJSON<T>.fromJson(json, fromJsonT);
  }
}

/// A [GeoJSONGoogleMapsResult] is simply a particular [CustomGeoJSONGoogleMapsResult]
/// using the [SimpleProperties] property object.
///
/// Use this in most cases when you do not need to manually override the [Properties]
///
class GeoJSONGoogleMapsResult extends CustomGeoJSONGoogleMapsResult<SimpleProperties> {
  /// Uses the super constructor
  GeoJSONGoogleMapsResult(List<GoogleMapsParsedFeature<SimpleProperties>> c) : super(c);

  /// The main from Json parser
  factory GeoJSONGoogleMapsResult.fromJson(Map<String, dynamic> json) {
    final c = CustomGeoJSONGoogleMapsResult.fromJson(json,
            (json) => SimpleProperties.fromJson(json as Map<String, dynamic>));
    return GeoJSONGoogleMapsResult._fromCustom(c);
  }

  /// A factory for translating between the templated type and this helper type
  factory GeoJSONGoogleMapsResult._fromCustom(CustomGeoJSONGoogleMapsResult<SimpleProperties> c) {
    return GeoJSONGoogleMapsResult(c.features);
  }
}

class CustomGeoJSONGoogleMapsResult<T extends Properties> {
  Iterable<Polygon> get polygons => features.expand((f) => f.polygons);
  Iterable<Marker> get markers => features.expand((f) => f.markers);
  Iterable<Polyline> get polylines => features.expand((f) => f.polylines);

  final List<GoogleMapsParsedFeature<T>> features;

  CustomGeoJSONGoogleMapsResult(this.features);

  factory CustomGeoJSONGoogleMapsResult.fromJson(Map<String, dynamic> json,
      T Function(Object? json) fromJsonT) {
    var parsedJson = GeoJSONParser.parseCustom<T>(json, fromJsonT);
    return CustomGeoJSONGoogleMapsResult.fromGeoJson(parsedJson);
  }

  factory CustomGeoJSONGoogleMapsResult.fromGeoJson(CustomGeoJSON<T> parsedJson) {
    final List<GoogleMapsParsedFeature<T>> features = [];
    for (final feature in parsedJson.features) {
      final List<Polygon> polygons = [];
      final List<Marker> markers = [];
      final List<Polyline> polylines = [];

      if (feature.geometry is internalModels.Polygon) {
        final polygon = feature.toGooglePolygon();
        if (polygon != null) {
          polygons.add(polygon);
        }
      } else if (feature.geometry is internalModels.MultiPolygon) {
        final multipolygon = feature.toGooglePolygons();
        polygons.addAll(multipolygon);
      } else if (feature.geometry is internalModels.Point) {
        final marker = feature.toGoogleMarker();
        if (marker != null) {
          markers.add(marker);
        }
      } else if (feature.geometry is internalModels.LineString) {
        final polyline = feature.toGooglePolyline();
        if (polyline != null) {
          polylines.add(polyline);
        }
      }

      features.add(GoogleMapsParsedFeature(feature.properties, polygons, markers, polylines));
    }

    return CustomGeoJSONGoogleMapsResult(features);
  }



}

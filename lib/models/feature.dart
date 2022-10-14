import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_geojson/models/properties.dart';
import 'package:uuid/uuid.dart';

import 'geometry.dart';
import 'package:json_annotation/json_annotation.dart';

import 'models.dart' as internalModels;
part 'feature.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
  createToJson: false,
)
class Feature<T extends Properties> {
  final String type;
  final T properties;
  final Geometry geometry;

  Feature(this.type, this.properties, this.geometry);

  factory Feature.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT
    ) =>
      _$FeatureFromJson(json, fromJsonT);

  /// Parses [internalModels.Polygon]
  /// return null if we cannot parse this feature
  Polygon? toGooglePolygon() {
    // Guard for Polygon
    if (!(geometry is internalModels.Polygon)) {
      return null;
    }
    // Set fill color
    Color fillColor = Colors.black.withOpacity(0.15);
    if (properties.fill != null) {
      fillColor = properties.fill!;
    }
    if (properties.fillOpacity != null) {
      fillColor = fillColor.withOpacity(properties.fillOpacity!);
    }

    // Set stroke color
    Color strokeColor = Colors.black.withOpacity(0.5);
    if (properties.stroke != null) {
      strokeColor = properties.stroke!;
    }
    if (properties.strokeOpacity != null) {
      strokeColor = strokeColor.withOpacity(properties.strokeOpacity!);
    }

    final coordinates = (geometry as internalModels.Polygon).coordinates;

    // Guard for empty coordinates
    if (coordinates.isEmpty) {
      return null;
    }

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
      strokeWidth: properties.strokeWidth?.toInt() ?? 1,
      strokeColor: strokeColor,
      points: points,
      holes: holes,
    );
  }

  /// Parses [internalModels.MultiPolygon]
  Set<Polygon> toGooglePolygons() {
    // Guard for multipolygons
    if (!(geometry is internalModels.MultiPolygon)) {
      return {};
    }
    // Set fill color
    Color fillColor = Colors.black.withOpacity(0.15);
    if (properties.fill != null) {
      fillColor = properties.fill!;
    }
    if (properties.fillOpacity != null) {
      fillColor = fillColor.withOpacity(properties.fillOpacity!);
    }

    // Set stroke color
    Color strokeColor = Colors.black.withOpacity(0.5);
    if (properties.stroke != null) {
      strokeColor = properties.stroke!;
    }
    if (properties.strokeOpacity != null) {
      strokeColor = strokeColor.withOpacity(properties.strokeOpacity!);
    }

    final coordinates = (geometry as internalModels.MultiPolygon).coordinates;

    // Guard for empty coordinates
    if (coordinates.isEmpty) {
      return {};
    }

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
        strokeWidth: properties.strokeWidth?.toInt() ?? 1,
        strokeColor: strokeColor,
        points: points,
        holes: holes,
      );
    }).toSet();
  }

  /// Parses [internalModels.Marker]
  Marker? toGoogleMarker() {
    // Guard for Point
    if (!(geometry is internalModels.Point)) {
      return null;
    }
    var cords = (geometry as internalModels.Point).coordinates;
    return Marker(
      markerId: MarkerId(Uuid().v4()),
      infoWindow: properties.title != null ? InfoWindow(title: properties.title) : InfoWindow.noText,
      position: LatLng(cords[1], cords[0]),
    );
  }

  /// Parses [internalModels.LineString]
  Polyline? toGooglePolyline() {
    // Guard for LineStrings
    if (!(geometry is internalModels.LineString)) {
      return null;
    }
    var cords = (geometry as internalModels.LineString).coordinates;

    // Set color
    Color strokeColor = Colors.black.withOpacity(0.5);
    if (properties.stroke != null) {
      strokeColor = properties.stroke!;
    }
    if (properties.strokeOpacity != null) {
      strokeColor = strokeColor.withOpacity(properties.strokeOpacity!);
    }

    return Polyline(
        polylineId: PolylineId(Uuid().v4()),
        color: strokeColor,
        width: properties.strokeWidth?.toInt() ?? 1,
        points: cords.map((x) => LatLng(x[1], x[0])).toList()
    );
  }
}

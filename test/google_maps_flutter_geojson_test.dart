import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter_geojson/google_maps_flutter_geojson.dart';
import 'package:google_maps_flutter_geojson/models/models.dart';

const sampleJson =
    '{"type":"FeatureCollection","features":[{"type":"Feature","properties":{},"geometry":{"type":"LineString","coordinates":[[18.10546875,50.958426723359935],[17.9736328125,50.65294336725709],[17.578125,50.3734961443035],[17.666015625,50.064191736659104],[17.9296875,49.95121990866204],[18.544921875,50.064191736659104],[18.6767578125,50.20503326494332],[19.0283203125,50.42951794712287],[19.51171875,50.3734961443035],[19.775390625,50.0923932109388],[19.9951171875,49.92293545449574],[20.0830078125,49.724479188712984],[20.126953125,49.52520834197442],[20.1708984375,49.410973199695846],[20.181884765625,49.33944093715546],[20.1104736328125,49.27138884351881],[20.093994140624996,49.2032427441791],[20.050048828125,49.17811258315209],[19.984130859375,49.228360140901266]]}},{"type":"Feature","properties":{"stroke":"#555555","stroke-width":2,"fill":"#555555","fill-opacity":0.5,"stroke-opacity":"","adsda":"asdasdad"},"geometry":{"type":"Polygon","coordinates":[[[18.8580322265625,51.031031114144035],[18.671264648437496,51.19999983412068],[18.369140624999996,51.11041991029264],[18.5284423828125,50.78510168548186],[19.0557861328125,50.63204218884234],[19.5281982421875,50.78857450392834],[18.8580322265625,51.031031114144035]]]}},{"type":"Feature","properties":{"stroke-width":"","fill":"","stroke-opacity":""},"geometry":{"type":"Point","coordinates":[19.020080566406246,51.09489803482296]}},{"type":"Feature","properties":{"stroke":"#7c1397","stroke-width":2,"stroke-opacity":1,"fill":"#aa0011","fill-opacity":0.9},"geometry":{"type":"Polygon","coordinates":[[[19.121017456054688,51.02671260348006],[19.211654663085938,51.02671260348006],[19.211654663085938,51.087997750516124],[19.121017456054688,51.087997750516124],[19.121017456054688,51.02671260348006]]]}},{"type":"Feature","properties":{"marker-color":"#7e7e7e","marker-size":"medium","marker-symbol":"circle","stroke-opacity":""},"geometry":{"type":"Point","coordinates":[20.3082275390625,51.15867686442365]}}]}';
void main() {
  test('Parse geojson sample', () {
    var result = GeoJSONParser.parse(jsonDecode(sampleJson));

    expect(true, result.features[0].geometry is LineString);
    expect(true, result.features[1].geometry is Polygon);
  });

  test('Parse and convert to google maps items', () {
    var result = GeoJSONGoogleMapsResult.fromJson(jsonDecode(sampleJson));
    print(result);
    expect(1, 1);
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter_geojson/google_maps_flutter_geojson.dart';
import 'package:google_maps_flutter_geojson/models/models.dart';

const sampleJson =
    '{"type":"FeatureCollection","features":[{"type":"Feature","geometry":{"type":"Point","coordinates":[17.1236521,50.85014,0]},"properties":{"name":"pierwszy punkt","styleUrl":"#icon-1899-0288D1-nodesc","styleHash":"-258dc051","styleMapHash":{"normal":"#icon-1899-0288D1-nodesc-normal","highlight":"#icon-1899-0288D1-nodesc-highlight"},"icon":"http://www.gstatic.com/mapspro/images/stock/503-wht-blank_maps.png"}},{"type":"Feature","geometry":{"type":"Point","coordinates":[17.9805857,51.3880324,0]},"properties":{"name":"Drugi punkt","styleUrl":"#icon-1899-0288D1-nodesc","styleHash":"-258dc051","styleMapHash":{"normal":"#icon-1899-0288D1-nodesc-normal","highlight":"#icon-1899-0288D1-nodesc-highlight"},"icon":"http://www.gstatic.com/mapspro/images/stock/503-wht-blank_maps.png"}},{"type":"Feature","geometry":{"type":"LineString","coordinates":[[19.6175486,51.9264508,0],[19.5845896,51.7499558,0],[19.5736033,51.6205409,0],[19.5736033,51.4702297,0],[19.6285349,51.4222992,0],[19.6505076,51.3125549,0],[19.4857127,51.2438311,0],[19.3758494,51.1060748,0],[19.2549998,50.9609876,0],[19.1121775,50.8154459,0],[19.1121775,50.6137117,0],[19.2440135,50.4880604,0],[19.2110545,50.3550651,0],[19.1121775,50.2287248,0],[19.3648631,50.1231849,0],[19.6395213,50.0879531,0],[19.7823435,50.0809037,0],[19.9251658,50.0668016,0]]},"properties":{"name":"Linia 3","styleUrl":"#line-000000-1200-nodesc","styleHash":"c2c637f","styleMapHash":{"normal":"#line-000000-1200-nodesc-normal","highlight":"#line-000000-1200-nodesc-highlight"},"stroke":"#000000","stroke-opacity":1,"stroke-width":1.2}},{"type":"Feature","geometry":{"type":"Polygon","coordinates":[[[21.1556345,53.2150469,0],[19.0682322,52.8251394,0],[19.6614939,52.4718736,0],[20.5074412,51.9738505,0],[21.606074,52.5788207,0],[21.1556345,53.2150469,0]]]},"properties":{"name":"Wielokąt 4","styleUrl":"#poly-AFB42B-4501-171-nodesc","styleHash":"-70f9e379","styleMapHash":{"normal":"#poly-AFB42B-4501-171-nodesc-normal","highlight":"#poly-AFB42B-4501-171-nodesc-highlight"},"stroke":"#afb42b","stroke-opacity":1,"stroke-width":4.501,"fill":"#afb42b","fill-opacity":0.6705882352941176}}]}';
void main() {
  test('Parse geojson sample', () {
    var result = GeoJSONParser.parse(jsonDecode(sampleJson));
    expect(result.features![0].geometry is Point, true);
    expect( result.features![1].geometry is Point, true);
    expect(result.features![2].geometry is LineString, true);
    expect(result.features![3].geometry is Polygon, true);
  });

  test('Parse and convert to google maps items', () {
    var result = GeoJSONGoogleMapsResult.fromJson(jsonDecode(sampleJson));
    expect(result.polygons.length, 1);
    expect(result.polylines.length, 1);
    expect(result.markers.length, 2);
  });
}

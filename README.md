# google_maps_flutter_geojson

Simple library allows to display map layers based on geojson format data.
Supported geojson layers:
-  LineString
-  Polygon
-  Point

## Installation

import the library in pubspec.yaml. Now this is the only way to use the library.

```yaml
google_maps_flutter_geojson:
    git: https://github.com/mateuszkulpa/google_maps_flutter_geojson.git
```

## Usage

```dart
import 'package:google_maps_flutter_geojson/google_maps_flutter_geojson.dart';

// convert your geojson to google maps layers
var layers = GeoJSONGoogleMapsResult.fromJson(jsonDecode("YOUR GEOJSON"));

// use it in your GoogleMap widget
GoogleMap(
    // ...
    polygons: Set.of(result.polygons),
    polylines: Set.of(result.polylines),
    markers: Set.of(result.markers),
)
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
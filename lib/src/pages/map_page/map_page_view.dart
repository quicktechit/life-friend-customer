import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maplibre_gl/maplibre_gl.dart';

class MapWithDirections extends StatefulWidget {
  final double pickUpLat;
  final double pickUpLng;
  final double dropUpLat;
  final double dropUpLng;

  const MapWithDirections({
    super.key,
    required this.pickUpLat,
    required this.pickUpLng,
    required this.dropUpLat,
    required this.dropUpLng,
  });

  @override
  State<MapWithDirections> createState() => _MapWithDirectionsState();
}

class _MapWithDirectionsState extends State<MapWithDirections> {
  MapLibreMapController? mController;

  static const apiKey = 'bkoi_029d49cbee063aac30a15bf669de3027eae2c84ca9f06666b7cebfb7b24c9bc3';
  static const styleId = 'osm-liberty';
  static const mapUrl = 'https://map.barikoi.com/styles/$styleId/style.json?key=$apiKey';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map with Directions",style: TextStyle(color: Colors.white),)),
      body: MaplibreMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.pickUpLat, widget.pickUpLng),
          zoom: 18,
        ),
        styleString: mapUrl,
        onMapCreated: (MapLibreMapController mapController) {
          mController = mapController;
        },
        onStyleLoadedCallback: _onStyleLoaded,
      ),
    );
  }

  Future<void> _onStyleLoaded() async {
    if (mController == null) return;
    await _addMarkers();
    await _getDirections();
  }

  Future<void> _addMarkers() async {
    // Pickup marker (green circle)
    await mController!.addCircle(
      CircleOptions(
        geometry: LatLng(widget.pickUpLat, widget.pickUpLng),
        circleRadius: 10,
        circleColor: "#00CC00",
        circleStrokeColor: "#FFFFFF",
        circleStrokeWidth: 2,
      ),
    );

    // Drop marker (red circle)
    await mController!.addCircle(
      CircleOptions(
        geometry: LatLng(widget.dropUpLat, widget.dropUpLng),
        circleRadius: 10,
        circleColor: "#FF0000",
        circleStrokeColor: "#FFFFFF",
        circleStrokeWidth: 2,
      ),
    );

    // Pickup label
    await mController!.addSymbol(
      SymbolOptions(
        geometry: LatLng(widget.pickUpLat, widget.pickUpLng),
        textField: "Pickup",
        textSize: 12,
        textColor: "#000000",
        textOffset: const Offset(0, 2),
      ),
    );

    // Drop label
    await mController!.addSymbol(
      SymbolOptions(
        geometry: LatLng(widget.dropUpLat, widget.dropUpLng),
        textField: "Drop",
        textSize: 12,
        textColor: "#000000",
        textOffset: const Offset(0, 2),
      ),
    );
  }


  Future<void> _getDirections() async {
    const String apiKey = 'bkoi_029d49cbee063aac30a15bf669de3027eae2c84ca9f06666b7cebfb7b24c9bc3';

    final url =
        "https://barikoi.xyz/v2/api/route/"
        "${widget.pickUpLng},${widget.pickUpLat};"
        "${widget.dropUpLng},${widget.dropUpLat}"
        "?api_key=$apiKey&geometries=polyline";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Get encoded polyline string
      final String encodedPolyline =
      data['routes'][0]['geometry'];

      // Decode polyline
      PolylinePoints polylinePoints = PolylinePoints(apiKey: apiKey);
      List<PointLatLng> decodedPoints =
      PolylinePoints.decodePolyline(encodedPolyline);

      List<LatLng> routeCoords = decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      // Remove old line if needed
      await mController?.clearLines();

      await mController!.addLine(
        LineOptions(
          geometry: routeCoords,
          lineColor: "#0066FF",
          lineWidth: 5.0,
          lineOpacity: 0.8,
        ),
      );
    } else {
      print("Route API Error: ${response.statusCode}");
    }
  }
}

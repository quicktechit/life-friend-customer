import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapWithDirections extends StatefulWidget {
  final double pickUpLat;
  final double pickUpLng;
  final double dropUpLat;
  final double dropUpLng;

  const MapWithDirections({
    Key? key,
    required this.pickUpLat,
    required this.pickUpLng,
    required this.dropUpLat,
    required this.dropUpLng,
  }) : super(key: key);

  @override
  _MapWithDirectionsState createState() => _MapWithDirectionsState();
}

class _MapWithDirectionsState extends State<MapWithDirections> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final String _apiKey = "AIzaSyC1LrGdAl5vX5Jp9muuou2iAo52Yu49pFc";

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    _markers.addAll([
      Marker(
        markerId: const MarkerId("start"),
        position: LatLng(widget.pickUpLat, widget.pickUpLng),
        infoWindow: const InfoWindow(title: "Start"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Green color
      ),
      Marker(
        markerId: const MarkerId("end"),
        position: LatLng(widget.dropUpLat, widget.dropUpLng),
        infoWindow: const InfoWindow(title: "End"),
        // Default color (red)
      ),
    ]);


    setState(() {}); // update markers

    _getDirections();
  }

  Future<void> _getDirections() async {
    final start = "${widget.pickUpLat},${widget.pickUpLng}";
    final end = "${widget.dropUpLat},${widget.dropUpLng}";
    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$start&destination=$end&key=$_apiKey";
log(url);
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['routes'] == null || data['routes'].isEmpty) {
        print("❌ No routes found in API response");
        return;
      }

      final overviewPolyline = data['routes'][0]['overview_polyline']['points'];
      final points = _decodePolyline(overviewPolyline);

      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          points: points,
          color: Colors.blue,
          width: 5,
        ),
      );

      setState(() {});
    } catch (e) {
      print("❌ Exception while fetching directions: $e");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dLat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dLng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map with Directions")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.pickUpLat, widget.pickUpLng),
          zoom: 13.0,
        ),
        onMapCreated: _onMapCreated,
        markers: _markers,
        polylines: _polylines,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as gc;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'controller/LocationPickerController.dart';

class MapSinglePickerScreen extends StatefulWidget {
  final double? lat;
  final double? lng;

  const MapSinglePickerScreen({super.key, this.lat, this.lng});

  @override
  State<MapSinglePickerScreen> createState() => _MapSinglePickerScreenState();
}

class _MapSinglePickerScreenState extends State<MapSinglePickerScreen> {
  LatLng? _initialPosition;
  bool _loading = true;
  final controller = Get.put(LocationPickerController());

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }
  LocationData? currentLocation;
  Future<void> _setInitialLocation() async {
    controller.resetSingle();

    if (widget.lat != null && widget.lng != null) {
      _initialPosition = LatLng(widget.lat!, widget.lng!);
    } else {
      Location location = Location();

      bool _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) return;
      }

      PermissionStatus _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) return;
      }

       currentLocation = await location.getLocation();
      _initialPosition =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    }

    setState(() {
      _loading = false;
    });
  }
  Future<String> _getPlaceName(double latitude, double longitude) async {
    try {
      List<gc.Placemark> placemarks = await gc.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        gc.Placemark place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.country}";
      }
    } catch (e) {
      print("Error getting address: $e");
    }
    return "Unknown location";
  }

  @override
  Widget build(BuildContext context) {
    controller.resetSingle();
    if (_loading || _initialPosition == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Pick Single Location")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Pick Single Location")),
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialPosition!,
                  zoom: 14,
                ),
                onTap: controller.setSingleLocation,
                markers: controller.singleLocation.value != null
                    ? {
                        Marker(
                          markerId: MarkerId('selected'),
                          position: controller.singleLocation.value!,
                        )
                      }
                    : {
                        Marker(
                          markerId: MarkerId('selected'),
                          position: _initialPosition!,
                        )
                      },
              )),
          Obx(() => controller.singleAddress.value == null
              ? SizedBox.shrink()
              : Positioned(
                  bottom: 100,
                  left: 10,
                  right: 10,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(controller.singleAddress.value!),
                    ),
                  ),
                )),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Obx(() => ElevatedButton(
                  onPressed: controller.singleLocation.value == null
                      ? () async {
                          var address = await _getPlaceName(
                              currentLocation!.latitude!,
                              currentLocation!.longitude!);
                          Get.back(result: {
                            'lat': currentLocation?.latitude,
                            'lng': currentLocation?.longitude,
                            'address': address,
                            'place_id': null, // No place_id in fallback
                          });
                        }
                      : () {
                          Get.back(result: {
                            'lat': controller.singleLocation.value!.latitude,
                            'lng': controller.singleLocation.value!.longitude,
                            'address': controller.singleAddress.value,
                            'place_id':
                                controller.placeId.value, // ✅ return place_id
                          });
                        },
                  child: Text("Done"),
                )),
          ),
        ],
      ),
    );
  }
}

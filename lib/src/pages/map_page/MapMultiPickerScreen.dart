import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'controller/LocationPickerController.dart';

class MapMultiPickerScreen extends StatelessWidget {
  final List<Map<String, dynamic>>? initialLocations;
  final controller = Get.put(LocationPickerController());

  MapMultiPickerScreen({Key? key, this.initialLocations}) : super(key: key) {
    // Pre-populate controller with initial locations if provided
    controller.resetMulti(); // Clear any previous state
    if (initialLocations != null) {
      for (var location in initialLocations!) {
        final latLng = LatLng(location['lat'], location['lng']);
        controller.addMultiLocation(latLng);
        controller.addressMap[latLng] = location['address'] ?? "Unknown";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick Multiple Locations")),
      body: Stack(
        children: [
          Obx(() => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: controller.multipleLocations.isNotEmpty
                  ? controller.multipleLocations.first
                  : LatLng(23.798162, 90.35317),
              zoom: 14,
            ),
            onTap: (pos) {
              if (controller.multipleLocations.length >= 5) {
                Get.snackbar("Limit Reached", "You can select up to 5 locations");
                return;
              }
              controller.addMultiLocation(pos);
            },
            markers: controller.multipleLocations
                .map((pos) => Marker(
              markerId: MarkerId(pos.toString()),
              position: pos,
              infoWindow: InfoWindow(
                title: controller.addressMap[pos] ?? "Loading...",
              ),
            ))
                .toSet(),
          )),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Obx(() => ElevatedButton(
              onPressed: controller.multipleLocations.isEmpty
                  ? null
                  : () {
                final result = controller.multipleLocations.map((latLng) {
                  return {
                    'lat': latLng.latitude,
                    'lng': latLng.longitude,
                    'address': controller.addressMap[latLng] ?? 'Unknown',
                  };
                }).toList();
                Get.back(result: result);
              },
              child: Text("Done (${controller.multipleLocations.length}/5)"),
            )),
          ),
        ],
      ),
    );
  }
}

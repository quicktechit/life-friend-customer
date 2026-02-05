import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart'as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class LocationPickerController extends GetxController {
  // SINGLE LOCATION
  String apiKey = 'AIzaSyC1LrGdAl5vX5Jp9muuou2iAo52Yu49pFc';
  Rxn<LatLng> singleLocation = Rxn<LatLng>();
  RxnString singleAddress = RxnString();
  RxnString placeId = RxnString();
  // MULTIPLE LOCATIONS
  RxList<LatLng> multipleLocations = <LatLng>[].obs;
  RxMap<LatLng, String> addressMap = <LatLng, String>{}.obs;

  // PERMISSION STATUS
  RxBool isPermissionGranted = false.obs;

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      status = await Permission.location.request();
    }
    if (status.isGranted) {
      isPermissionGranted.value = true;
    } else {
      isPermissionGranted.value = false;
      Get.snackbar(
        'Permission Denied',
        'Location permissions are required to use the map.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
      );
    }
  }

  Future<void> setSingleLocation(LatLng position) async {
    // Validate
    if (position.latitude < -90 || position.latitude > 90 || position.longitude < -180 || position.longitude > 180) {
      print('Invalid coordinates: $position');
      singleAddress.value = 'Invalid location';
      return;
    }

    singleLocation.value = position;

    final details = await _getAddressAndPlaceIdFromLatLng(position);
    singleAddress.value = details['address'];
    placeId.value = details['place_id'];
    print("Got place_id: ${placeId.value}");
  }


  Future<Map<String, String?>> _getAddressAndPlaceIdFromLatLng(LatLng pos) async {
   // Replace this
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        print('No internet');
        return {'address': 'No internet', 'place_id': null};
      }

      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${pos.latitude},${pos.longitude}&language=bn&key=$apiKey';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          final result = data['results'][0];
          final address = result['formatted_address'];
          final placeId = result['place_id'];
          return {'address': address, 'place_id': placeId};
        }
      }

      return {'address': 'Unknown location', 'place_id': null};
    } catch (e) {
      print('Error fetching address/place_id: $e');
      return {'address': 'Error', 'place_id': null};
    }
  }

  Future<void> addMultiLocation(LatLng position) async {
    if (multipleLocations.length >= 5) return;

    if (position.latitude < -90 || position.latitude > 90 || position.longitude < -180 || position.longitude > 180) {
      print('Invalid coordinates: $position');
      return;
    }
    multipleLocations.add(position);
    String address = await _getAddressFromLatLng(position);
    debugPrint('Selected Poristion ::: ${address}');
    addressMap[position] = address;
  }

  Future<String> _getAddressFromLatLng(LatLng pos) async {
    try {
      // Check network connectivity
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        print('No internet connection');
        return 'No internet connection';
      }
      // Validate coordinates
      if (pos.latitude < -90 || pos.latitude > 90 || pos.longitude < -180 || pos.longitude > 180) {
        print('Invalid coordinates: $pos');
        return 'Invalid location';
      }
      List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        debugPrint('Selected Place ::: ${placemarks.first}');
        return '${p.name ?? 'Unknown'}, ${p.locality ?? ''}, ${p.country ?? ''}'.trim();
      }
      print('No placemarks found for coordinates: $pos');
      return 'Unknown location';
    } catch (e) {
      print('Error getting address for $pos: $e');
      return 'Error fetching address';
    }
  }

  void resetSingle() {
    singleLocation.value = null;
    singleAddress.value = null;
  }

  void resetMulti() {
    multipleLocations.clear();
    addressMap.clear();
  }
}
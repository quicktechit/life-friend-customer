import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/controllers/division%20controller/division_controller.dart';
import 'dart:convert';

import 'package:pickup_load_update/src/models/suggestion_model.dart';
import 'package:pickup_load_update/src/widgets/division_box_widget.dart';

import '../../models/division_model.dart';

class LocationController extends GetxController {
  final Rx<TextEditingController?> activeController = Rx<TextEditingController?>(null);
  final DivisionController divisionContainer=Get.put(DivisionController());
  var isLoading = false.obs;
  var isLoadingDrop = false.obs;
  final TextEditingController viaTextC=TextEditingController();
  final TextEditingController pickUpC=TextEditingController();
  final TextEditingController dropC = TextEditingController();
  var pickUpLocation = ''.obs;
  var dropLocation = ''.obs;
  var viaLocation = ''.obs;
  var distance = ''.obs;
  var reachTime = ''.obs;
  var pickupDivision = ''.obs;
  var dropOffDivision = ''.obs;
  var selectedPickUpDistrict  = ''.obs;
  var selectedDropOffDistrict  = ''.obs;
  var selectedPickUpLat = ''.obs;
  var selectedPickUpLng = ''.obs;
  var selectedDropUpLat = ''.obs;
  var selectedDropUpLng = ''.obs;
  RxList suggestionsPickUp = <Suggestion>[].obs;
  RxList suggestionsDrop = <Suggestion>[].obs;
  RxList suggestionsVia = <Suggestion>[].obs;
  // var dropMultipleLatitudes = <RxString>[].obs;
  // var dropMultipleLongitudes = <RxString>[].obs;

  var apiKey="AIzaSyC1LrGdAl5vX5Jp9muuou2iAo52Yu49pFc";


  Future<void> fetchPickSuggestions(String input) async {
    isLoading(true);
    final String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:BD&key=$apiKey";

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['status'] == 'OK') {
        final predictions = jsonData['predictions'];
        suggestionsPickUp.clear();
        suggestionsPickUp.addAll(predictions
            .map<Suggestion>((e) => Suggestion.fromJson(e))
            .toList());
        isLoading(false);
      } else {
        isLoading(false);
        throw Exception('Failed to load suggestions: ${jsonData['status']}');
      }
    } else {
      isLoading(false);
      throw Exception('Failed to load suggestions');
    }
  }

  Future<void> fetchDropSuggestions(String input) async {
    isLoadingDrop(true);
    final String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:BD&key=$apiKey";

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['status'] == 'OK') {
        final predictions = jsonData['predictions'];
        suggestionsDrop.clear();
        suggestionsDrop.addAll(predictions
            .map<Suggestion>((e) => Suggestion.fromJson(e))
            .toList());
        isLoadingDrop(false);
      } else {
        isLoadingDrop(false);
        throw Exception('Failed to load suggestions: ${jsonData['status']}');
      }
    } else {
      isLoadingDrop(false);
      throw Exception('Failed to load suggestions');
    }
  }

  Future<void> fetchViaSuggestions(String input) async {
    isLoading(true);
    final String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:BD&key=$apiKey";

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['status'] == 'OK') {
        final predictions = jsonData['predictions'];
        suggestionsVia.clear();
        suggestionsVia.addAll(predictions
            .map<Suggestion>((e) => Suggestion.fromJson(e))
            .toList());
        isLoading(false);
      } else {
        isLoading(false);
        throw Exception('Failed to load suggestions: ${jsonData['status']}');
      }
    } else {
      isLoading(false);
      throw Exception('Failed to load suggestions');
    }
  }

  void selectViaAddress(Suggestion suggestion) async {
    final String placeId = suggestion.placeId;
    final String detailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry,address_components&key=$apiKey";

    final response = await http.get(Uri.parse(detailsUrl));
    isLoading(true);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final Map<String, dynamic> result = jsonData['result'];
      final Map<String, dynamic> geometry = result['geometry'];
      final Map<String, dynamic> location = geometry['location'];
      final double lat = location['lat'];
      final double lng = location['lng'];

      final List<dynamic> addressComponents = result['address_components'];
      String divisionName = '';
      isLoading(false);
      // Find the administrative_area_level_1 component
      for (final component in addressComponents) {
        final List<dynamic> types = component['types'];
        if (types.contains('administrative_area_level_1')) {
          divisionName = component['long_name'];
          break;
        }
      }

      print('Selected Drop Address: ${suggestion.description}');
      viaLocation.value = suggestion.description;
      print('Division Drop Name: $divisionName');
      print('Latitude: $lat, Longitude: $lng');

      // You can do other operations with the address, division name, lat, and lng here
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  void selectPikUpAddress(Suggestion suggestion) async {
    final String placeId = suggestion.placeId;
    final String detailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,formatted_address,geometry,address_components&language=bn&key=$apiKey";
    debugPrint('Details :: ${suggestion.placeId}');
    debugPrint('Url :: $detailsUrl');
    final response = await http.get(Uri.parse(detailsUrl));
    isLoading(true);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final Map<String, dynamic> result = jsonData['result'];
      final Map<String, dynamic> geometry = result['geometry'];
      final Map<String, dynamic> location = geometry['location'];
      final double lat = location['lat'];
      final double lng = location['lng'];

      final List<dynamic> addressComponents = result['address_components'];
      String district = '';
      String division = '';
      isLoading(false);
      // Find the administrative_area_level_1 component
      pickUpLocation.value = '${jsonData['result']['name']}';
      for (final component in addressComponents) {
        final List<dynamic> types = component['types'];
        if (types.contains('administrative_area_level_2')) {
          district = component['long_name'];
        }
        // if (types.contains('administrative_area_level_1')) {
        //   division = component['long_name'];
        //
        // }
      }

      print('Selected PickUp Address: ${suggestion.description}');
      selectedPickUpLat.value = lat.toString();
      selectedPickUpLng.value = lng.toString();
      selectedPickUpDistrict.value = district;
      final divisionName = await getDivisionFromPlaceId(placeId);
      // var divisionName=division.split(' ')[0];
      var matchedId = divisionContainer.divisionList
          .firstWhere(
            (division) => division.name == divisionName,
        orElse: () => DivisionList(),
      )
          .id.toString();
      pickupDivision.value=matchedId;
      print('District PickUp Name:: ${selectedPickUpDistrict.value}');
      print('Division PickUp division id:: ${pickupDivision.value}');
      print('Division PickUp Name:: ${divisionName}');
      print('Latitude: $lat, Longitude: $lng');
      
    } else {
      throw Exception('Failed to fetch place details');
    }
  }


  Future<String?> getDivisionFromPlaceId(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId'
        '&fields=address_components'
        '&language=en'
        '&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> components = jsonData['result']['address_components'];

        for (final component in components) {
          final List<dynamic> types = component['types'];
          if (types.contains('administrative_area_level_1')) {
            final String divisionName = component['long_name'];
            return divisionName.split(' ').first; // Optional: just "Dhaka" from "Dhaka Division"
          }
        }

        return null; // Division not found
      } else {
        print('Failed to fetch division: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching division: $e');
      return null;
    }
  }





  var dropUpBnLocation = ''.obs;

  getDropDetailsAddress(Suggestion suggestion) async {
    dropUpBnLocation.value = '';
    final String placeId = suggestion.placeId;
    final String detailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=name,formatted_address,geometry,address_components&language=bn&key=$apiKey";
    log('url====>>');
    debugPrint('Details :: ${suggestion.placeId}');
    final response = await http.get(Uri.parse(detailsUrl));
    isLoading(true);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final Map<String, dynamic> result = jsonData['result'];
      final List<dynamic> addressComponents = result['address_components'];
      isLoading(false);

      dropUpBnLocation.value = '${jsonData['result']['name']}';
      debugPrint('BN DROP:: ${dropUpBnLocation.value}');
    } else {
      throw Exception('Failed to fetch place details');
    }
  }


  Future<void> selectMultipleDropAddress(Suggestion suggestion,) async {
    final String placeId = suggestion.placeId;
    final String detailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry,address_components&language=bn&key=$apiKey";

    final response = await http.get(Uri.parse(detailsUrl));
    isLoading(true); // Set loading state

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final Map<String, dynamic> result = jsonData['result'];
      final Map<String, dynamic> geometry = result['geometry'];
      final Map<String, dynamic> location = geometry['location'];
      final double lat = location['lat'];
      final double lng = location['lng'];

      final List<dynamic> addressComponents = result['address_components'];
      isLoading(false); // Set loading state to false

      for (final component in addressComponents) {
        final List<dynamic> types = component['types'];
        if (types.contains('administrative_area_level_2')) {
          break;
        }
      }

      selectedDropUpLat.value = lat.toString();
      selectedDropUpLng.value = lng.toString();

      print('Selected Drop Address: ${suggestion.description}');
      print('Latitude: $lat, Longitude: $lng');
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  void selectDropAddress(Suggestion suggestion) async {
    final String placeId = suggestion.placeId;
    final String detailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry,address_components&language=bn&key=$apiKey";

    final response = await http.get(Uri.parse(detailsUrl));
    isLoading(true);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final Map<String, dynamic> result = jsonData['result'];
      final Map<String, dynamic> geometry = result['geometry'];
      final Map<String, dynamic> location = geometry['location'];
      final double lat = location['lat'];
      final double lng = location['lng'];

      final List<dynamic> addressComponents = result['address_components'];
      String districtName = '';
      isLoading(false);
      for (final component in addressComponents) {
        final List<dynamic> types = component['types'];
        if (types.contains('administrative_area_level_2')) {
          districtName = component['long_name'];
          break;
        }
      }

      print('Selected Drop Address: ${suggestion.description}');
      dropLocation.value = '${addressComponents[0]['long_name']} ${addressComponents[1]['long_name']}';

      selectedDropUpLat.value = lat.toString();
      selectedDropUpLng.value = lng.toString();
      selectedDropOffDistrict.value = districtName;
      print('District Drop Name:: ${selectedDropOffDistrict.value}');
      print('Latitude: $lat, Longitude: $lng');

      // You can do other operations with the address, division name, lat, and lng here
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  Future<void> getRoadDistance({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$originLat,$originLng&destinations=$destinationLat,$destinationLng&mode=driving&key=$apiKey';
    debugPrint('URL ::: $url');
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK') {
          final distanceValue = data['rows'][0]['elements'][0]['distance']['value']; // Distance in meters
          final duration = data['rows'][0]['elements'][0]['duration']['text'];

          // Convert distance to kilometers (if needed)
          double distanceInKm = distanceValue / 1000.0;

          // Update observable variable
          distance.value = distanceInKm.toStringAsFixed(1); // Rounded to 1 decimal place
          reachTime.value = duration;

          print('Distance in KM: $distanceInKm');
        } else {
          print('Error: ${data['status']}');
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


}
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/models/range%20model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/appBaseUrls.dart';
import '../../configs/appColors.dart';
import '../../configs/local_storage.dart';
import '../../models/truck_related_model/product_type_model.dart';
import '../../models/truck_related_model/service_model.dart';
import '../../models/truck_related_model/truck_category_model.dart';
import '../../pages/live bidding/live_biding_page_truck.dart';
import '../../widgets/loader_util.dart';
import '../live location controller/live_location_controller.dart';
import '../rental trip request controllers/rental_trip_req_submit_controller.dart';

class TruckController extends GetxController{
  var range=RangeModel().obs;
  var item = CategoryModel().obs;
  var sizeCategory=<Sizecategories>[].obs;
  var product=<Datas>[].obs;
  var service=<Dataa>[].obs;
  var box=GetStorage();
  var selectedCategory = Rx<Datas?>(null);
  final List<Map<String, String>> dropLatLngList = [];
  final List<String> locationNames = [];
  List<int> checkedIds = [];
  List<String> checkedTitle = [];
  final LocationController locationController = Get.put(LocationController());
  final TextEditingController productDetails=TextEditingController();
  var selectedDate = DateTime.now();
  var name='';
  var image='';
  var id='';
  var sizeId='';
  var truck_type='';
  var totalPrice='';
  var totalPriceNew = "";
  var selectedTime = TimeOfDay.now();
  var checkboxStates = <RxBool>[].obs;
  var index=-1.obs;
  var distances=''.obs;
  var amounts=0.obs;
  RxInt subtotal = 0.obs;
  List<String> multipleDropoffMap = [];
var price=''.obs;
  var isLaber = false.obs;
  var isLoading = false.obs;

  void updateSubtotal(bool applyExtra) {
    int total = 0;

    for (int i = 0; i < service.length; i++) {
      if (checkboxStates[i].value) {
        total += int.parse(service[i].fees??'0');
      }
    }

    subtotal.value = total;

    if (totalPrice != "Bid") {
      int basePrice = int.parse(totalPrice);
      int basePlusSubtotal = basePrice + total;
      // Apply 65% extra if the flag is true
      print(applyExtra);
      if (applyExtra) {
        print(applyExtra);
        double extra = basePlusSubtotal * 0.65;
        print(extra.toString()+" extra amount");
        totalPriceNew = (basePlusSubtotal + extra).toStringAsFixed(0); // Rounded
        print("Base + Subtotal: $basePlusSubtotal");
      } else {
        totalPriceNew = basePlusSubtotal.toString();
      }
    }

    // If totalPrice is ONLY the subtotal (no base price), use:
    // totalPrice.value = total.toString();
  }

  void validateInput(String value) {
    final enDigitRegex = RegExp(r'[0-9]{7,}');
    final bnDigitRegex = RegExp(r'[০-৯]{7,}');

    final enMatches = enDigitRegex.allMatches(value).toList();
    final bnMatches = bnDigitRegex.allMatches(value).toList();

    if (enMatches.isEmpty && bnMatches.isEmpty) return;

    String newText = value;

    final allMatches = [...enMatches, ...bnMatches]..sort((a, b) => b.start.compareTo(a.start));
    for (final match in allMatches) {
      newText = newText.replaceRange(match.start, match.end, '');
    }

    Get.snackbar(
      'Warning',
      'Cannot enter more than 6 digits in a row (English or Bengali)',
      colorText: Colors.white,
      backgroundColor: Colors.black,
    );

    // Clear or correct text
    productDetails.text = newText;
    productDetails.selection = TextSelection.fromPosition(
      TextPosition(offset: newText.length),
    );
  }




  Future<void> getTruckCategory() async {
    final url = Uri.parse(Urls.truckCategory);

    final Map<String, dynamic> body = {
      'category_id': 1,
    };

    // try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        sizeCategory.clear();
        item.value = CategoryModel.fromJson(data);
        sizeCategory.value=item.value.data!.sizecategories!;

        print('Data saved to model: $item');
      } else {
        print('Failed to send SMS. Status code: ${response.statusCode}');
      }
    // } catch (e) {
    //   print('Error getting data: $e');
    // }
  }


  Future<void> getService(id) async {
    final url = Uri.parse(Urls.service);

    final Map<String, dynamic> body = {
      'vehicle_id': id,
    };
    print("servide called $id");
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        service.clear();  // Clear the existing service data

        final datas = ServiceModel.fromJson(data);  // Parse the new data
        service.value = datas.data!;  // Update the service list

        // Update checkboxStates to match the length of the new service list
        // Generate a list of RxBool (not just bool)
        checkboxStates.value = List.generate(service.length, (index) => false.obs);

        print('Data saved to model: $data');
      } else {
        print('Failed to get service data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting data: $e');
    }
  }

  Future<void> getAmount(id) async {
    final url = Uri.parse(Urls.singleTripAmount);
print(id);
    final Map<String, dynamic> body = {
      'vehicle_id': id.toString(),
    };
    // try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {

        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['data'] != null) {
          final amount = responseData['data']['amount'].toString();

          if (amount != 'null') {
            amounts.value=int.parse(amount);
            print('Amount: $amount');
          } else {
            print('Amount is null');
          }
        } else {
          print('Data is null or not present in the response');
        }
      } else {
        print('Failed to get data. Status code: ${response.statusCode}');
      }
    // } catch (e) {
    //   print('Error getting data: $e');
    // }
  }


  Future<void> productType() async {
      try {
      final response = await http.get(Uri.parse(Urls.typeCatList));

      if (response.statusCode == 200) {
        product.clear();
        var jsonResponse = json.decode(response.body);
        var data=ProductCategory.fromJson(jsonResponse);
        product.value=data.data!;
        print("success");
      } else {
        throw Exception('Failed to load data code:${response.statusCode}');
      }
    } catch (e) {
      print('Error getting data: $e');
    }
  }

  Future<void> getRange(id) async {
    // try {
      print(Uri.parse("${Urls.range}$id"));

      final response = await http.get(Uri.parse("${Urls.range}$id"));

      if (response.statusCode == 200) {

        var jsonResponse = jsonDecode(response.body);
        range.value=RangeModel.fromJson(jsonResponse);
      } else {
        print("error");
      }
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<void> sendExtraMoney({
    required String tripId,         // trip_id to send
    required String extendedAmount, // extended_amount to send
      // Bearer token for authentication
  }) async {
    // Define the endpoint URL
    SharedPreferencesManager _prefsManager =
    await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();
    final String url = Urls.extraAmount;

    // Prepare the request data
    Map<String, dynamic> requestData = {
      'trip_id': tripId,
      'extended_amount': extendedAmount,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestData),
      );


      if (response.statusCode == 200) {
        print('Request was successful');
        totalPrice =
            (int.parse(totalPrice) + int.parse(extendedAmount.toString()))
                .toString();
        print('Response body: ${response.body}');
        Get.snackbar('Success', 'add money success',
            colorText: white, backgroundColor: Colors.black);
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        Get.snackbar('Failed', 'add money failed',
            colorText: white, backgroundColor: Colors.black);
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  Future<void> sendRequest({
    required String categoryId,
    required String sizeCategoryId,
    required String truckType,
    required String vehicleId,
    required String pickupLocation,
    String? viaLocation,
    required String dateTime,
    required String map,
    required String productType,
    required String productDetails,
    required bool isLabour,
    required String distance,
    required String amount,
    required String pickupDivision,
    // required String dropOfDivision,
    required List<int> tripService,
    required List<String> multipleDropoffLocation,
    required List<String> multipleDropoffMap,
  }) async
  {
    // Define the endpoint URL
    final String url = Urls.rentalTripSubmit;  // Replace with your actual API URL
    SharedPreferencesManager _prefsManager =
    await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();
    // Prepare the request data
    Map<String, dynamic> requestData = {
      'category_id': categoryId,
      'sizecategory_id': sizeCategoryId,
      'truck_type': truckType,
      'vehicle_id': vehicleId,
      "pickup_division": pickupDivision,
      // "dropoff_division": dropOfDivision,
      'pickup_location': pickupLocation,
      'via_location': viaLocation ?? '',
      'datetime': dateTime,
      'map': map,
      'product_type': productType,
      'product_details': productDetails,
      'is_labour': isLabour ? 1 : 0,
      'distance': distance,
      'amount': amount,
      'trip_service': tripService,
      'multiple_dropoff_location': multipleDropoffLocation,
      'multiple_dropoff_map': multipleDropoffMap,
    };

    try {
      LoaderUtils().showLoading();
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);


        if (responseData['status'] == 'success') {
          final id = responseData['data']['id'];
          box.write("BUIDID", id.toString());
          LoaderUtils().hideGetLoading();
          Get.snackbar('Congress', 'Trip Request Submit',
              colorText: white, backgroundColor: Colors.black);
          Get.put(RentalTripSubmitController()).liveBidTruckStart.value=true;

          box.write("liveBidTruckStart", true);
          box.write("isTruckType","Truck");
          var startTime = DateTime.now();
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('timer_start_time', startTime.millisecondsSinceEpoch);
          Get.to(
                () => LiveBiddingPageTruck(
              createdAt: DateTime.now().toLocal().toString(),
              id: id.toString(),
            ),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 1),
          );
          isLoading.value = false;
        } else {
          isLoading.value = false;
          LoaderUtils().hideGetLoading();
          print('Request failed with message: ${responseData['message']}');
        }
      } else {
        isLoading.value = false;
        LoaderUtils().hideGetLoading();
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      LoaderUtils().hideGetLoading();

      isLoading.value = false;
      print('trip submit: $e');
    }
  }

  int calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    // Convert the distance to an int (rounds down)
    int intDistance = distance.toInt();  // This truncates the decimal part

    distances.value = intDistance.toString();  // Update your state with the int distance

    return intDistance;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }

  calculateRangeAmount(){
    if (dropLatLngList.isNotEmpty) {
      final latLng = dropLatLngList.last;

      // Log the values to verify what's being parsed
      print("LatLng: ${latLng['lat']}, ${latLng['lng']}");

      // Ensure lat and lng are valid numbers
      double? dropLat = double.tryParse(latLng['lat'] ?? '');
      double? dropLng = double.tryParse(latLng['lng'] ?? '');
      // log(locationController.selectedPickUpLat.value);
      // log(locationController.selectedPickUpLng.value);

      // Check if either lat or lng is null (invalid)
      if (dropLat != null && dropLng != null) {
        var distance = calculateDistance(
          double.parse(locationController.selectedPickUpLat.value),
          double.parse(locationController.selectedPickUpLng.value),
          dropLat,
          dropLng,
        );

        if (int.parse(distance.toString()) <=
            int.parse(range.value.data!.distance
                .toString())) {
          price.value =
          "${range.value.data?.fixedPrice.toString()}";
        } else {
          price.value = 'Bid';
        }
        print( "${price.value}amount on select location");
        print("${distance}distance");
      } else {
        print(
            'Invalid drop location coordinates: $dropLat, $dropLng');
      }
    } else {
      print('dropLatLngList is empty');
    }
  }

}
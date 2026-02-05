import 'package:get/get.dart';

class QuickTechAirportController extends GetxController{
  var selectedLocation = 'Airport'.obs;
  var selectedTripType = 'round'.obs;
  RxInt hour = RxInt(2);
  void setTripType(String location) {
    selectedTripType.value = location;
  }
  void setLocation(String location) {
    selectedLocation.value = location;
  }
  var selectedAirport = 'Hazrat Shahjalal International Airport'.obs;
  var selectedCoordinates = '23.851400 90.408600'.obs;
  final List<String> airports = [
    'Hazrat Shahjalal International Airport',
    'Shah Amanat International Airport',
    'Osmani International Airport',
    'Cox\'s Bazar Airport',
    'Jessore Airport',
    'Saidpur Airport',
    'Shah Makhdum Airport',
    'Barisal Airport'
  ];

  final Map<String, String> airportCoordinates = {
    'Hazrat Shahjalal International Airport': '23.851400 90.408600',
    'Shah Amanat International Airport': '22.249700 91.813300',
    'Osmani International Airport': '24.963300 91.866800',
    'Cox\'s Bazar Airport': '21.452200 91.963900',
    'Jessore Airport': '23.183800 89.160800',
    'Saidpur Airport': '25.759200 88.908900',
    'Shah Makhdum Airport': '24.437200 88.616500',
    'Barisal Airport': '22.801000 90.301200'
  };

  void updateSelectedCoordinates(String selectedAirport) {
    selectedCoordinates.value = airportCoordinates[selectedAirport] ?? '';
  }
}
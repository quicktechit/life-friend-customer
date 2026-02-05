import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/configs/local_storage.dart';

Future<void> sendTimeExpiredSMS(String tripId) async {
  SharedPreferencesManager _prefsManager =
      await SharedPreferencesManager.getInstance();
  String? token = _prefsManager.getToken();

  final url = Uri.parse(
      'https://carbook.cutiaidcorporation.com/api/v1/customer/time-expired-sms');

  final Map<String, dynamic> body = {
    'trip_id': tripId,
  };

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('SMS sent successfully');
    } else {
      print('Failed to send SMS. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending SMS: $e');
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/widgets/snack_bar/snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import '../configs/appBaseUrls.dart';
import '../configs/local_storage.dart';

class PdfController extends GetxController {
  var fileName=''.obs;

  Future<void> generatePdf({
    required String tripId,
    required String tripType,
  }) async {
    SharedPreferencesManager _prefsManager =
    await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();
    var url = Uri.parse(Urls.pdfGenerate);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var body = json.encode({"trip_id": tripId, "trip_type": tripType});

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print('PDF Generation Successful:');
        print(response.body);

        var jsonResponse = json.decode(response.body);

        String file = jsonResponse['file_name'];


        fileName.value = file;

      } else {
        kSnackBar(message: "Cannot Generate Pdf", bgColor: Vx.red300);
        print('Failed to generate PDF. Status code: ${response.statusCode}');
        print('Response: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> downloadPdf(String fileName) async {
    var url = Uri.parse(Urls.pdfDownload + fileName);
    SharedPreferencesManager _prefsManager =
    await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();
    var headers = {
      'Authorization': 'Bearer $token'
    };

    try {
      // Request storage permission
      // var status = await Permission.storage.request();
      // if (!status.isGranted) {
      //   print("Storage permission denied");
      //   return;
      // }

      // Download file
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final downloadsPath = "/storage/emulated/0/Download";
        final file = File('$downloadsPath/$fileName');

        await file.writeAsBytes(response.bodyBytes);
        print("PDF saved to Downloads: ${file.path}");
        kSnackBar(message: "Pdf Download Successfully", bgColor: Colors.green);
      } else {
        kSnackBar(message: "Pdf Download Failed", bgColor: Colors.red);
        print("Failed to download PDF: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}

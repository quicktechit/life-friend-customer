import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/controllers/pdf_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pickup_load_update/src/models/single_trip_details_model.dart' as normal_model;
import '../../controllers/single trip details controller/single_trip_details_controller.dart';
import '../../models/single_return_trip_model.dart' as return_model;

const Color primaryRed = Color(0xFFC62828); // Deep Red
const Color primaryRedLight = Color(0xFFEF5350);
const Color primaryRedDark = Color(0xFF8E0000);
const Color backgroundColor = Color(0xFFF5F5F5);
const Color cardColor = Colors.white;
const Color textPrimary = Color(0xFF212121);
const Color textSecondary = Color(0xFF757575);
const Color dividerColor = Color(0xFFEEEEEE);

class SingleHistoryTripDetailsPage extends StatefulWidget {
  final String tripId;
  final String type;
  final bool? isComplete;
  final bool? isConfirm;
  final bool? isCancel;
  final bool? isReturn;

  const SingleHistoryTripDetailsPage({
    super.key,
    required this.tripId,
    required this.type,
    this.isComplete = false,
    this.isCancel = false,
    this.isConfirm = false,
    this.isReturn = false,
  });

  @override
  State<SingleHistoryTripDetailsPage> createState() =>
      _SingleHistoryTripDetailsPageState();
}

class _SingleHistoryTripDetailsPageState
    extends State<SingleHistoryTripDetailsPage> {
  final SingleTripDetailsController _singleTripDetailsController =
  Get.put(SingleTripDetailsController());
  final PdfController pdfController = Get.put(PdfController());

  @override
  void initState() {
    super.initState();
    _singleTripDetailsController
        .singleTripDetails(widget.tripId, widget.type)
        .then((value) {
      if (widget.isComplete == true) {
        if (widget.isReturn == true) {
          pdfController.generatePdf(
              tripId: widget.tripId, tripType: "return_trip");
        } else {
          pdfController.generatePdf(
              tripId: widget.tripId, tripType: "rental_trip");
        }
      }
    });
  }

  // Helper methods to get data based on trip type
  normal_model.Data? get _normalTripData =>
      _singleTripDetailsController.singleTripDetailsModel.value.data;

  return_model.Data? get _returnTripData =>
      _singleTripDetailsController.singleReturnTripDetailsModel.value.data;

  normal_model.TripHistory? get _normalTripHistory =>
      _normalTripData?.tripHistory;

  return_model.TripHistory? get _returnTripHistory =>
      _returnTripData?.tripHistory;

  Widget _buildTripInfoSection(bool isNormalTrip) {
    final trackingId = isNormalTrip
        ? _normalTripHistory?.trackingId
        : _returnTripHistory?.trackingId;

    final dateTime = isNormalTrip
        ? _normalTripHistory?.datetime
        : _returnTripHistory?.timedate;

    final pickupLocation = isNormalTrip
        ? _normalTripHistory?.pickupLocation
        : _returnTripHistory?.location;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: primaryRed, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Trip Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: dividerColor, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  icon: Icons.confirmation_number,
                  label: 'Trip ID',
                  value: '#${trackingId ?? "N/A"}',
                  valueStyle: TextStyle(
                    color: primaryRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: 'Date & Time',
                  value: dateTime ?? "N/A",
                ),
                const SizedBox(height: 12),
                _buildLocationSection(isNormalTrip),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(bool isNormalTrip) {
    final pickupLocation = isNormalTrip
        ? _normalTripHistory?.pickupLocation
        : _returnTripHistory?.location;

    final dropoffLocations = isNormalTrip
        ? _normalTripHistory?.dropoffLocations
        : _returnTripHistory?.dropoffLocations;

    final dropoffLocation = isNormalTrip
        ? _normalTripHistory?.dropoffLocation
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: primaryRed,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.location_on, color: Colors.white, size: 12),
                ),
                Container(
                  width: 2,
                  height: 30,
                  color: primaryRed.withOpacity(0.3),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: primaryRedLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.flag, color: Colors.white, size: 12),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup Location',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pickupLocation ?? "N/A",
                    style: TextStyle(
                      fontSize: 14,
                      color: textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Dropoff Location(s)',
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isNormalTrip)
                    _buildNormalDropoffLocations(
                      dropoffLocations as List<normal_model.DropoffLocations>?,
                      dropoffLocation,
                    )
                  else
                    _buildReturnDropoffLocations(
                      dropoffLocations as List<return_model.DropoffLocations>?,
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNormalDropoffLocations(
      List<normal_model.DropoffLocations>? dropoffLocations,
      dynamic dropoffLocation,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (dropoffLocations != null && dropoffLocations.isNotEmpty)
          for (var location in dropoffLocations)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                location.dropoffLocation ?? "N/A",
                style: TextStyle(
                  fontSize: 14,
                  color: textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        if (dropoffLocation != null && dropoffLocation.toString().isNotEmpty)
          Text(
            dropoffLocation.toString(),
            style: TextStyle(
              fontSize: 14,
              color: textPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        if ((dropoffLocations == null || dropoffLocations.isEmpty) &&
            (dropoffLocation == null || dropoffLocation.toString().isEmpty))
          Text(
            "N/A",
            style: TextStyle(
              fontSize: 14,
              color: textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildReturnDropoffLocations(
      List<return_model.DropoffLocations>? dropoffLocations,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (dropoffLocations != null && dropoffLocations.isNotEmpty)
          for (var location in dropoffLocations)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                location.dropoffLocation ?? "N/A",
                style: TextStyle(
                  fontSize: 14,
                  color: textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        if (dropoffLocations == null || dropoffLocations.isEmpty)
          Text(
            "N/A",
            style: TextStyle(
              fontSize: 14,
              color: textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildVehicleSection(bool isNormalTrip) {
    final vehicleName = isNormalTrip
        ? _normalTripHistory?.vehicle?.name
        : _returnTripHistory?.getvehicle?.name;

    final vehicleImage = isNormalTrip
        ? _normalTripHistory?.vehicle?.image
        : _returnTripHistory?.getvehicle?.image;

    final vehicleCapacity = isNormalTrip
        ? _normalTripHistory?.vehicle?.capacity
        : _returnTripHistory?.getvehicle?.capacity;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.directions_car, color: primaryRed, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Vehicle Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: dividerColor, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                    image: vehicleImage != null && vehicleImage.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(
                        Urls.getImageURL(endPoint: vehicleImage),
                      ),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: vehicleImage == null || vehicleImage.isEmpty
                      ? Icon(Icons.directions_car,
                      size: 40, color: primaryRed.withOpacity(0.3))
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vehicleName ?? "N/A",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: primaryRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${vehicleCapacity ?? "N/A"} Seats',
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryRed,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required String title,
    required String name,
    required String phone,
    required String? imageUrl,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  title == 'Driver Info'
                      ? Icons.person_outline
                      : Icons.business_center,
                  color: primaryRed,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: dividerColor, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    image: imageUrl != null && imageUrl.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(
                        Urls.getImageURL(endPoint: imageUrl),
                      ),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: imageUrl == null || imageUrl.isEmpty
                      ? Icon(Icons.person,
                      size: 30, color: primaryRed.withOpacity(0.3))
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        phone,
                        style: TextStyle(
                          fontSize: 14,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onTap,
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryRed,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripDetailsSection(bool isNormalTrip) {
    final roundTripText = isNormalTrip
        ? (_normalTripHistory?.roundTrip == '1' ? "Yes" : "No")
        : "No";

    final amount = isNormalTrip
        ? _normalTripHistory?.amount?.toString()
        : _returnTripHistory?.amount;
    final otp = isNormalTrip
        ? _normalTripHistory?.otp?.toString()
        : "N/A";

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.receipt_long, color: primaryRed, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Trip Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textPrimary,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: dividerColor, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDetailRow(
                  'Otp',otp.toString(),
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Round Trip',
                  roundTripText,
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Total Distance',
                  '${calculateTotalDistance().toStringAsFixed(2)} km',
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Total Fare',
                  amount != null ? "$amount ৳" : "N/A",
                  valueStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryRed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Row(
      children: [
        Icon(icon, color: primaryRed.withOpacity(0.7), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: valueStyle ??
                    TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String title, String value, {TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: valueStyle ??
              TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textPrimary,
              ),
        ),
      ],
    );
  }

  Widget _buildPdfButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      alignment: AlignmentGeometry.center,
      child: ElevatedButton(
        onPressed: () {
          pdfController.downloadPdf(pdfController.fileName.value);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          minimumSize: Size(Get.width * 0.7, 56),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.download, size: 24),
            const SizedBox(width: 12),
            const Text(
              'Download PDF',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isNormalTrip = widget.type == "normal";

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Trip Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (_singleTripDetailsController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: primaryRed,
            ),
          );
        }

        if (isNormalTrip) {
          // Handle normal trip
          final normalData = _normalTripData;
          if (normalData == null) {
            return _buildNoDataView();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip Information Card
                _buildTripInfoSection(true),

                const SizedBox(height: 20),

                // Vehicle Details Card
                _buildVehicleSection(true),

                const SizedBox(height: 20),

                // Partner Information (if available)
                if (widget.isCancel != true &&
                    widget.isComplete != true &&
                    normalData.partner != null)
                  Column(
                    children: [
                      _buildContactCard(
                        title: 'Partner Info',
                        name: normalData.partner!.name ?? "N/A",
                        phone: normalData.partner!.phone ?? "N/A",
                        imageUrl: normalData.partner!.image,
                        onTap: () async {
                          final phone = normalData.partner!.phone;
                          if (phone != null && phone.isNotEmpty) {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: phone,
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                // Driver Information (if available)
                if (widget.isCancel != true &&
                    widget.isComplete != true &&
                    widget.isConfirm == false &&
                    normalData.driver != null)
                  Column(
                    children: [
                      _buildContactCard(
                        title: 'Driver Info',
                        name: normalData.driver!.name ?? "N/A",
                        phone: normalData.driver!.phone ?? "N/A",
                        imageUrl: normalData.driver!.image,
                        onTap: () async {
                          final phone = normalData.driver!.phone;
                          if (phone != null && phone.isNotEmpty) {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: phone,
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                // Trip Details Summary
                _buildTripDetailsSection(true),

                // PDF Download Button (if trip is complete)
                if (widget.isComplete == true) _buildPdfButton(),

                const SizedBox(height: 30),
              ],
            ),
          );
        } else {
          // Handle return trip
          final returnData = _returnTripData;
          if (returnData == null) {
            return _buildNoDataView();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip Information Card
                _buildTripInfoSection(false),

                const SizedBox(height: 20),

                // Vehicle Details Card
                _buildVehicleSection(false),

                const SizedBox(height: 20),

                // Partner Information (if available)
                if (widget.isCancel != true &&
                    widget.isComplete != true &&
                    returnData.partner != null)
                  Column(
                    children: [
                      _buildContactCard(
                        title: 'Partner Info',
                        name: returnData.partner!.name ?? "N/A",
                        phone: returnData.partner!.phone ?? "N/A",
                        imageUrl: returnData.partner!.image,
                        onTap: () async {
                          final phone = returnData.partner!.phone;
                          if (phone != null && phone.isNotEmpty) {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: phone,
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                // Driver Information (if available)
                if (widget.isCancel != true &&
                    widget.isComplete != true &&
                    widget.isConfirm == false &&
                    returnData.driver != null)
                  Column(
                    children: [
                      _buildContactCard(
                        title: 'Driver Info',
                        name: returnData.driver!.name ?? "N/A",
                        phone: returnData.driver!.phone ?? "N/A",
                        imageUrl: returnData.driver!.image,
                        onTap: () async {
                          final phone = returnData.driver!.phone;
                          if (phone != null && phone.isNotEmpty) {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: phone,
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),

                // Trip Details Summary
                _buildTripDetailsSection(false),

                // PDF Download Button (if trip is complete)
                if (widget.isComplete == true) _buildPdfButton(),

                const SizedBox(height: 30),
              ],
            ),
          );
        }
      }),
    );
  }
  Widget _buildNoDataView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: primaryRed.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            'No trip data available',
            style: TextStyle(
              fontSize: 18,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  // Fixed calculateTotalDistance with separate handling
  double calculateTotalDistance() {
    try {
      if (widget.type == "normal") {
        // Normal trip calculation
        final tripHistory = _normalTripHistory;
        if (tripHistory == null) return 0.0;

        String? map = tripHistory.map;
        String? dropOffMap;

        // Check for dropoffMap in tripHistory
        if (tripHistory.dropoffMap != null && tripHistory.dropoffMap.toString().isNotEmpty) {
          dropOffMap = tripHistory.dropoffMap.toString().replaceAll(',', ' ');
        }
        // Check for dropoffMap in dropoffLocations
        else if (tripHistory.dropoffLocations != null && tripHistory.dropoffLocations!.isNotEmpty) {
          dropOffMap = tripHistory.dropoffLocations!.last.dropoffMap?.replaceAll(',', ' ');
        }

        if (map != null && dropOffMap != null && map.isNotEmpty && dropOffMap.isNotEmpty) {
          return _singleTripDetailsController.calculateDistance(map, dropOffMap);
        }
      } else {
        // Return trip calculation
        final tripHistory = _returnTripHistory;
        if (tripHistory == null) return 0.0;

        String? map;
        String? dropOffMap;

        // For return trips, check bidLists first
        if (tripHistory.bidLists != null && tripHistory.bidLists!.isNotEmpty) {
          map = tripHistory.bidLists!.last.map;
        }

        // Check for dropoffMap in dropoffLocations
        if (tripHistory.dropoffLocations != null && tripHistory.dropoffLocations!.isNotEmpty) {
          dropOffMap = tripHistory.dropoffLocations!.last.dropoffMap?.replaceAll(',', ' ');
        }

        if (map != null && dropOffMap != null && map.isNotEmpty && dropOffMap.isNotEmpty) {
          return _singleTripDetailsController.calculateDistance(map, dropOffMap);
        }
      }
    } catch (e) {
      print('Error calculating distance: $e');
    }

    return 0.0;
  }
}
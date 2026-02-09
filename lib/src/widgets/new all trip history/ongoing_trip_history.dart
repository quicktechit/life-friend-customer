import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../configs/appBaseUrls.dart';
import '../../configs/appColors.dart';
import '../../configs/appUtils.dart';
import '../../configs/empty_box_widget.dart';
import '../../configs/loader.dart';
import '../../controllers/new all trip history/all_trip_history_controller.dart';
import '../../models/new_all_trip_history_model.dart';
import '../../pages/home/rental/tripHistoryPage.dart';
import '../../pages/map_page/map_page_view.dart';
import '../../pages/single history trip details/single_history_trip_details.dart';
import '../text/kText.dart';

class OngoingTripHistory extends StatefulWidget {
  const OngoingTripHistory({super.key});

  @override
  State<OngoingTripHistory> createState() => _OngoingTripHistory();
}

class _OngoingTripHistory extends State<OngoingTripHistory> {
  final NewAllTripHistoryController _controller =
  Get.put(NewAllTripHistoryController());

  final int maxWordsToShow = 4;

  // Deep red colors
  final Color primaryDark = primaryColor.withRed(200);
  final Color ongoingColor = Color(0xFFFF9800);
  final Color cardColor = Colors.white;
  final Color textColor = black54;
  final Color subtitleColor = grey;
  final Color borderColor = white;

  @override
  void initState() {
    super.initState();
    _controller.getOngoingTrip();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Obx(() => _controller.isLoading.value
          ? Center(
        child: loader(),
      )
          : _controller.allOngoingTripHistory.isEmpty
          ? Center(
        child: EmptyBoxWidget(
          title: 'No ongoing trips available!',
          truckImage: 'assets/images/empty.png',

        ),
      )
          : ListView.separated(
        padding: EdgeInsets.only(top: 16,left: 10,right: 10,bottom: 90.h),
        itemCount: _controller.allOngoingTripHistory.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final SortedTrips item = _controller.allOngoingTripHistory[index];

          String? pickUpCoordinates;
          String? downCoordinates;
          double upLat = 0.0, upLng = 0.0, downLat = 0.0, downLng = 0.0;

          // Your existing coordinate parsing logic
          if (item.rentalRelationships != null) {
            pickUpCoordinates = item.rentalRelationships?.trip?.map?.toString().toString().replaceAll(',', ' ');

            if (item.rentalRelationships?.trip?.dropoffLocations?.isNotEmpty ?? false) {
              downCoordinates = item.rentalRelationships?.trip?.dropoffLocations?.last.dropoffMap.toString().replaceAll(',', ' ');
            } else {
              downCoordinates = item.rentalRelationships?.trip?.dropoffMap.toString().replaceAll(',', ' ');
            }
          } else {
            pickUpCoordinates = item.returnRelationships?.customerBidDetails?.map?.toString();

            if (item.returnRelationships?.returnTrip?.dropoffLocations?.isNotEmpty ?? false) {
              String? modified = item.returnRelationships?.returnTrip?.dropoffLocations?.last.dropoffMap.toString().replaceAll(',', ' ');
              downCoordinates = modified;
            } else {
              downCoordinates = "No dropoff location available";
            }
          }

          if (pickUpCoordinates != null && pickUpCoordinates.contains(' ')) {
            try {
              List<String> pickUpParts = pickUpCoordinates.split(' ');
              upLat = double.parse(pickUpParts[0]);
              upLng = double.parse(pickUpParts[1]);
            } catch (e) {
              print("Error parsing pickup coordinates: $pickUpCoordinates");
            }
          }

          if (downCoordinates != null && downCoordinates.contains(' ')) {
            try {
              List<String> downUpParts = downCoordinates.split(' ');
              downLat = double.parse(downUpParts[0]);
              downLng = double.parse(downUpParts[1]);
            } catch (e) {
              print("Error parsing drop-off coordinates: $downCoordinates");
            }
          }

          return InkWell(
            onTap: () {
              Get.to(() => SingleHistoryTripDetailsPage(
                tripId: item.tripId.toString(),
                type: item.returnRelationships != null ? 'return' : "normal",
              ));
            },
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border.all(color: borderColor, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with trip ID and ONGOING status
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: ongoingColor.withOpacity(0.08),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      border: Border(
                        bottom: BorderSide(color: borderColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: ongoingColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: ongoingColor.withOpacity(0.4), width: 1),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.directions_car, size: 12, color: ongoingColor),
                              SizedBox(width: 6),
                              Text(
                                'ONGOING',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: ongoingColor,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Trip ID: ${item.trackingId}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        if (item.returnRelationships != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Color(0xFF2196F3).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFF2196F3).withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.autorenew, size: 12, color: Color(0xFF2196F3)),
                                SizedBox(width: 4),
                                Text(
                                  'RETURN',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2196F3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Vehicle and route section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Vehicle with badge
                        Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[100],
                                image: DecorationImage(
                                  image: NetworkImage(
                                    Urls.getImageURL(
                                      endPoint: item.rentalRelationships != null
                                          ? "${item.rentalRelationships?.vehicle?.image}"
                                          : "${item.returnRelationships?.returnVehicle?.image}",
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: item.rentalRelationships?.vehicle?.image == null &&
                                  item.returnRelationships?.returnVehicle?.image == null
                                  ? Center(
                                child: Icon(
                                  Icons.directions_car,
                                  color: primaryColor,
                                  size: 30,
                                ),
                              )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  item.rentalRelationships != null
                                      ? "${item.rentalRelationships?.vehicle?.name?.toUpperCase() ?? 'N/A'}"
                                      : "${item.returnRelationships?.returnVehicle?.name?.toUpperCase() ?? 'N/A'}",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 8),

                        // Route details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Pickup location with icon
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.green.withOpacity(0.2)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on, size: 16, color: Colors.green),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pickup Location',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: subtitleColor,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            item.rentalRelationships != null
                                                ? "${item.rentalRelationships?.trip?.pickupLocation}"
                                                : "${item.returnRelationships?.returnTrip?.location}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Arrow indicator
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Center(
                                  child: Container(
                                    width: 30,
                                    height: 1,
                                    color: primaryColor.withOpacity(0.3),
                                  ),
                                ),
                              ),

                              // Dropoff locations
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.red.withOpacity(0.2)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: 16, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text(
                                          'Dropoff Location${(item.rentalRelationships?.trip?.dropoffLocations?.length ?? 0) > 1 ? 's' : ''}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: subtitleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    if (item.rentalRelationships != null && item.rentalRelationships!.trip!.dropoffLocations != null)
                                      ...item.rentalRelationships!.trip!.dropoffLocations!.map((location) => Padding(
                                        padding: EdgeInsets.only(left: 24, bottom: 2),
                                        child: Text(
                                          "• ${location.dropoffLocation}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: textColor,
                                          ),
                                        ),
                                      )).toList(),
                                    if (item.rentalRelationships?.trip?.dropoffLocation != null)
                                      Padding(
                                        padding: EdgeInsets.only(left: 24),
                                        child: Text(
                                          "• ${item.rentalRelationships?.trip?.dropoffLocation}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                    if (item.rentalRelationships == null)
                                      Padding(
                                        padding: EdgeInsets.only(left: 24),
                                        child: Text(
                                          truncateTextIfNeeded(
                                              "${item.returnRelationships?.returnTrip?.destination}",
                                              maxWordsToShow),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: textColor,
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
                  ),

                  // Trip details and timing
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border(
                        top: BorderSide(color: borderColor),
                        bottom: BorderSide(color: borderColor),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 14, color: subtitleColor),
                                  SizedBox(width: 8),
                                  Text(
                                    'Trip Time:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: subtitleColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  item.rentalRelationships != null
                                      ? DateFormat("hh:mma dd-MM-yyyy").format(
                                      DateFormat("yyyy-MM-dd hh:mm a").parse(
                                          "${item.rentalRelationships?.trip?.datetime}")).toLowerCase()
                                      : "${item.returnRelationships?.returnTrip?.timedate}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (item.rentalRelationships != null && item.rentalRelationships!.trip!.roundTrip != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9800).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Color(0xFFFF9800).withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.autorenew, size: 12, color: Color(0xFFFF9800)),
                                SizedBox(width: 4),
                                Text(
                                  item.rentalRelationships?.trip?.roundTrip ?? 'NO',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFFF9800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Footer with actions and fare
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // View Map button
                        InkWell(
                          onTap: () {
                            if (upLat != 0.0 && upLng != 0.0) {
                              Get.to(() => MapWithDirections(
                                pickUpLat: upLat,
                                pickUpLng: upLng,
                                dropUpLat: downLat,
                                dropUpLng: downLng,
                              ));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: primaryColor, width: 1.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.map, size: 14, color: primaryColor),
                                SizedBox(width: 6),
                                Text(
                                  'View Map',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Fare amount
                        if (item.amount != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryColor, primaryDark],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Fare:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '${item.amount.toString()} ৳',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // View Details button
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 12),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => SingleHistoryTripDetailsPage(
                          tripId: item.tripId.toString(),
                          type: item.returnRelationships != null ? 'return' : "normal",
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View Trip Details',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, size: 14, color: primaryColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      ),
    );
  }

  String truncateTextIfNeeded(String text, int maxWords) {
    if (text.isEmpty) {
      return "N/A";
    }

    List<String> words = text.split(RegExp(r'\s+'));
    int wordCount = words.length;

    return wordCount > maxWords ? '${words.take(maxWords).join(" ")}...' : text;
  }
}
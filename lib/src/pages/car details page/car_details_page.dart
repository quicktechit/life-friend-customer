
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/car%20details%20controller/car_details_controller.dart';

import '../../models/car_details_model.dart' as details;

Widget _buildStarRating(int starCount) {
  List<Widget> stars = List.generate(
    5,
        (index) => Icon(
      index < starCount ? Icons.star : Icons.star_border,
      color: Colors.amber,
      size: 18,
    ),
  );
  return Row(children: stars);
}

class CarDetailsPage extends StatefulWidget {
  final String tripId;
  final String bidId;

  const CarDetailsPage({super.key, required this.tripId, required this.bidId});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  final CarDetailsController _carDetailsController =
  Get.put(CarDetailsController());

  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _carDetailsController.carDetails(
        tripId: widget.tripId, bidId: widget.bidId);
  }

  List<String> _getCarImages() {
    final vehicle = _carDetailsController.carDetailsModel.value.data?.biddata?.getvehicle;
    List<String> images = [];
    if (vehicle?.vehicleFrontPic != null && vehicle!.vehicleFrontPic!.isNotEmpty) {
      images.add(vehicle.vehicleFrontPic!);
    }
    if (vehicle?.vehicleBackPic != null && vehicle!.vehicleBackPic!.isNotEmpty) {
      images.add(vehicle.vehicleBackPic!);
    }
    // Add more images if available from your model
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        // backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Car Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (_carDetailsController.isLoading.value) {
            return SizedBox(
              height: Get.height * 0.7,
              child: Center(child: loader()),
            );
          } else {
            final data = _carDetailsController.carDetailsModel.value.data;
            final biddata = data?.biddata;
            final vehicle = biddata?.getvehicle;
            final brand = biddata?.getBrand;
            final car = biddata?.getCar;
            final partner = biddata?.getpartner;
            final images = _getCarImages();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Main Image Container
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: images.isNotEmpty
                            ? DecorationImage(
                          image: NetworkImage(Urls.getImageURL(endPoint: images[_currentImageIndex])),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: images.isEmpty
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_car, size: 80, color: Colors.grey[600]),
                            SizedBox(height: 10),
                            Text(
                              'No Image Available',
                              style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            ),
                          ],
                        ),
                      )
                          : null,
                    ),

                    // Gradient overlay
                    if (images.isNotEmpty)
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(70),
                              Colors.black.withAlpha(100),
                            ],
                          ),
                        ),
                      ),

                    // Navigation arrows (only if multiple images)
                    if (images.length > 1) ...[
                      // Left arrow
                      Positioned(
                        left: 10,
                        top: 135,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentImageIndex = _currentImageIndex == 0
                                  ? images.length - 1
                                  : _currentImageIndex - 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(80),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.chevron_left, color: Colors.white, size: 30),
                          ),
                        ),
                      ),

                      // Right arrow
                      Positioned(
                        right: 10,
                        top: 135,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentImageIndex = _currentImageIndex == images.length - 1
                                  ? 0
                                  : _currentImageIndex + 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(80),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.chevron_right, color: Colors.white, size: 30),
                          ),
                        ),
                      ),

                      // Image counter
                      Positioned(
                        bottom: 15,
                        right: 15,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(90),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${_currentImageIndex + 1}/${images.length}',
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),

                      // Dot indicators
                      Positioned(
                        bottom: 15,
                        left: 15,
                        child: Row(
                          children: List.generate(images.length, (index) {
                            return Container(
                              width: 8,
                              height: 8,
                              margin: EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == index ? primaryColor : Colors.white.withAlpha(90),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],

                    // Car title overlay
                    Positioned(
                      bottom: 20,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _carDetailsController.carDetailsModel.value.data?.biddata?.getBrand?.name?.toUpperCase() ?? 'PREMIUM CAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              shadows: [Shadow(color: Colors.black.withAlpha(70), blurRadius: 4)],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            _carDetailsController.carDetailsModel.value.data?.biddata?.getCar?.model ?? 'Luxury Sedan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(color: Colors.black.withAlpha(80), blurRadius: 6)],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                  ],
                ),

                // Quick Stats Bar
                Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(50),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(Icons.calendar_month_rounded, 'Model Year', car?.modelYear ?? '2024'),
                      _buildStatItem(Icons.ac_unit, 'AC', vehicle?.aircondition ?? 'Yes'),
                      _buildStatItem(Icons.local_gas_station, 'Fuel', vehicle?.fuelType ?? 'Petrol'),
                    ],
                  ),
                ),

                // Car Info Card
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(50),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSectionHeader('Vehicle Information', Icons.info_outline),
                      SizedBox(height: 16),
                      _buildInfoRow(Icons.directions_car_filled, 'Brand', brand?.name ?? 'N/A',
                          subtitle: brand?.vehicleCategory ?? ''),
                      _buildDivider(),
                      _buildInfoRow(Icons.model_training, 'Model', car?.model ?? 'N/A',
                          subtitle: 'Model Year: ${car?.modelYear ?? 'N/A'}'),
                      _buildDivider(),
                      _buildInfoRow(Icons.confirmation_number, 'Metro Number', vehicle?.metroNo ?? 'N/A'),
                      _buildDivider(),
                      _buildInfoRow(Icons.location_on, 'Metro', vehicle?.metro ?? 'N/A'),
                      _buildDivider(),
                      _buildInfoRow(Icons.category, 'Metro Type', data?.metrotype?.metroSubName ?? 'N/A'),
                      _buildDivider(),
                      _buildInfoRow(Icons.color_lens, 'Vehicle Color', vehicle?.vehicleColor ?? 'N/A'),
                      _buildDivider(),
                      _buildInfoRow(Icons.ac_unit, 'Air Condition', vehicle?.aircondition ?? 'N/A'),
                      _buildDivider(),
                      _buildInfoRow(Icons.local_gas_station, 'Fuel Type', vehicle?.fuelType ?? 'N/A'),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Partner/Driver Info Card
                if (partner != null)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(50),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('Driver Information', Icons.person_outline),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: partner.image != null
                                  ? NetworkImage(Urls.getImageURL(endPoint: partner.image!))
                                  : null,
                              child: partner.image == null
                                  ? Icon(Icons.person, size: 40, color: Colors.grey[600])
                                  : null,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    partner.name ?? 'N/A',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.transgender, size: 16, color: Colors.grey[600]),
                                      SizedBox(width: 8),
                                      Text(
                                        partner.gender ?? 'N/A',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.verified, size: 16,
                                          color: partner.status == '1' ? Colors.green : Colors.grey),
                                      SizedBox(width: 8),
                                      Text(
                                        partner.status == '1' ? 'Verified' : 'Not Verified',
                                        style: TextStyle(
                                          color: partner.status == '1' ? Colors.green : Colors.grey[600],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 16),

                // Rating Overview
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(50),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildSectionHeader('Ratings & Reviews', Icons.star_outline),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.amber.withAlpha(50),
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  double.parse(data?.averageStar ?? '0').toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber[800],
                                  ),
                                ),
                                Text(
                                  '/5',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildRatingDistribution(5, data?.reviews ?? []),
                                _buildRatingDistribution(4, data?.reviews ?? []),
                                _buildRatingDistribution(3, data?.reviews ?? []),
                                _buildRatingDistribution(2, data?.reviews ?? []),
                                _buildRatingDistribution(1, data?.reviews ?? []),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        '${data?.reviewsCount ?? 0} total reviews',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Customer Reviews List
                if (data?.reviews?.isNotEmpty ?? false)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4, bottom: 12),
                          child: Text(
                            'Recent Reviews',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data!.reviews!.length > 3 ? 3 : data.reviews!.length,
                          itemBuilder: (context, index) {
                            final review = data.reviews![index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 12),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.grey[200],
                                        backgroundImage: review.getCustomer?.image != null
                                            ? NetworkImage(Urls.getImageURL(endPoint: review.getCustomer!.image!))
                                            : null,
                                        child: review.getCustomer?.image == null
                                            ? Icon(Icons.person, color: Colors.grey[600], size: 22)
                                            : null,
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.getCustomer?.name ?? 'Anonymous',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            _buildStarRating(int.parse(review.starReviews ?? '0')),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _getTimeAgo(review.createdAt),
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (review.comment?.isNotEmpty ?? false) ...[
                                    SizedBox(height: 12),
                                    Text(
                                      review.comment!,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          },
                        ),
                        if (data.reviews!.length > 3)
                          Center(
                            child: TextButton(
                              onPressed: () {
                                // Navigate to all reviews page
                              },
                              child: Text(
                                'See All ${data.reviews!.length} Reviews',
                                style: TextStyle(
                                  color: Colors.amber[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                SizedBox(height: 30),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 22, color: primaryColor),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 22, color: primaryColor),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {String? subtitle}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingDistribution(int stars, List<details.Review> reviews) {
    int count = reviews.where((r) => int.parse(r.starReviews ?? '0') == stars).length;
    double percentage = reviews.isEmpty ? 0 : (count / reviews.length) * 100;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$stars ★',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                minHeight: 6,
              ),
            ),
          ),
          SizedBox(width: 30),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[200], height: 1);
  }

  String _getTimeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

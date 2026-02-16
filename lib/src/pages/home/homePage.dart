import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/controllers/vehicles%20categoris/quick_tech_vehicles_controller.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalListPage.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalPointPage.dart';
import 'package:pickup_load_update/src/pages/home/return%20trip/return_trip_list_filter.dart';
import 'package:pickup_load_update/src/pages/home/truck/select_location.dart';
import 'package:pickup_load_update/src/widgets/search_widget/search_widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../configs/app_list.dart';
import '../../controllers/rental trip request controllers/rental_trip_req_submit_controller.dart';
import '../../controllers/return trip controller/return_filter_controller.dart';
import '../../controllers/truck/truck_controller.dart';
import '../../widgets/custom app bar/app_bar_widget.dart';
import '../../widgets/search_widget/service_card.dart';
import '../../widgets/slider/slider_widget.dart';
import '../../widgets/text/kText.dart';
import '../live bidding/live_bidding_page.dart';
import '../live bidding/live_biding_page_truck.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Controllers and dependencies...
  final vehicleController = Get.put(QuickTechVehiclesController());
  final ReturnTripFilter returnTripFilter = Get.put(ReturnTripFilter());
  final TruckController truckController = Get.put(TruckController());
  var box = GetStorage();
  final RentalTripSubmitController _rentalTripSubmitController = Get.put(
    RentalTripSubmitController(),
  );

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFF),

      appBar: CustomCommonAppBar(title: 'homeTitle', scaffoldKey: scaffoldKey),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: RefreshIndicator(
          onRefresh: () async {
            // Add refresh logic
            await Future.delayed(Duration(seconds: 1));
          },
          color: Color(0xFF3B82F6),
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                // User Info & Location
                // SliverToBoxAdapter(child: _buildUserInfoSection()),

                // Active Trip Banner
                SliverToBoxAdapter(child: _buildActiveTripBanner()),

                _buildSearchBar(),

                // Quick Services
                SliverToBoxAdapter(child: _buildQuickServicesSection()),
                // Hero Slider Section
                SliverToBoxAdapter(child: _buildHeroSlider()),
                // Featured Services
                SliverToBoxAdapter(child: _buildFeaturedServicesSection()),

                // Promotions Section
                SliverToBoxAdapter(child: _buildPromotionsSection()),

                // Bottom Spacing
                SliverToBoxAdapter(child: SizedBox(height: 50.h)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.05),
            //     blurRadius: 10,
            //     offset: const Offset(0, 4),
            //   ),
            // ],
          ),
          child: TextField(
            readOnly: true,
            // Set to true if navigating to a dedicated search page
            onTap: () {
              Get.to(() => SearchWidgets(tripType: 'car',));
            },
            decoration: InputDecoration(
              hintText: 'Search Whare To Go...?',
              hintStyle: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14.sp,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Color(0xFF3B82F6), // Matches your primary color
                size: 22.w,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15.h),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSlider() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            SliderWidget(),
            // sizeH10,
            // KText(
            //   text: "Welcome back! 👋",
            //   fontSize: 14.sp,
            //   maxLines: 2,
            //   textAlign: TextAlign.center,
            //   fontWeight: FontWeight.bold,
            //   color: primaryColor.withAlpha(150),
            // ),
          ],
        ),
      ],
    );
  }

  Widget _buildActiveTripBanner() {
    return Obx(() {
      if (_rentalTripSubmitController.liveBidStart.value ||
          _rentalTripSubmitController.liveBidTruckStart.value) {
        log(_rentalTripSubmitController.liveBidTruckStart.value.toString());
        log(_rentalTripSubmitController.liveBidStart.value.toString());
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              if (_rentalTripSubmitController.liveBidTruckStart.value)
                _buildTripBanner(
                  title: "Truck Trip in Progress",
                  subtitle: "Tap to view details & track",
                  icon: Icons.local_shipping,
                  iconColor: Color(0xFF3B82F6),
                  gradient: [Color(0xFFE0F2FE), Color(0xFFBAE6FD)],
                  onTap: () {
                    Get.to(
                      () => LiveBiddingPageTruck(
                        createdAt: DateTime.now().toLocal().toString(),
                        id: box.read("BUIDID").toString(),
                      ),
                    );
                  },
                ),
              if (_rentalTripSubmitController.liveBidTruckStart.value &&
                  _rentalTripSubmitController.liveBidStart.value)
                SizedBox(height: 12.h),
              if (_rentalTripSubmitController.liveBidStart.value)
                _buildTripBanner(
                  title: "Car Trip in Progress",
                  subtitle: "Tap to view details & track",
                  icon: Icons.directions_car,
                  iconColor: Color(0xFF10B981),
                  gradient: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
                  onTap: () {
                    Get.to(
                      () => LiveBiddingPage(
                        createdAt: DateTime.now().toString(),
                        type: box.read("type"),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      }
      return SizedBox.shrink();
    });
  }

  Widget _buildTripBanner({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withAlpha(40),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      KText(
                        text: "LIVE",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  KText(
                    text: title,
                    color: Color(0xFF111827),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 2),
                  KText(
                    text: subtitle,
                    color: Color(0xFF6B7280),
                    fontSize: 12.sp,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_forward_ios, color: iconColor, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: "Quick Services",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF111827),
                ),
                SizedBox(height: 2.h),
                KText(
                  text: "Everything you need to move",
                  fontSize: 12.sp,
                  color: Color(0xFF6B7280),
                ),
              ],
            ),
            // Optional "See All" or Status indicator
            Icon(Icons.auto_awesome, color: Colors.amber, size: 20),
          ],
        ),
        SizedBox(height: 20.h),
        _buildServicesSection(context),
        // GridView.builder(
        //   physics: const NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   itemCount: quickServices.length,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 3,
        //     mainAxisSpacing: 10,
        //     crossAxisSpacing: 10,
        //     childAspectRatio: 0.85, // Made taller to fit text comfortably
        //   ),
        //   itemBuilder: (context, index) {
        //     return _buildQuickServiceCard(quickServices[index], index);
        //   },
        // ),
      ],
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    // 1. Group items into the 2-3-2 pattern
    List<List<ServiceItem>> chunkedRows = [];
    int i = 0;
    bool isTwo = true;
    while (i < quickServices.length) {
      int size = isTwo ? 2 : 3;
      chunkedRows.add(
        quickServices.sublist(
          i,
          (i + size > quickServices.length) ? quickServices.length : i + size,
        ),
      );
      i += size;
      isTwo = !isTwo;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Get actual available width minus section padding
        double availableWidth =
            constraints.maxWidth - 32; // 16 horizontal padding on each side
        double spacing = 10.0; // The gap between cards

        return Column(
          children: chunkedRows.map((row) {
            // 2. Calculate exact item width based on row count
            int itemCount = row.length;
            // Formula: (Total Width - Total Gaps) / Number of items
            double itemWidth =
                (availableWidth - (spacing * (itemCount - 4))) / itemCount;

            return Padding(
              padding: EdgeInsets.only(bottom: spacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row.map((service) {
                  return SizedBox(
                    width: itemWidth,
                    child: buildQuickServiceCard(context, service, itemWidth),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildFeaturedServicesSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Featured Services",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
              SizedBox(height: 4.h),
              KText(
                text: "Premium transportation solutions",
                fontSize: 12.sp,
                color: Color(0xFF6B7280),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 280.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: featuredServices.length,
              itemBuilder: (context, index) {
                return _buildFeaturedCard(featuredServices[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(FeatureCard feature) {
    return GestureDetector(
      onTap: () async {
        if (feature.type == 'returnTruck') {
          Get.to(() => ReturnTripListFilterPage());
        } else if (feature.type == 'truckRental') {
          Get.to(() => SelectLocation());
          await returnTripFilter.returnTripFilterList();
        } else if (feature.type == 'airport') {
          await vehicleController.getVehicles(id: '2');

          Get.to(() => SearchWidgets(tripType: 'car'));
        }else{
          Get.to(() => SearchWidgets(tripType: 'car'));
        }
      },
      child: Container(
        width: 260.w,
        margin: EdgeInsets.only(right: 20.w),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 25,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Image with Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(feature.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating Badge
                    // Container(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 10,
                    //     vertical: 4,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Icon(Icons.star, size: 12, color: Colors.amber),
                    //       SizedBox(width: 4),
                    //       KText(
                    //         text: feature.rating.toString(),
                    //         fontSize: 12.sp,
                    //         fontWeight: FontWeight.bold,
                    //         color: Color(0xFF111827),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //
                    // SizedBox(height: 12),

                    // Service Icon
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: feature.color.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: feature.color.withOpacity(0.4),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(feature.icon, color: Colors.white, size: 28),
                    ),

                    SizedBox(height: 16),

                    // Service Info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: feature.tagline,
                          fontSize: 12.sp,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        SizedBox(height: 2),
                        KText(
                          text: feature.name,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Book Now Button
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            KText(
                              text: "Book Now",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: feature.color,
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: feature.color,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionsSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8B5CF6).withOpacity(0.4),
            blurRadius: 25,
            offset: Offset(2, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: KText(
                    text: "SPECIAL OFFER",
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                KText(
                  text: "Get 30% off\non your first trip!",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                KText(
                  text: "Use code: FIRST30",
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.9),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: KText(
                    text: "Claim Offer",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B5CF6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.confirmation_number,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

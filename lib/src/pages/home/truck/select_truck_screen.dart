import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/language/langController.dart';
import 'package:pickup_load_update/src/pages/home/truck/shipping_details.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../configs/appBaseUrls.dart';
import '../../../controllers/truck/truck_controller.dart';
import '../../../models/truck_related_model/truck_category_model.dart';
import '../../../widgets/date and time widget/date_time_widget.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SelectTruckScreen extends StatefulWidget {
  const SelectTruckScreen({super.key});

  @override
  State<SelectTruckScreen> createState() => _SelectTruckScreenState();
}

class _SelectTruckScreenState extends State<SelectTruckScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late PageController _pageController;
  final LangController langController = Get.find();
  int? selectedIndexOpen = -1;
  int? selectedIndexCover = -1;
  String? selectedValue1;
  String? selectedValue2;
  var id;
  final TruckController truckController = Get.find();

  @override
  void initState() {
    super.initState();

    // Initialize TabController with the number of sizecategories
    _tabController = TabController(length: truckController.sizeCategory.length, vsync: this);

    // Initialize PageController to detect swipe
    _pageController = PageController();

    // Listen for changes in the TabController (when a tab is tapped)
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          // Sync PageView with TabController when a tab is tapped
          _pageController.jumpToPage(_tabController.index);

          // Reset values when the tab changes
          selectedIndexOpen = -1;
          selectedIndexCover = -1;
        });
      }
    });

    // Sync the PageView with TabController when swiping
    _pageController.addListener(() {
      if (_pageController.page?.round() != _tabController.index) {
        _tabController.animateTo(_pageController.page!.round());
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();  // Dispose PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'selectTruck'.tr.text.white.make(),
        backgroundColor:primaryColor,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: truckController.sizeCategory.length > 3,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          tabs: List.generate(
              truckController.sizeCategory.length,
                  (index) => Obx(
                    () => Tab(
                  text: langController.selectedLang.value.toString() == 'en_US'
                      ? truckController.sizeCategory[index].name
                      : truckController.sizeCategory[index]
                      .nameBn,
                ),
              )),
        ),
      ),
      body: Container(
        color: Colors.grey[50],
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            // When the page is swiped, update the TabController to match
            if (_tabController.index != index) {
              _tabController.animateTo(index);
            }
          },
          children: List.generate(
            truckController.sizeCategory.length,
                (index) {
              return Container(
                color: Colors.grey[50],
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        buildTabContent(truckController.sizeCategory[index], index),
                      ],
                    ),
                    selectedIndexOpen != -1 || selectedIndexCover != -1
                        ? Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              minimumSize: const Size(double.infinity, 56),
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                            ),
                            onPressed: () async {
                              truckController.getService(truckController.id);

                              Get.bottomSheet(

                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                isScrollControlled: true,
                                StatefulBuilder(builder:
                                      (BuildContext context, StateSetter setState) {
                                    return SizedBox(
                                      height: 450.h,
                                      child: ListView(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Pick up time",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.grey[800],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () => Get.back(),
                                                    icon: const Icon(Icons.close, size: 20),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              Text(
                                                "Select pickup date and time for your shipment",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              const SizedBox(height: 24),
                                              Center(
                                                child: Container(
                                                  width: Get.width * 0.9,
                                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[50],
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(color: Colors.grey.shade300),
                                                  ),
                                                  child: DateAndTime(
                                                    onDateTimeSelected:
                                                        (date, time) {
                                                      truckController.selectedDate = date;
                                                      truckController.selectedTime = time;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 24),
                                              SizedBox(
                                                width: Get.width-50,
                                                height: 50,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    truckController.totalPriceNew='';
                                                    truckController.calculateRangeAmount();
                                                    log(truckController.distances.value);
                                                    log(truckController.amounts.toString());
                                                    if (truckController.price.value != 'Bid') {
                                                      truckController.totalPrice = (int.parse(truckController.amounts.toString()) * int.parse(truckController.distances.value.toString())).toString();
                                                      truckController.totalPrice = (int.parse(truckController.totalPrice) + int.parse(truckController.price.value)).toString();
                                                    } else {
                                                      truckController.totalPrice = 'Bid';
                                                    }

                                                    Get.to(() => ShippingDetails(), transition: Transition.fadeIn, duration: const Duration(seconds: 1));
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: primaryColor,
                                                    foregroundColor: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Go Next",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  })

                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Go Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Build the content for each tab
  Widget buildTabContent(Sizecategories sizecategory, int tabIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available Trucks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Select a truck type for your shipment",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),

        // Vehicles List
        ListView.builder(
          itemCount: sizecategory.vehicles?.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final vehicle = sizecategory.vehicles?[index];
            final isSelected = selectedIndexCover == index;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: isSelected
                    ? Border.all(
                  color: primaryColor,
                  width: 2,
                )
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    log('${vehicle?.id}');
                    await truckController.getAmount(vehicle?.id);
                    await truckController.getRange(vehicle?.id);
                    setState(() {
                      log("${vehicle?.id}", name: "vehicle id");
                      log("${vehicle?.sizecategoryId}", name: "Size Category id");

                      selectedIndexCover = (selectedIndexCover == index) ? -1 : index;
                      selectedIndexOpen = -1;
                      truckController.truck_type = "${vehicle?.truckType}";
                      truckController.sizeId = "${vehicle?.sizecategoryId}";
                      truckController.id = "${vehicle?.id}";
                      truckController.name = "${vehicle?.name}";
                      truckController.image = "${vehicle?.image}";
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image Container
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                Urls.getImageURL(endPoint: "${vehicle?.image}"),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Details Section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Vehicle Name
                              Obx(
                                    () => Text(
                                  langController.selectedLang.value.toString() == 'en_US'
                                      ? "${vehicle?.name}"
                                      : "${vehicle?.nameBn}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Description
                              Text(
                                "${vehicle?.description}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),

                              // Bid Tag
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.orange[200]!),
                                ),
                                child: Text(
                                  'Bid',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Selection Indicator
                        if (isSelected)
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        // Bottom Spacing
        const SizedBox(height: 100),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../configs/appColors.dart';
import '../../../controllers/division controller/division_controller.dart';
import '../../../controllers/live location controller/live_location_controller.dart';
import '../../../controllers/rental trip request controllers/rental_trip_req_submit_controller.dart';
import '../../../controllers/rental trip request controllers/rental_trip_request_check_controller.dart';
import '../../../controllers/vehicles categoris/quick_tech_vehicles_controller.dart';
import '../../../models/vehicle_categories/quick_tech_get_vehicle_categories.dart';
import '../../../widgets/button/primaryButton.dart';
import '../../../widgets/car selected option/car_selected_option_widget.dart';
import '../../../widgets/date and time widget/date_time_widget.dart';
import '../../../widgets/note_controller.dart';
import '../../../widgets/yes_no_ambulance_button.dart';
import '../rental/tripDetailsPage.dart';

class AmbulancePage extends StatefulWidget {
  final String carImg;
  final String carName;
  final String capacity;
  final String carId;
  final List<VehicleQuestion> question;

  final String tripType;

  const AmbulancePage({
    super.key,
    required this.carImg,
    required this.carName,
    required this.capacity,
    required this.carId,

    required this.tripType,
    required this.question,
  });

  @override
  State<AmbulancePage> createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  final noteController = TextEditingController();

  // final LocationPickerController locationMapController = Get.put(
  //   LocationPickerController(),
  // );
  final RentalTripSubmitController controller = Get.find();
  final DivisionController divisionController = Get.put(DivisionController());


  var isRoundTrip = false;
  int roundTripValue = 0;
  bool showViaLocation = false;
  var pickupLocation;
  var pickLat;
  var pickLng;
  var dropLat;
  var dropLng;
  var dropOffLocation;

  /// for time and date
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedReturnDate = DateTime.now();
  TimeOfDay selectedReturnTime = TimeOfDay.now();
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "requestTrip".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// Ambulance specific questions
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: const Icon(
                          Icons.medical_services,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'medicalRequirement'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(widget.question.length, (index) {
                      final q = widget.question[index];

                      return Obx(() {
                        /// get selected answer
                        final selected = controller.selectedAnswers[q.id];

                        /// map string → bool
                        bool? value;
                        if (selected == q.options[0]) {
                          value = true;
                        } else if (q.options.length > 1 &&
                            selected == q.options[1]) {
                          value = false;
                        }

                        return YesNoRadioRow(
                          title: q.question ?? "",
                          option1: q.options.isNotEmpty ? q.options[0] : "Yes",
                          option2: q.options.length > 1 ? q.options[1] : "No",
                          value: value,

                          onChanged: (val) {
                            if (q.id == null) return;

                            /// map bool → string
                            final answer = val == true
                                ? q.options[0]
                                : (q.options.length > 1 ? q.options[1] : "");

                            controller.setAnswer(q.id!, answer);
                          },
                        );
                      });
                    }),
                  ),
                  // YesNoRadioRow(
                  //   title:
                  //   "পিকআপ লোকেশন কি হাসপাতাল/ডায়াগনস্টিক সেন্টার/ক্লিনিক?",
                  //   value: true,
                  //   onChanged: (val) {
                  //     setState(() {});
                  //   },
                  // ),
                  //
                  // YesNoRadioRow(
                  //   title: "যানবাহনের ধরন?",
                  //   option1: "রোগী",
                  //   option2: "লাশ",
                  //   value: true,
                  //   onChanged: (val) {
                  //     setState(() {});
                  //   },
                  // ),
                  //
                  // YesNoRadioRow(
                  //   title:
                  //   "কতটি অক্সিজেন সিলিন্ডার প্রয়োজন হবে? (১টি সিলিন্ডার সবসময় থাকে)",
                  //   option1: "২",
                  //   value: true,
                  //   onChanged: (val) {
                  //     setState(() {});
                  //   },
                  // ),
                  //
                  // YesNoRadioRow(
                  //   title:
                  //   "মৃতদেহ অপসারণের জন্য অতিরিক্ত ফি প্রযোজ্য (বিড মূল্যের অন্তর্ভুক্ত নয়)",
                  //   value: true,
                  //   onChanged: (val) {
                  //     setState(() {});
                  //   },
                  // ),
                  //
                  // YesNoRadioRow(
                  //   title:
                  //   "রোগীর ওঠানামার জন্য কি হুইলচেয়ার প্রয়োজন? (সবসময় ৪ জন সহকারী থাকে)",
                  //   value: true,
                  //   onChanged: (val) {
                  //     setState(() {});
                  //   },
                  // ),
                  //
                  // YesNoRadioRow(
                  //   title: "আইসিইউ বা অ্যাম্বুলেন্সে কি ডাক্তার প্রয়োজন?",
                  //   value: true,
                  //   shodDivider: false,
                  //   onChanged: (val) {
                  //     setState(() {});
                  //   },
                  // ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Date & Time section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: DateAndTime(
                onDateTimeSelected: (date, time) {
                  selectedDate = date;
                  selectedTime = time;
                },
              ),
            ),

            const SizedBox(height: 16),

            /// Additional Notes
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'additionalNotes'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  NoteTextFiled(controller: noteController),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Submit Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: primaryButton(
                buttonName: 'submitTripRequest',
                radius: 16.0,
                onTap: _submitTripRequest,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Submit trip request method
  void _submitTripRequest() {
    String hour = selectedTime.hourOfPeriod == 0
        ? '12'
        : '${selectedTime.hourOfPeriod}';
    String minute = '${selectedTime.minute}'.padLeft(2, '0');
    String period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';

    String journeyTimeAndDate =
        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')} ${hour}:${minute} $period';

    if (locationController.pickUpLocation.isEmpty ||
        locationController.dropLocation.isEmpty) {
      Get.snackbar(
        'Missing Information',
        "Pick & Drop locations are required",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    RentalFormCheckController().rentalForm(
      pickUpLocation: locationController.pickUpLocation.toString(),
      viaLocation: locationController.viaLocation.toString(),
      dropLocation: locationController.dropLocation.toString(),
      dateTime: journeyTimeAndDate,
      map:
          '${locationController.selectedPickUpLat.value},${locationController.selectedPickUpLng.value}',
      roundTrip: roundTripValue.toString(),
      roundTripTimeDate: '',
      vehicleId: widget.carId,
      dropMap:
          '${locationController.selectedDropUpLat.value},${locationController.selectedDropUpLng.value}',
    );

    Get.to(
      () => TripDetailsPage(
        carImg: widget.carImg,
        carName: widget.carName,
        capacity: widget.capacity,
        carId: widget.carId,
        pickUpPoint: locationController.pickUpLocation.toString(),
        dropPoint: locationController.dropLocation.toString(),
        viaPoint: locationController.viaLocation.toString(),
        note: noteController.text,
        tripDetailsJourney: journeyTimeAndDate,
        roundTrip: roundTripValue.toString(),
        map:
            '${locationController.selectedPickUpLat.value} ${locationController.selectedPickUpLng.value}',
        roundTripDetailsJourney: '',
        pickupDivision: locationController.pickupDivision.value,
        isAmbulance: true,
        dropOffMap:
            '${locationController.selectedDropUpLat.value},${locationController.selectedDropUpLng.value}',
        categoryID: widget.tripType,
        question: widget.question,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';

import '../../controllers/vehicles categoris/quick_tech_vehicles_controller.dart';

class DateAndTime extends StatefulWidget {
  final Function(DateTime, TimeOfDay) onDateTimeSelected;
  final bool enableTimeConstraint;

  const DateAndTime({
    super.key,
    required this.onDateTimeSelected,
    this.enableTimeConstraint = true,
  });

  @override
  State<DateAndTime> createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  final vehicleController = Get.put(QuickTechVehiclesController());
  final dateFormat = DateFormat('d MMMM yyyy');
  final timeFormat = DateFormat('h:mm a');
  DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime;
  bool isToday = true;
  DateTime now = DateTime.now();

  // Helper function to get initial time (now + blockTime)
  TimeOfDay _getInitialTime() {
    final DateTime now = DateTime.now();
    final DateTime threeHoursLater = now.add(
      Duration(
        minutes: int.parse(
          vehicleController.selectedItem.value?.blockTime ?? '60',
        ),
      ),
    );

    return TimeOfDay(
      hour: threeHoursLater.hour,
      minute: threeHoursLater.minute,
    );
  }

  // Get minimum allowed time based on current time + blockTime
  TimeOfDay _getMinimumAllowedTime(DateTime date) {
    final now = DateTime.now();

    // If selected date is today, return now + blockTime
    if (_isSameDay(date, now)) {
      final minimumDateTime = now.add(
        Duration(
          minutes: int.parse(
            vehicleController.selectedItem.value?.blockTime ?? '60',
          ),
        ),
      );
      return TimeOfDay(
        hour: minimumDateTime.hour,
        minute: minimumDateTime.minute,
      );
    }

    // For future dates, no time restriction
    return const TimeOfDay(hour: 0, minute: 0);
  }

  // Check if time is valid (not before minimum allowed time)
  bool _isTimeValid(DateTime date, TimeOfDay time) {
    final now = DateTime.now();

    // Only validate if it's today and timeConstraint is enabled
    if (!_isSameDay(date, now) || !widget.enableTimeConstraint) {
      return true;
    }

    final minimumTime = _getMinimumAllowedTime(date);

    // Compare times
    if (time.hour < minimumTime.hour) {
      return false;
    } else if (time.hour == minimumTime.hour && time.minute < minimumTime.minute) {
      return false;
    }

    return true;
  }

  // Helper to check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void initState() {
    super.initState();
    selectedTime = _getInitialTime();

    // Notify parent widget about the initial time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDateTimeSelected(selectedDate, selectedTime);
    });
    _checkIfToday();
  }

  void _checkIfToday() {
    isToday = _isSameDay(selectedDate, now);

    // If it's today and time is in the past, adjust it
    if (isToday && widget.enableTimeConstraint) {
      final DateTime currentDateTime = DateTime.now();
      final DateTime selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (selectedDateTime.isBefore(currentDateTime)) {
        // Add blockTime to current time
        final DateTime threeHoursLater = currentDateTime.add(
          Duration(
            minutes: int.parse(
              vehicleController.selectedItem.value?.blockTime ?? '60',
            ),
          ),
        );
        setState(() {
          selectedTime = TimeOfDay(
            hour: threeHoursLater.hour,
            minute: threeHoursLater.minute,
          );
        });
        widget.onDateTimeSelected(selectedDate, selectedTime);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      helpText: 'selectJourneyTime'.tr,
      cancelText: 'cancel'.tr,
      confirmText: 'submit'.tr,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(
          days: int.parse(
            vehicleController.selectedItem.value?.scheduleDay ?? '7',
          ) - 1,
        ),
      ),
      selectableDayPredicate: (DateTime date) {
        return date.isAfter(DateTime.now().subtract(const Duration(days: 1)));
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _checkIfToday();

        // If selected date is today, ensure time is in the future
        if (isToday && widget.enableTimeConstraint) {
          final minimumTime = _getMinimumAllowedTime(selectedDate);
          if (!_isTimeValid(selectedDate, selectedTime)) {
            selectedTime = minimumTime;
          }
        }
      });

      widget.onDateTimeSelected(selectedDate, selectedTime);
      await _selectTime();
    }
  }

  Future<void> _selectTime() async {
    final minimumTime = _getMinimumAllowedTime(selectedDate);

    TimeOfDay initialTime = selectedTime;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      useRootNavigator: true,
      helpText: "Select Time",
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteTextColor: primaryColor,
              hourMinuteColor: primaryColor.withAlpha(30),
              dialHandColor: primaryColor,
              dialBackgroundColor: primaryColor.withAlpha(10),
              entryModeIconColor: primaryColor,
              dayPeriodColor: primaryColor.withAlpha(100),
            ),
            colorScheme: ColorScheme.light(primary: primaryColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Validate the selected time
      if (!_isTimeValid(selectedDate, picked)) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Cannot select time before ${minimumTime.format(context)}',
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }

      setState(() {
        selectedTime = picked;
      });

      widget.onDateTimeSelected(selectedDate, selectedTime);
    }
  }

  String _getFormattedTime() {
    if (selectedTime == TimeOfDay.now()) {
      return 'selectTime'.tr;
    }

    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    return timeFormat.format(dateTime);
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    if (_isSameDay(selectedDate, now)) {
      return 'today'.tr;
    }

    final tomorrow = now.add(const Duration(days: 1));
    if (_isSameDay(selectedDate, tomorrow)) {
      return 'tomorrow'.tr;
    }

    return dateFormat.format(selectedDate);
  }

  // Get helper text for minimum time
  String _getMinimumTimeText() {
    if (!isToday || !widget.enableTimeConstraint) {
      return '';
    }

    final minimumTime = _getMinimumAllowedTime(selectedDate);
    final blockTime = int.parse(
      vehicleController.selectedItem.value?.blockTime ?? '60',
    );

    return '${'fromNowTo'.tr} ${blockTime}M';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, size: 20, color: primaryColor),
            const SizedBox(width: 8),
            Text(
              'journeyTime'.tr,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Date Selection Card
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'date'.tr.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getFormattedDate(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Time Selection Card
        GestureDetector(
          onTap: _selectTime,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.schedule, size: 20, color: primaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'time'.tr.toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _getFormattedTime(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (_getMinimumTimeText().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            _getMinimumTimeText(),
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.orange.shade700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),

        // Selected DateTime Summary
        if (selectedTime != TimeOfDay.now())
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${'selectedTime'.tr}: ${dateFormat.format(selectedDate)} at ${_getFormattedTime()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

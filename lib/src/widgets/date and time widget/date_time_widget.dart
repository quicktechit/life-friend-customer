import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

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
  final dateFormat = DateFormat('d MMMM yyyy');
  final timeFormat = DateFormat('h:mm a');
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = _getInitialTime(); // Use helper function
  bool isToday = true;
  DateTime now = DateTime.now();

  // Helper function to get initial time (now + 3 hours)
  static TimeOfDay _getInitialTime() {
    final DateTime now = DateTime.now();
    final DateTime threeHoursLater = now.add(const Duration(hours: 3));

    return TimeOfDay(
      hour: threeHoursLater.hour,
      minute: threeHoursLater.minute,
    );
  }

  @override
  void initState() {
    super.initState();
    _checkIfToday();

    // Notify parent widget about the initial time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onDateTimeSelected(selectedDate, selectedTime);
    });
  }

  void _checkIfToday() {
    isToday = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

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
        // Add 3 hours to current time
        final DateTime threeHoursLater = currentDateTime.add(const Duration(hours: 3));
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
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {
        // Allow all future dates
        return date.isAfter(DateTime.now().subtract(const Duration(days: 1)));
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _checkIfToday();

        // If selected date is today, ensure time is in the future
        if (isToday && widget.enableTimeConstraint) {
          final nowTime = TimeOfDay.now();
          if (selectedTime.hour < nowTime.hour ||
              (selectedTime.hour == nowTime.hour && selectedTime.minute <= nowTime.minute)) {
            // Set to current time + 15 minutes
            selectedTime = TimeOfDay(
              hour: nowTime.hour + (nowTime.minute + 15) ~/ 60,
              minute: (nowTime.minute + 15) % 60,
            );
          }
        }
      });

      widget.onDateTimeSelected(selectedDate, selectedTime);
      // Only show time picker if time is not already set
      if (selectedTime == TimeOfDay.now()) {
        await _selectTime();
      }
    }
  }

  Future<void> _selectTime() async {
    final DateTime now = DateTime.now();
    DateTime initialDateTime;

    if (isToday && widget.enableTimeConstraint) {
      // Set initial time to 3 hours from now
      initialDateTime = now.add(const Duration(hours: 3));
    } else {
      // Use currently selected time
      initialDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 320,
          child: Column(
            children: [
              // ... (same header code as above)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'selectTime'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'cancel'.tr,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onDateTimeSelected(selectedDate, selectedTime);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('submit'.tr,style:  TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: initialDateTime,
                    // Remove minuteInterval to avoid the divisible by 5 issue
                    // minuteInterval: 5,
                    use24hFormat: false,
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        selectedTime = TimeOfDay(
                          hour: newDateTime.hour,
                          minute: newDateTime.minute,
                        );
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
    if (selectedDate.isAtSameMomentAs(DateTime.now())) {
      return 'today'.tr;
    }

    final tomorrow = DateTime.now().add(const Duration(days: 1));
    if (selectedDate.year == tomorrow.year &&
        selectedDate.month == tomorrow.month &&
        selectedDate.day == tomorrow.day) {
      return 'tomorrow'.tr;
    }

    return dateFormat.format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: 20,
              color: primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              'journeyTime'.tr,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
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
                  child: Icon(
                    Icons.schedule,
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
                      if (isToday && widget.enableTimeConstraint)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${'fromNowTo'.tr} 3h',
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
                border: Border.all(
                  color: primaryColor.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: primaryColor,
                  ),
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

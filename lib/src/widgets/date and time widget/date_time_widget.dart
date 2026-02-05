import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class DateAndTime extends StatefulWidget {
  final Function(DateTime, TimeOfDay) onDateTimeSelected;

  DateAndTime({Key? key, required this.onDateTimeSelected}) : super(key: key);

  @override
  State<DateAndTime> createState() => DateAndTimeState();
}

class DateAndTimeState extends State<DateAndTime> {
  var dateTime = DateFormat('d MMMM yyyy');
  var selectedDate = DateTime.now();
  var selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      helpText: 'selectJourneyTime'.tr,
      cancelText: 'cancel'.tr,
      confirmText: 'submit'.tr,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2101),
    );
    setState(() {
      selectedDate = picked ?? selectedDate;
      widget.onDateTimeSelected(selectedDate, selectedTime);
      _selectTime();
    });
  }

  void _selectTime() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onDateTimeSelected(selectedDate, selectedTime);
                    },
                    child: Text('submit'.tr),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  ),
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
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KText(
          text: 'journeyTime',
          fontSize: 12,
        ),
        sizeH5,
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: black45,
                  ),
                  SizedBox(width: 10),
                  KText(
                    text: selectedDate.isNull
                        ? 'selectDate'
                        : dateTime.format(selectedDate).toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),

                ],
              ),
            ),
            GestureDetector(
              onTap: () => _selectTime(),
              child: Row(
                children: [
                  Icon(
                    Ionicons.time_outline,
                    color: black45,
                  ),
                  SizedBox(width: 5),
                  KText(
                    text: selectedTime.isNull
                        ? 'selectTime'
                        : '${selectedTime.hourOfPeriod == 0 ? 12 : selectedTime.hourOfPeriod}:${selectedTime.minute.toString().padLeft(2, '0')} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

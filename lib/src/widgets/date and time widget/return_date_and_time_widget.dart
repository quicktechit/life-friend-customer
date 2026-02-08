import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class ReturnDateAndTime extends StatefulWidget {
  final Function(DateTime, TimeOfDay) onReturnDateTimeSelected;

  const ReturnDateAndTime({super.key, required this.onReturnDateTimeSelected});

  @override
  State<ReturnDateAndTime> createState() => _ReturnDateAndTimeState();
}

class _ReturnDateAndTimeState extends State<ReturnDateAndTime> {
  var dateTime = DateFormat('d MMMM yyyy');
  var selectedRoundDate = DateTime.now();
  var selectedRoundTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        helpText: 'selectJourneyTime'.tr,
        cancelText: 'cancel'.tr,
        confirmText: 'submit'.tr,
        context: context,
        initialDate: selectedRoundDate,
        firstDate: DateTime(2022),
        lastDate: DateTime(2101));
    setState(() {
      selectedRoundDate = picked ?? selectedRoundDate;
      widget.onReturnDateTimeSelected(selectedRoundDate, selectedRoundTime);
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
              // A "Done" button to confirm the time selection
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onReturnDateTimeSelected(selectedRoundDate, selectedRoundTime);
                    },
                    child: Text('submit'.tr),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    selectedRoundDate.year,
                    selectedRoundDate.month,
                    selectedRoundDate.day,
                    selectedRoundTime.hour,
                    selectedRoundTime.minute,
                  ),
                  use24hFormat: false, // Set to false to show AM/PM
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() {
                      selectedRoundTime = TimeOfDay(
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
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: KText(
              text: 'returnTime',
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: black45,
                        ),
                        SizedBox(width: 10),
                        KText(
                          text: selectedRoundDate.isNull
                              ? 'selectDate'
                              : '${dateTime.format(selectedRoundDate)}'
                              .toString(),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        Spacer(),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 1,
                color: black,
              ),
              SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectTime(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 15,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.time_outline,
                          color: black45,
                        ),
                        SizedBox(width: 10),
                        KText(
                          text: selectedRoundTime.isNull
                              ? 'selectTime'
                              : '${selectedRoundTime.hourOfPeriod == 0 ? 12 : selectedRoundTime.hourOfPeriod}:${selectedRoundTime.minute.toString().padLeft(2, '0')} ${selectedRoundTime.period == DayPeriod.am ? 'AM' : 'PM'}',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),

                        Spacer(),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

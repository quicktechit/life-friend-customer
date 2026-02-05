import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  final dateFormat = DateFormat("MMM dd, yyyy hh:mm a");
  return dateFormat.format(DateTime.parse(dateTimeString));
}

import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formatToMMMDD() {
    return DateFormat('MMM d').format(this);
  }

  String toFormattedString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  DateTime parseFromString(String dateTime) {
    return DateTime.parse(dateTime);
  }
}

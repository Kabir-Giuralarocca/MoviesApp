import 'package:intl/intl.dart';

extension DateHelper on DateTime {
  String formatDate() => DateFormat.yMd().format(this);

  String toJsonType() {
    return "$year-${month < 10 ? "0$month" : "$month"}-${day < 10 ? "0$day" : "$day"}T00:00:00.00Z";
  }
}

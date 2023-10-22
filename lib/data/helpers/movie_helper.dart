import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeHelper on TimeOfDay {
  String formatDuration() =>
      "${hour == 1 ? "$hour ora" : "$hour ore"}${minute != 0 ? " e $minute minuti" : ""} ";

  String toJsonType() =>
      "${hour < 10 ? "0$hour" : "$hour"}:${minute < 10 ? "0$minute" : "$minute"}:00";
}

extension DateHelper on DateTime {
  String formatDate() => DateFormat.yMd().format(this);

  String toJsonType() =>
      "$year-${month < 10 ? "0$month" : "$month"}-${day < 10 ? "0$day" : "$day"}T00:00:00.00Z";
}

extension TimeSpanHelper on String {
  TimeOfDay toTimeOfDay() {
    try {
      var substring = split(":");
      final String hours = substring[0].startsWith("0")
          ? substring[0].substring(1)
          : substring[0];
      final String minutes = substring[1].startsWith("0")
          ? substring[1].substring(1)
          : substring[1];

      return TimeOfDay(
        hour: int.tryParse(hours) ?? 0,
        minute: int.tryParse(minutes) ?? 0,
      );
    } catch (e) {
      return const TimeOfDay(hour: 0, minute: 0);
    }
  }
}

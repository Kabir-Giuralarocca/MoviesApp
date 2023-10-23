import 'package:flutter/material.dart';

extension TimeHelper on TimeOfDay {
  String formatDuration() {
    return "${hour == 1 ? "$hour ora" : "$hour ore"}${minute != 0 ? " e $minute minuti" : ""} ";
  }

  String toJson() {
    return "${hour < 10 ? "0$hour" : "$hour"}:${minute < 10 ? "0$minute" : "$minute"}:00";
  }
}

extension TimeStringHelper on String {
  TimeOfDay toTimeOfDay() {
    var substring = split(":");
    return TimeOfDay(
      hour: int.tryParse(substring[0]) ?? 0,
      minute: int.tryParse(substring[1]) ?? 0,
    );
  }
}

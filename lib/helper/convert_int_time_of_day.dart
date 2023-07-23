import 'package:flutter/material.dart';

TimeOfDay convertIntToTimeOfDay(int time) {
  final int hour = time ~/ 100;
  final int minute = time % 100;
  return TimeOfDay(hour: hour, minute: minute);
}

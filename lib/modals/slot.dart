import 'dart:convert';

import 'package:flutter/material.dart';

class Slot {
  TimeOfDay from;
  TimeOfDay to;
  bool isEmergencySlot;
  String? isAvailable;

  Slot({
    required this.from,
    required this.to,
    this.isEmergencySlot = false,
    this.isAvailable = null,
  });

  //string to 12 hours time with am pm

  static TimeOfDay timeFromString(String time) {
    List<String> timeList = time.split(':');
    return (timeList[1].split(' ')[1] == 'AM')
        ? TimeOfDay(
            hour: int.parse(timeList[0]),
            minute: int.parse(timeList[1].split(' ')[0]),
          )
        : TimeOfDay(
            hour: int.parse((int.parse(timeList[0]) + 12).toString()),
            minute: int.parse(timeList[1].split(' ')[0]),
          );
  }

  static TimeOfDay hoursTo24hours(TimeOfDay time) {
    if (time.hour > 12) {
      return TimeOfDay(hour: time.hour - 12, minute: time.minute);
    } else {
      return TimeOfDay(hour: time.hour, minute: time.minute);
    }
  }

  static String minuteRoundOff(int minute) {
    if (minute < 10) {
      return '0$minute';
    } else {
      return '$minute';
    }
  }

  // static String timeToString(TimeOfDay time) {
  //   return '${hoursTo24hours(time).hour}:${minuteRoundOff(time.minute)}';
  // }

  static String timeToString(TimeOfDay time) {
    if (time.hour > 12) {
      return '${time.hour - 12}:${minuteRoundOff(time.minute)} PM';
    } else if (time.hour == 12) {
      return '${time.hour}:${minuteRoundOff(time.minute)} PM';
    } else if (time.hour == 0) {
      return '${12}:${minuteRoundOff(time.minute)} AM';
    } else {
      return '${time.hour}:${minuteRoundOff(time.minute)} AM';
    }
  }

  static String getDay(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Error';
    }
  }

  @override
  String toString() =>
      'Slot(from: $from, to: $to, isEmergencySlot: $isEmergencySlot, isavailable: $isAvailable)';

  Map<String, dynamic> toMap() {
    return {
      'from': timeToString(from),
      'to': timeToString(to),
      'isEmergencySlot': isEmergencySlot,
      'appointmentID': isAvailable,
    };
  }

  factory Slot.fromMap(Map<String, dynamic> map) {
    return Slot(
      from: timeFromString(map['from']),
      to: timeFromString(map['to']),
      isEmergencySlot: map['isEmergencySlot'] ?? false,
      isAvailable: map['appointmentID'] ?? null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Slot.fromJson(String source) => Slot.fromMap(json.decode(source));
}

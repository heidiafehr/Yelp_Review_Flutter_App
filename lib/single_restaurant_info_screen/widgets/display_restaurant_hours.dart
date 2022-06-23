
import 'package:flutter/material.dart';
import '../../hours.dart';

class DisplayRestaurantHours extends StatelessWidget {
  DisplayRestaurantHours(
    this.open, {
    Key? key,
  }) : super(key: key);

  final List<OpenHours> open;
  final List<String> dayOfTheWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: open
          .map((time) => Text(
                '${dayOfTheWeek[time.day]} ${processingTime(time)}',
                style: const TextStyle(height: 1.32),
              ))
          .toList(),
    );
  }
}

String processingTime(OpenHours dayInfo) {
  //if 12:00 => just say noon
  // 00:00 => midnight
  //check for overnight and stuff
  final startTime = (int.parse(dayInfo.start) % 1200).toString();
  final endTime = (int.parse(dayInfo.end) % 1200).toString();
  final startTimeWithColon =
      startTime.substring(0, 2) + ':' + startTime.substring(2, 4) + 'AM';
  final endTimeWithColon =
      endTime.substring(0, 2) + ':' + endTime.substring(2, 4) + 'PM';
  //if(dayInfo.isOvernight)
  return '$startTimeWithColon - $endTimeWithColon';
}

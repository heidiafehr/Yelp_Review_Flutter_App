
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

  String startTimeWithColon;
  String endTimeWithColon;

  //start parsing the start string
  if(dayInfo.start == '1200') {
    startTimeWithColon = '12:00 PM';
  }
  else if(dayInfo.start == '0000') {
    startTimeWithColon = '12:00 AM';
  }
  else {
    String startTime = (int.parse(dayInfo.start) % 1200).toString();
    if(startTime.length == 1) {
      startTime = '120$startTime';
    }
    if(startTime.length == 2) {
      startTime = '12$startTime';
    }
    if(startTime.length == 3) {
      startTime = '0$startTime';
    }
    startTimeWithColon =
        '${startTime.substring(0, 2)}:${startTime.substring(2, 4)}';
    if(int.parse(dayInfo.start) > 1200) {
      startTimeWithColon += ' PM';
    }
    else {
      startTimeWithColon += ' AM';
    }
  }

  //start parsing the end string
  if(dayInfo.end == '1200') {
    endTimeWithColon = '12:00 PM';
  }
  else if(dayInfo.end == '0000') {
    endTimeWithColon = '12:00 AM';
  }
  else {
    String endTime = (int.parse(dayInfo.end) % 1200).toString();
    if(endTime.length == 1) {
      endTime = '120$endTime';
    }
    if(endTime.length == 2) {
      endTime = '12$endTime';
    }
    if(endTime.length == 3) {
      endTime = '0$endTime';
    }
    endTimeWithColon =
    '${endTime.substring(0, 2)}:${endTime.substring(2, 4)}';

    if(int.parse(dayInfo.end) > 1200) {
      endTimeWithColon += ' PM';
    }
    else {
      endTimeWithColon += ' AM';
    }
  }

  return '$startTimeWithColon - $endTimeWithColon';
}

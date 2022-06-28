class Hours {
  final bool? isOpenNow;
  final List<OpenHours>? openHours;

  bool get openHoursListIsValid => (openHours != null && openHours!.isNotEmpty);

  Hours({this.isOpenNow, this.openHours});

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      isOpenNow: json['is_open_now'],
      openHours: (json['open'] as List)
          .map((openHoursJson) => OpenHours.fromJson(openHoursJson))
          .toList(),
    );
  }
}

class OpenHours {
  final bool isOvernight;
  final String start;
  final String end;
  final int day;

  OpenHours({
    required this.isOvernight,
    required this.start,
    required this.end,
    required this.day,
  });

  factory OpenHours.fromJson(Map<String, dynamic> json) {
    return OpenHours(
      isOvernight: json['is_overnight'],
      start: json['start'],
      end: json['end'],
      day: json['day'],
    );
  }
}
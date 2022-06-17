class Open{
  final bool isOvernight;
  final String start;
  final String end;
  final int day;

  Open({
    required this.isOvernight,
    required this.start,
    required this.end,
    required this.day,
  });

  factory Open.fromJson(Map<String, dynamic> json) {
    return Open(
        isOvernight: json['is_overnight'],
        start: json['start'],
        end: json['end'],
        day: json['day']
    );
  }
}
class Hours {
  final bool isOpenNow;

  Hours({ required this.isOpenNow, });

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      isOpenNow: json['is_open_now'],
    );
  }
}
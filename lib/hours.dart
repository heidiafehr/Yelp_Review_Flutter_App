class Hours {
  //final List<Open> open;
  //final String hoursType;
  final bool isOpenNow;

  Hours({
    //required this.open,
    //required this.hoursType,
    required this.isOpenNow,
  });

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      //open: (json['open'] as List).map((openJson) => Open.fromJson(openJson)).toList(),
      //hoursType: json['hours_type'],
      isOpenNow: json['is_open_now'],
    );
  }
}
class Reviews {
  final int id;

  Reviews({
    required this.id,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      id: json['total'],
    );
  }
}
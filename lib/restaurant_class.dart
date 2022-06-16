
class Restaurant {
  final String name;

  Restaurant({
    required this.name,
    });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
    );
  }
}
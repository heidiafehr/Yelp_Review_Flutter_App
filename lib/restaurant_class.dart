
class Restaurant {
  final String name;
  final String image;
  final

  Restaurant({
    required this.name,
    required this.image,
    });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      image: json['image_url'],
    );
  }
}
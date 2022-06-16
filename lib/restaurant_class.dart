import 'category.dart';

class Restaurant {
  final String name;
  final String image;

  //final Boolean isOpen;
  final String price;
  final List<Category> categories;

  Restaurant({
    required this.name,
    required this.image,
    //required this.isOpen,
    required this.price,
    required this.categories,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      image: json['image_url'],
      //isOpen: json['']
      price: json['price'],
      categories: (json['categories'] as List)
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList(),
    );
  }
}

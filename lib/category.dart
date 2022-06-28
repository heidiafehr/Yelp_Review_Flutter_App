class Category {
  final String alias;
  final String? restaurantType;

  bool get typeIsValid =>
      (restaurantType != null && restaurantType!.isNotEmpty);

  Category({
    required this.alias,
    required this.restaurantType,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(alias: json['alias'], restaurantType: json['title']);
  }
}

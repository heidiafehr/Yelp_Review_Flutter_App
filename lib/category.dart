
class Category {
  final String alias;
  final String title;

  Category({
    required this.alias,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        alias: json['alias'],
        title: json['title']
    );
  }
}

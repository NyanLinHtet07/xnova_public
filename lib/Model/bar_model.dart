class Bar {
  final int id;
  final String name;
  final String? cover;
  final String openingTime;
  final int categoryId;
  final Category category;
  final double rating;

  Bar({
    required this.id,
    required this.name,
    this.cover,
    required this.openingTime,
    required this.categoryId,
    required this.category,
    required this.rating,
  });

  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar(
      id: json['id'],
      name: json['name'],
      cover: json['cover'],
      openingTime: json['opening_time'],
      categoryId: json['category_id'],
      category: Category.fromJson(json['category']),
      rating: (json['average_rating'] as num).toDouble(),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String icon;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

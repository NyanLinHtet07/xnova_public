class Bar {
  final int id;
  final String name;
  final String? cover;
  final String openingTime;
  final int categoryId;
  final Category category;

  Bar({
    required this.id,
    required this.name,
    this.cover,
    required this.openingTime,
    required this.categoryId,
    required this.category,
  });

  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar(
      id: json['id'],
      name: json['name'],
      cover: json['cover'],
      openingTime: json['opening_time'],
      categoryId: json['category_id'],
      category: Category.fromJson(json['category']),
    );
  }
}

// class BarDetailData {
//   final int id;
//   final String name;
//   final String? cover;
//   final int categoryID;
//   final Category category;
//   final List<Images> images;
//   final String? openingTime;
//   final String? description;
//   final String? lat;
//   final String? lng;
//   final String? web;
//   final String? address;
//   final String? contact;

//   BarDetailData(
//       {required this.id,
//       required this.name,
//       this.cover,
//       required this.categoryID,
//       required this.category,
//       required this.images,
//       this.openingTime,
//       this.description,
//       this.lat,
//       this.lng,
//       this.web,
//       this.address,
//       this.contact});

//   factory BarDetailData.fromJson(Map<String, dynamic> json) {
//     return BarDetailData(
//         id: json['id'],
//         name: json['name'],
//         cover: json['cover'],
//         categoryID: json['category_id'],
//         category: json['category'],
//         images: (json['images'] as List<dynamic>)
//                   .map((imageJson) => Images.fromJson(imageJson))
//                   .toList(),
//         openingTime: json['opening_time'],
//         description: json['description'],
//         lat: json['location_lat'],
//         lng: json['loation_long'],
//         web: json['web'],
//         address: json['address'],
//         contact: json['contact']);
//   }
// }

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

// class Images {
//   final int id;
//   final String image;

//   Images({required this.id, required this.image});

//   factory Images.fromJson(Map<String, dynamic> json) {
//     return Images(
//       id: json['id'],
//       image: json['image'],
//     );
//   }
// }

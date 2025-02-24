import 'dart:convert';

class BarDetailData {
  final int id;
  final String name;
  final String? cover;
  final String openingTime;
  final int categoryId;
  final Category category;
  final List<Images> images;
  //final List<MenuCategory> menus;
  final String? description;
  final double? lat;
  final double? lng;
  final String? web;
  final String? address;
  final String? contact;
  final List<Amenity> amenities;

  BarDetailData(
      {required this.id,
      required this.name,
      this.cover,
      required this.openingTime,
      required this.categoryId,
      required this.category,
      required this.images,
      //required this.menus,
      this.description,
      this.lat,
      this.lng,
      this.web,
      this.address,
      this.contact,
      required this.amenities});

  factory BarDetailData.fromJson(Map<String, dynamic> json) {
    return BarDetailData(
      id: json['id'],
      name: json['name'],
      cover: json['cover'],
      openingTime: json['opening_time'],
      categoryId: json['category_id'],
      category: Category.fromJson(json['category']),
      images: (json['images'] as List<dynamic>)
          .map((imageJson) => Images.fromJson(imageJson))
          .toList(),
      // menus: json['menus'] != null
      //     ? (json['menus'] as List)
      //         .map((category) => MenuCategory.fromJson(category))
      //         .toList()
      //     : [],
      description: json['description'],
      lat: (json['location_lat'] != null)
          ? double.tryParse(json['location_lat'].toString())
          : null,
      lng: (json['location_long'] != null)
          ? double.tryParse(json['location_long'].toString())
          : null,
      web: json['web'],
      address: json['address'],
      contact: json['contact'],
      amenities: json['amenities'] is String
          ? (jsonDecode(json['amenities']) as List)
              .map((item) => Amenity.fromJson(item))
              .toList()
          : (json['amenities'] as List<dynamic>?)
                  ?.map((item) => Amenity.fromJson(item))
                  .toList() ??
              [],
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

class Images {
  final int id;
  final String image;

  Images({required this.id, required this.image});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      id: json['id'],
      image: json['image'],
    );
  }
}

// class MenuItem {
//   final String name;
//   final int price;

//   MenuItem({required this.name, required this.price});

//   factory MenuItem.fromJson(Map<String, dynamic> json) {
//     return MenuItem(
//       name: json['menu'],
//       price: json['price'],
//     );
//   }
// }

// class MenuCategory {
//   final String title;
//   final List<MenuItem> menus;

//   MenuCategory({required this.title, required this.menus});

//   factory MenuCategory.fromJson(Map<String, dynamic> json) {
//     return MenuCategory(
//       title: json['title'] ?? 'Unknown',
//       menus: json['menus'] != null
//           ? (jsonDecode(json['menus']) as List)
//               .map((item) => MenuItem.fromJson(item))
//               .toList()
//           : [],
//     );
//   }
// }

class Amenity {
  final int id;
  final String name;

  Amenity({required this.id, required this.name});

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
      id: json['id'],
      name: json['name'],
    );
  }
}

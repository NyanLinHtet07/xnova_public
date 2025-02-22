class BarMenuModel {
  final int id;
  final String title;
  final List<MenuDetail> menuItems;

  BarMenuModel(
      {required this.id, required this.title, required this.menuItems});

  factory BarMenuModel.fromJson(Map<String, dynamic> json) {
    return BarMenuModel(
      id: json['id'],
      title: json['title'],
      menuItems: (json['menuitems'] as List)
          .map((item) => MenuDetail.fromJson(item))
          .toList(),
    );
  }
}

class MenuDetail {
  final int id;
  final String name;
  final int price;
  final String image;

  MenuDetail(
      {required this.id,
      required this.name,
      required this.price,
      required this.image});

  factory MenuDetail.fromJson(Map<String, dynamic> json) {
    return MenuDetail(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        image: json['image']);
  }
}

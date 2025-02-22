class Promotion {
  final int id;
  final int barId;
  final String? image;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final int isActive;
  final int isCover;
  final BarData bar;

  Promotion(
      {required this.id,
      required this.barId,
      this.image,
      this.description,
      this.startDate,
      this.endDate,
      required this.isActive,
      required this.isCover,
      required this.bar});

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      id: json['id'],
      barId: json['bar_id'],
      image: json['image'] ?? "",
      description: json['description'] ?? "No Description",
      startDate: json['start_promo'] != null
          ? DateTime.tryParse(json['start_promo'])
          : null,
      endDate: json['end_promo'] != null
          ? DateTime.tryParse(json['end_promo'])
          : null,
      isActive: json['is_active'],
      isCover: json['is_cover'],
      bar: BarData.fromJson(json['bar']),
    );
  }
}

class BarData {
  final int id;
  final String name;

  BarData({
    required this.id,
    required this.name,
  });

  factory BarData.fromJson(Map<String, dynamic> json) {
    return BarData(id: json['id'], name: json['name']);
  }
}

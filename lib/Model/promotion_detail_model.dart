class PromotionDetail {
  final int id;
  final int barId;
  final String? image;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final int isActive;
  final int isCover;

  PromotionDetail(
      {required this.id,
      required this.barId,
      this.image,
      this.description,
      this.startDate,
      this.endDate,
      required this.isActive,
      required this.isCover});

  factory PromotionDetail.fromJson(Map<String, dynamic> json) {
    return PromotionDetail(
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
        isCover: json['is_cover']);
  }
}

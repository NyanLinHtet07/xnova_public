class Review {
  final int id;
  final int rating;
  final String? review;
  final String createdAt;
  final User user;

  Review(
      {required this.id,
      required this.rating,
      this.review,
      required this.createdAt,
      required this.user});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rating: json['rating'],
      review: json['review'],
      createdAt: json['created_at'],
      user: User.fromJson(json['user']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'bar_id': barId,
  //     'user_id': userId,
  //     'rating': rating,
  //     'review': review
  //   };
  // }
}

class User {
  final int id;
  final String name;
  final String? profile;

  User({
    required this.id,
    required this.name,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], profile: json['profile']);
  }
}

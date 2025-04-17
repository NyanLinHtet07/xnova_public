import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/user_review_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReviewService {
  final String baseURL = 'https://xnova.nyanlinhtet.com/api';
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<bool> submitReview({
    required int barId,
    required int rating,
    String? review,
  }) async {
    final token = await storage.read(key: 'token');
    final userData = await storage.read(key: 'user');
    if (token == null || userData == null) {
      return false;
    }
    final user = json.decode(userData);
    final userId = user['id'];

    final response = await http.post(
      Uri.parse('$baseURL/mobile/user/review'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        'bar_id': barId,
        'user_id': userId,
        'rating': rating,
        'review': review
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print("Submit failed: ${response.body}");
      return false;
    }
  }

  Future<List<Review>> fetchReviews(int barId) async {
    final url = Uri.parse('$baseURL/bars/$barId/reviews');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final List<dynamic> data = jsonBody['data'];

      return data.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseURL = 'https://xnova.nyanlinhtet.com/api';
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseURL/user/register'),
      headers: {'Accept': 'application/json'},
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 201) {
      final token = responseData['token'];
      final user = responseData['user'];

      if (token != null && user != null) {
        await storage.write(key: 'token', value: token);
        await storage.write(key: 'user', value: json.encode(user));
        return {'success': true, 'message': 'Register Successful'};
      } else {
        return {
          'success': false,
          'message': 'Something went wrong. Please try again.'
        };
      }
    } else if (response.statusCode == 422) {
      String errorMessage = responseData['message'] ?? 'Validation error';
      if (responseData['errors'] != null) {
        final errors = responseData['errors'] as Map<String, dynamic>;
        errorMessage =
            errors.values.map((e) => (e as List).join(', ')).join('\n');
      }

      return {'success': false, 'message': errorMessage};
    } else {
      return {
        'success': false,
        'message': 'Something went wrong. Please try again.'
      };
    }
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseURL/login'),
      headers: {'Accept': 'application/json'},
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];
      final user = responseData['user'];

      if (token != null && user != null) {
        await storage.write(key: 'token', value: token);
        await storage.write(key: 'user', value: json.encode(user));
        return true;
      }
    }

    return false;
  }

  Future<void> logout() async {
    final token = await storage.read(key: 'token');

    await http.post(
      Uri.parse('$baseURL/logout'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    await storage.delete(key: 'token');
  }

  Future<Map<String, dynamic>?> getUser() async {
    final token = await storage.read(key: 'token');

    final response = await http.get(
      Uri.parse('$baseURL/user'),
      headers: {
        'Accept': 'application/json',
        'AUthorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    return null;
  }

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'token');
    return token != null;
  }
}

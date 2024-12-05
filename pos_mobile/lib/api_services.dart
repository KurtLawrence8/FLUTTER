import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final String _baseUrl = 'http://10.1.0.1:8000/api';

  Future<http.Response> registerUser(Map<String, String> userData) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/register'), body: userData);
      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Registration failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during registration: $e');
    }
  }

  Future<http.Response> loginUser(Map<String, String> credentials) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(credentials), // Send credentials as JSON
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> storeUserID(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', userId);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userid') ?? '';
  }

  Future<http.Response> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('userid');
    String? token = prefs.getString('token');

    if (id == null || token == null) {
      throw Exception('User ID or token is missing');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to fetch user data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
}

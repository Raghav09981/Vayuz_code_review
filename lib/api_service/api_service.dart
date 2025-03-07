import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ui_design/data_models/get_single_user.dart';
import 'package:ui_design/data_models/get_users.dart';
import 'package:ui_design/data_models/status_change.dart';

class ApiService {
  static const String baseUrl = 'https://crud-vip.vercel.app';
  Future<Map<String, dynamic>?> _checkResponse(http.Response response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  Future<GetUsers> getUserData(int page) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/users?page=$page&limit=5&search='));
      final data = await _checkResponse(response);
      return GetUsers.fromJson(data!);
    } catch (e) {
      throw Exception('Failed to load user data: $e');
    }
  }

  Future<Map<String, dynamic>?> updateUser(String id, String name, String email,
      String phone, String location) async {
    print(name);
    try {
      final response = await http.put(Uri.parse('$baseUrl/api/users/$id'),
        body: {
          'name': name,
          'email': email,
          'phone': phone,
          'location': location
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to update data');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<Map<String, dynamic>?> deleteUser(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/api/users/$id'),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('failed to delete data');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<StatusChange> statusChange(String id) async {
    try {
      final response =
          await http.patch(Uri.parse('$baseUrl/api/users/$id/status'));
      final data = await _checkResponse(response);
      return StatusChange.fromJson(data!);
    } catch (e) {
      throw Exception('Failed to change status: $e');
    }
  }

  Future<GetSingleUser> getSingleUser(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/users/$id'));
      final data = await _checkResponse(response);
      return GetSingleUser.fromJson(data!);
    } catch (e) {
      throw Exception('Failed to load single user: $e');
    }
  }

  Future<void> createUser(
      String name, String email, String phone, String location) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://crud-vip.vercel.app/api/users'),
      );

      request.fields.addAll({
        'name': name,
        'email': email,
        'phone': phone,
        'location': location,
      });

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        print("User created successfully!");
        print("Response: $responseBody");
      } else {
        print("Failed to create user: $responseBody");
        throw Exception("Failed to create user: ${response.statusCode}");
      }
    } catch (e) {
      print("Error creating user: $e");
      throw Exception('Failed to create user: $e');
    }
  }

  Future<Map<String, dynamic>?> signUp(
      String fullName, String email, String phoneNo, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/app/api/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'phoneNumber': phoneNo,
          'password': password,
        }),
      );
      return await _checkResponse(response);
    } catch (e) {
      debugPrint("Error during signup: $e");
      return null;
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      final data = await _checkResponse(response);
      return data?['token'];
    } catch (e) {
      debugPrint("Error during login: $e");
      return null;
    }
  }
}
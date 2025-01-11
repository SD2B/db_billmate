import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

 static Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to GET data from $endpoint');
    }
  }

static  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to POST data to $endpoint');
    }
  }

 static Future<void> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to DELETE data from $endpoint');
    }
  }

 static Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to PUT data to $endpoint');
    }
  }
}

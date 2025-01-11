import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

final apiClient = ApiHelper('https://api-machine-test.hilalcart.com/');
final fileClient = ApiHelper('https://api.escuelajs.co/api/v1/');

class ApiHelper {
  final String baseUrl;

  static String login = "login";
  static String getItemList = 'food/list';
  static String fileUpload = 'files/upload';
  static String getNDelete(int id) => 'food/read-delete/$id';

  static String addMenu = 'food/create';

  ApiHelper(this.baseUrl);

  // GET Request
  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(url);
      return _processResponse(response);
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  // POST Request
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  // DELETE Request
  Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.delete(url);
      return _processResponse(response);
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  // Upload File (Multipart Request)
  Future<dynamic> uploadFile(String endpoint, File file, String keyName) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final request = http.MultipartRequest('POST', url)..files.add(await http.MultipartFile.fromPath(keyName, file.path));
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(responseBody);
        return data['location'];
      } else {
        throw Exception('File upload failed with status: ${response.statusCode}, body: $responseBody');
      }
    } catch (e) {
      throw Exception('File upload error: $e');
    }
  }

  // Handle API Response
  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

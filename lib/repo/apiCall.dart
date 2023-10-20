import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiCall {
  Future fetchUsers() async {
    final Uri url =
        Uri.parse('http://54.177.228.124:8000/api/v1/post/getTestingPosts');

    final Map<String, dynamic> requestBody = {
      "pageNumber": 1,
    };

    final String jsonBody = json.encode(requestBody);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> res = json.decode(response.body);

      final List<dynamic> parsedData = res['result'];

      return parsedData;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

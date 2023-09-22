import 'package:http/http.dart' as http;

import 'dart:convert';

class ApiCall {
  Future<List<dynamic>> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      final List<dynamic> parsedData = json.decode(response.body);

      for (int i = 0; i < parsedData.length; i++) 
      print(parsedData[i]["name"]);

      return parsedData;
    } else {
      throw Exception('Failed to load users');
    }
  }
}

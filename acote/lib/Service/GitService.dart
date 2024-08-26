import 'dart:convert';
import 'package:acote/Model/UserModel.dart';
import 'package:http/http.dart' as http;

class GitService {
  static const String baseUrl = 'https://api.github.com';

  Future<List<User>> fetchUsers(int since) async {
    final response = await http.get(Uri.parse('$baseUrl/users?since=$since'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

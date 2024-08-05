import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_postviewer/models/post.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/posts'));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<Post> posts = body.map((dynamic item) => Post.fromJson(item)).toList();
        return posts;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Post> fetchPost(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/posts/$id'));

      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

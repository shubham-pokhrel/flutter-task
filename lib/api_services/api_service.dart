import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_postviewer/models/album.dart';
import 'package:my_postviewer/models/post.dart';
import 'package:my_postviewer/models/comment.dart';
import 'package:my_postviewer/models/todo.dart';
import 'package:my_postviewer/models/user.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  // Fetches a list of posts
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

  // Fetches a single post by id
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

  // Fetches comments for a specific post
  Future<List<Comment>> fetchComments(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/posts/$id/comments'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetches a list of users
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users'));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<User> users = body.map((dynamic item) => User.fromJson(item)).toList();
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetches posts for a specific user
  Future<List<Post>> fetchUserPosts(int userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users/$userId/posts'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetches albums for a specific user
  Future<List<Album>> fetchUserAlbums(int userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users/$userId/albums'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((album) => Album.fromJson(album)).toList();
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetches todos for a specific user
  Future<List<Todo>> fetchUserTodos(int userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/users/$userId/todos'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

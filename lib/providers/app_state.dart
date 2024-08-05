import 'package:flutter/material.dart';
import 'package:my_postviewer/models/post.dart';
import 'package:my_postviewer/api_services/api_service.dart';

class AppState extends ChangeNotifier {
  List<Post> _posts = [];
  List<Post> _filteredPosts = [];
  bool _isLoading = true;
  String _searchQuery = '';

  List<Post> get posts => _filteredPosts;
  bool get isLoading => _isLoading;

  AppState() {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      _posts = await ApiService().fetchPosts();
      _filteredPosts = _posts;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filteredPosts = _posts
        .where((post) =>
            post.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
    notifyListeners();
  }
}

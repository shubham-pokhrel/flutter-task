import 'package:flutter/material.dart';
import 'package:my_postviewer/models/post.dart';
import 'package:my_postviewer/api_services/api_service.dart';
import 'package:my_postviewer/screens/post_details_screen.dart'; // Import PostDetailsScreen if navigation is needed

class UserPostsScreen extends StatefulWidget {
  final int userId;

  UserPostsScreen({required this.userId});

  @override
  _UserPostsScreenState createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Post> _allPosts = [];
  List<Post> _filteredPosts = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterPosts);
    _fetchPosts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPosts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPosts = _allPosts
          .where((post) =>
              post.title.toLowerCase().contains(query) ||
              post.body.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _fetchPosts() async {
    try {
      final posts = await ApiService().fetchUserPosts(widget.userId);
      setState(() {
        _allPosts = posts;
        _filteredPosts = posts;
      });
    } catch (e) {
      // Handle error
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('User Posts'),
      //   backgroundColor: Colors.teal, 
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search, color: Colors.teal),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await _fetchPosts();
              },
              child: ListView.builder(
                itemCount: _filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = _filteredPosts[index];
                  return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          elevation: 4.0, // Elevation for card shadow
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            title: Text(
                              post.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.teal, // Text color
                              ),
                            ),
                            subtitle: Text(
                              post.body,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[600]), // Subtitle text color
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PostDetailsScreen(postId: post.id),
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

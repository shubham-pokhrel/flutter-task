import 'package:flutter/material.dart';
import 'package:my_postviewer/models/post.dart';
import 'package:my_postviewer/api_services/api_service.dart';
import 'post_details_screen.dart';

class PostsListScreen extends StatefulWidget {
  @override
  _PostsListScreenState createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  late Future<List<Post>> futurePosts;
  List<Post> _posts = [];
  List<Post> _filteredPosts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futurePosts = ApiService().fetchPosts();
    futurePosts.then((posts) {
      setState(() {
        _posts = posts;
        _filteredPosts = posts;
      });
    });
    _searchController.addListener(_filterPosts);
  }

  void _filterPosts() {
    setState(() {
      _filteredPosts = _posts
          .where((post) => post.title.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _refreshPosts() async {
    setState(() {
      futurePosts = ApiService().fetchPosts();
      futurePosts.then((posts) {
        setState(() {
          _posts = posts;
          _filteredPosts = posts;
        });
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts List'),
        backgroundColor: Colors.teal, // Consistent color for the app bar
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Add padding around the search field
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search, color: Colors.teal), // Search icon color
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: futurePosts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No posts found'));
                } else {
                  return RefreshIndicator(
                    onRefresh: _refreshPosts,
                    child: ListView.builder(
                      itemCount: _filteredPosts.length,
                      itemBuilder: (context, index) {
                        final post = _filteredPosts[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          elevation: 4.0, // Elevation for card shadow
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16.0), // Padding inside the card
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
                              style: TextStyle(color: Colors.grey[600]), // Subtitle text color
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostDetailsScreen(postId: post.id),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

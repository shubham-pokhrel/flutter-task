import 'package:flutter/material.dart';
import 'package:my_postviewer/providers/app_state.dart';
import 'package:my_postviewer/models/post.dart';
import 'package:provider/provider.dart';
import 'post_details_screen.dart';

class PostsListScreen extends StatefulWidget {
  @override
  _PostsListScreenState createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      Provider.of<AppState>(context, listen: false)
          .updateSearchQuery(_searchController.text);
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
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (appState.posts.isEmpty) {
            return Center(child: Text('No posts found'));
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      prefixIcon:
                          Icon(Icons.search, color: Colors.teal),
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => Provider.of<AppState>(context,
                            listen: false)
                        .fetchPosts(),
                    child: ListView.builder(
                      itemCount: appState.posts.length,
                      itemBuilder: (context, index) {
                        final post = appState.posts[index];
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
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_postviewer/providers/app_state.dart';
import 'package:provider/provider.dart';
import 'post_details_screen.dart';

class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  _PostsListScreenState createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  final TextEditingController _searchController = TextEditingController();

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
        title: const Text('Posts List'),
        backgroundColor: Colors.teal, // Consistent color for the app bar
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (appState.posts.isEmpty) {
            return const Center(child: Text('No posts found'));
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          elevation: 4.0, // Elevation for card shadow
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            title: Text(
                              post.title,
                              style: const TextStyle(
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

import 'package:flutter/material.dart';
import 'package:my_postviewer/models/post.dart';
import 'package:my_postviewer/models/comment.dart';
import 'package:my_postviewer/screens/add_comment_screen.dart';
import 'package:my_postviewer/api_services/api_service.dart';

class PostDetailsScreen extends StatefulWidget {
  final int postId;

  PostDetailsScreen({required this.postId});

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late Future<Post> _postFuture;
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _postFuture = ApiService().fetchPost(widget.postId);
    _commentsFuture = ApiService().fetchComments(widget.postId);
  }

  Future<void> _refreshComments() async {
    setState(() {
      _commentsFuture = ApiService().fetchComments(widget.postId);
    });
  }

  Future<void> _navigateToAddCommentScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCommentScreen(
          postId: widget.postId,
          onCommentAdded: _refreshComments, // Pass the callback function
        ),
      ),
    );

    // If result is true, refresh comments
    if (result == true) {
      _refreshComments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: FutureBuilder<Post>(
        future: _postFuture,
        builder: (context, postSnapshot) {
          if (postSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (postSnapshot.hasError) {
            return Center(child: Text('Error: ${postSnapshot.error}'));
          } else if (!postSnapshot.hasData) {
            return Center(child: Text('No post found'));
          } else {
            final post = postSnapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('User ID: ${post.userId}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text(post.body),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: _navigateToAddCommentScreen,
                        child: Text('Add Comment'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshComments,
                      child: FutureBuilder<List<Comment>>(
                        future: _commentsFuture,
                        builder: (context, commentsSnapshot) {
                          if (commentsSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (commentsSnapshot.hasError) {
                            return Center(child: Text('Failed to load comments'));
                          } else if (!commentsSnapshot.hasData || commentsSnapshot.data!.isEmpty) {
                            return Center(child: Text('No comments available'));
                          } else {
                            final comments = commentsSnapshot.data!;
                            return ListView.builder(
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                final comment = comments[index];
                                return Card(
                                  margin: EdgeInsets.symmetric(vertical: 8.0),
                                  elevation: 4.0,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(16.0),
                                    title: Text(
                                      comment.name,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(comment.body),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

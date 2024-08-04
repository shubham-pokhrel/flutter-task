import 'package:flutter/material.dart';

class PostDetailsScreen extends StatelessWidget {
  final int postId;

  PostDetailsScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: Center(
        child: Text('Post Details Screen for Post ID: $postId'),
      ),
    );
  }
}

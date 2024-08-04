import 'package:flutter/material.dart';
import 'post_details_screen.dart';

class PostsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts List'),
      ),
      body: ListView.builder(
        itemCount: 10, // This should be the length of your posts list
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Post ${index + 1}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsScreen(postId: index + 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'posts_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostsListScreen(),
                  ),
                );
              },
              child: Text('Go to Posts List'),
            ),
            // Additional buttons can be added here for other screens
          ],
        ),
      ),
    );
  }
}

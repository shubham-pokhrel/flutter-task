import 'package:flutter/material.dart';
import 'package:my_postviewer/screens/user_list_screen.dart';
import 'posts_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Viewer'),
        backgroundColor: Colors.teal, // Minimalistic color for the app bar
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Add padding around the body
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: Text('Go to Posts List'),
              ),
              SizedBox(height: 16.0), // Add space between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: Text('Go to User List'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

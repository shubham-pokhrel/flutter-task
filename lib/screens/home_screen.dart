import 'package:flutter/material.dart';
import 'package:my_postviewer/screens/user_list_screen.dart';
import 'posts_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Viewer'),
        backgroundColor: Colors.teal, // Minimalistic color for the app bar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Add padding around the body
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostsListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: const Text('Go to Posts List'),
              ),
              const SizedBox(height: 16.0), // Add space between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Button background color
                  foregroundColor: Colors.white, // Button text color
                ),
                child: const Text('Go to User List'),
              ),
             
            ],
            
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50,
            padding: const EdgeInsets.all(13.0),
            child: const Text('Designed By Shubham Pokhrel', textAlign: TextAlign.center),),
        ),
    );
  }
}

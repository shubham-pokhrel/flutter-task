import 'package:flutter/material.dart';
import 'package:my_postviewer/models/user.dart';
import 'package:my_postviewer/screens/user_post_screen.dart';
import 'package:my_postviewer/screens/user_albums_screen.dart';
import 'package:my_postviewer/screens/user_todos_screen.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.name),
          bottom: TabBar(
            tabs: [
              Tab(text: "Posts"),
              Tab(text: "Albums"),
              Tab(text: "Todos"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserPostsScreen(userId: user.id),
            UserAlbumsScreen(userId: user.id),
            UserTodosScreen(userId: user.id),
          ],
        ),
      ),
    );
  }
}

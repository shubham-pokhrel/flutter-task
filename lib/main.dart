import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyPostViewerApp());
}

class MyPostViewerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Post Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

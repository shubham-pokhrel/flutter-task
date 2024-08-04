import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Post Viewer'),
        ),
        body: Center(
          child: Text('Blank Screen'),
        ),
      ),
    );
  }
}

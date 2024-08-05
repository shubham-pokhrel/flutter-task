import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AddCommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment'),
      ),
      body: Center(
        child: Text('Add comment Screen'),
      ),
    );
  }
}
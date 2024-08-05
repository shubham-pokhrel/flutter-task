import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCommentScreen extends StatefulWidget {
  final int postId;

  AddCommentScreen({required this.postId});

  @override
  _AddCommentScreenState createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bodyController = TextEditingController();

  Future<void> _addComment() async {
    if (_formKey.currentState!.validate()) {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/${widget.postId}/comments'),
        body: {
          'postId': widget.postId.toString(),
          'name': _nameController.text,
          'email': _emailController.text,
          'body': _bodyController.text,
        },
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        throw Exception('Failed to add comment');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'Comment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your comment';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addComment,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}

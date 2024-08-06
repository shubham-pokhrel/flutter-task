import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCommentScreen extends StatefulWidget {
  final int postId;
  final VoidCallback onCommentAdded;

  const AddCommentScreen({super.key, required this.postId, required this.onCommentAdded});

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
        Uri.parse('https://jsonplaceholder.typicode.com/comments'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'postId': widget.postId,
          'name': _nameController.text,
          'email': _emailController.text,
          'body': _bodyController.text,
        }),
      );

      if (response.statusCode == 201) {
        widget.onCommentAdded(); // Notify the parent widget
        Navigator.pop(context, true); // Return true to indicate success

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comment added successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.teal, // Consistent background color for snack bar
          ),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add comment'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red, // Error message color
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Comment'),
        backgroundColor: Colors.teal, // Consistent color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add your comment below:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Consistent text color
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.comment),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your comment';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _addComment,
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromARGB(255, 163, 182, 184), // Consistent button color
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                ),
                child: const Text('Submit', style: TextStyle(fontSize: 16)),
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

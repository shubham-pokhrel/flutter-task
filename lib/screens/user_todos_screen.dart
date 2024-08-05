import 'package:flutter/material.dart';
import 'package:my_postviewer/models/todo.dart'; 
import 'package:my_postviewer/api_services/api_service.dart';

class UserTodosScreen extends StatelessWidget {
  final int userId;

  UserTodosScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('User Todos'),
      //   backgroundColor: Colors.teal,
      // ),
      body: FutureBuilder<List<Todo>>(
        future: ApiService().fetchUserTodos(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red), // Error message color
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No todos found',
                style: TextStyle(color: Colors.teal), // text color
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final todo = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  //color: Color.fromARGB(255, 240, 240, 240), 
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal, // Consistent text color
                      ),
                    ),
                    trailing: Checkbox(
                      value: todo.completed,
                      onChanged: (bool? value) {
                        // Handle checkbox state change here
                      },
                      checkColor: const Color.fromARGB(255, 8, 8, 8), // Checkbox check color
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

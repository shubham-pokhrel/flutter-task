import 'package:flutter/material.dart';
import 'package:my_postviewer/models/album.dart'; 
import 'package:my_postviewer/api_services/api_service.dart';

class UserAlbumsScreen extends StatelessWidget {
  final int userId;

  UserAlbumsScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('User Albums'),
      //   backgroundColor: Colors.teal, 
      // ),
      body: FutureBuilder<List<Album>>(
        future: ApiService().fetchUserAlbums(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No albums found', style: TextStyle(color: Colors.teal)));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final album = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      album.title, 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal, // Consistent text color
                      ),
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

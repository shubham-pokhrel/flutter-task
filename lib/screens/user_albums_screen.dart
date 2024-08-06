import 'package:flutter/material.dart';
import 'package:my_postviewer/models/album.dart'; 
import 'package:my_postviewer/api_services/api_service.dart';

class UserAlbumsScreen extends StatelessWidget {
  final int userId;

  const UserAlbumsScreen({super.key, required this.userId});

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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No albums found', style: TextStyle(color: Colors.teal)));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final album = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      album.title, 
                      style: const TextStyle(
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

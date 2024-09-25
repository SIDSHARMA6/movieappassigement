import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Map movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(movie['name']),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                movie['image'] != null ? movie['image']['medium'] : 'https://via.placeholder.com/210x295',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              movie['name'],
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ?? 'No summary available',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

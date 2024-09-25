import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'DetailsScreen.dart';
import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      setState(() {
        movies = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Movies',
          style: TextStyle(color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: movies.isEmpty
          ? Center(child: CircularProgressIndicator(color: Colors.red))
          : GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index]['show'];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: movie),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(movie['image'] != null
                      ? movie['image']['medium']
                      : 'https://via.placeholder.com/210x295'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    movie['name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

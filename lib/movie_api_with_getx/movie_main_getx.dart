import 'package:abc/movie_api_with_getx/controller_movie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MovieSearchScreen(),
  ));
}

class MovieSearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie Search (GetX)")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search movies...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      movieController.searchMovies(_searchController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (movieController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (movieController.errorMessage.value.isNotEmpty) {
                  return Center(child: Text(movieController.errorMessage.value));
                } else {
                  return ListView.builder(
                    itemCount: movieController.movies.length,
                    itemBuilder: (context, index) {
                      final movie = movieController.movies[index];
                      return ListTile(
                        leading: Image.network(movie["Poster"], width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(movie["Title"]),
                        subtitle: Text("Year: ${movie["Year"]}"),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

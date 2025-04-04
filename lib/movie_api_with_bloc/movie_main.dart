import 'package:abc/movie_api_with_bloc/bloc/movie_bloc.dart';
import 'package:abc/movie_api_with_bloc/bloc/movie_event.dart';
import 'package:abc/movie_api_with_bloc/bloc/movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api_service_movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MovieBloc(ApiService()),
        child: MovieSearchScreen(),
      ),
    );
  }
}

class MovieSearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie Search (Bloc)")),
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
                      context.read<MovieBloc>().add(SearchMovies(_searchController.text));
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MovieLoaded) {
                    return ListView.builder(
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        return ListTile(
                          leading: Image.network(movie["Poster"], width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(movie["Title"]),
                          subtitle: Text("Year: ${movie["Year"]}"),
                        );
                      },
                    );
                  } else if (state is MovieError) {
                    return Center(child: Text(state.message));
                  }
                  return Center(child: Text("Search for movies!"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

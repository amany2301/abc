import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_service_movie.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final ApiService apiService;

  MovieBloc(this.apiService) : super(MovieInitial()) {
    on<SearchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await apiService.fetchMovies(event.query);
        emit(MovieLoaded(movies));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}

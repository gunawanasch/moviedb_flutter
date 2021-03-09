import 'package:moviedb_flutter/model/popular_movies_model.dart';
import 'package:moviedb_flutter/model/upcoming_movies_model.dart';
import 'movies_repository.dart';

class MoviesDomain {
  final MoviesRepository moviesRepository;

  MoviesDomain(this.moviesRepository);

  // Future<PopularMoviesModel> getListPopularMovies() {
  //   return movieRepository.getListPopularMovies();
  // }
  //
  // Future<UpcomingMoviesModel> getListUpcomingMovies() {
  //   return movieRepository.getListUpcomingMovies();
  // }

}

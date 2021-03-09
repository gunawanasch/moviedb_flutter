import 'package:dio/dio.dart';
import 'package:moviedb_flutter/constants.dart';
import 'package:moviedb_flutter/model/popular_movies_model.dart';
import 'package:moviedb_flutter/model/upcoming_movies_model.dart';

class MoviesRepository {
  final Dio _dio = Dio();

  Future<PopularMoviesModel> getPopularMovies() async {
    try {
      Response response = await _dio.get("${baseUrl}movie/popular?api_key=$apiKey&language=en-US&page=1");
      return PopularMoviesModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  Future<UpcomingMoviesModel> getUpcomingMovies() async {
    try {
      Response response = await _dio.get(
          "${baseUrl}movie/upcoming?api_key=$apiKey&language=en-US&page=1");
      return UpcomingMoviesModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

}

class NetworkError extends Error {}
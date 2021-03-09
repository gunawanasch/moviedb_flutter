import 'package:equatable/equatable.dart';
import 'package:moviedb_flutter/model/popular_movies_model.dart';
import 'package:moviedb_flutter/model/upcoming_movies_model.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
}

class MoviesInitial extends MoviesState {
  const MoviesInitial();
  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
  @override
  List<Object> get props => null;
}

class PopularMoviesSuccess extends MoviesState {
  final PopularMoviesModel popularMoviesModel;
  const PopularMoviesSuccess(this.popularMoviesModel);
  @override
  List<Object> get props => [popularMoviesModel];
}

class UpcomingMoviesSuccess extends MoviesState {
  final UpcomingMoviesModel upcomingMoviesModel;
  const UpcomingMoviesSuccess(this.upcomingMoviesModel);
  @override
  List<Object> get props => [upcomingMoviesModel];
}

class MoviesError extends MoviesState {
  final String message;
  const MoviesError(this.message);
  @override
  List<Object> get props => [message];
}
import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
}

class GetPopularMovies extends MoviesEvent {
  @override
  List<Object> get props => null;
}

class GetUpcomingMovies extends MoviesEvent {
  @override
  List<Object> get props => null;
}
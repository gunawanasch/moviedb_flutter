import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter/data/movies_repository.dart';

import 'movies_event.dart';
import 'movies_state.dart';

class UpcomingMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository _moviesRepository;

  UpcomingMoviesBloc(this._moviesRepository) : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(
      MoviesEvent event,
      ) async* {
    if (event is GetUpcomingMovies) {
      try {
        yield MoviesLoading();
        final list = await _moviesRepository.getUpcomingMovies();
        yield UpcomingMoviesSuccess(list);
        if (list.error != null) {
          yield MoviesError(list.error);
        }
      } on NetworkError {
        yield MoviesError("Failed to fetch data. There is problem in your network.");
      }
    }
  }

}
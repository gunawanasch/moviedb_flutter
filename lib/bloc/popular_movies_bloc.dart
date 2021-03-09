import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter/data/movies_repository.dart';
import 'movies_event.dart';
import 'movies_state.dart';

class PopularMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository _moviesRepository;

  PopularMoviesBloc(this._moviesRepository) : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(
      MoviesEvent event,
      ) async* {
    if (event is GetPopularMovies) {
      try {
        yield MoviesLoading();
        final list = await _moviesRepository.getPopularMovies();
        yield PopularMoviesSuccess(list);
        if (list.error != null) {
          yield MoviesError(list.error);
        }
      } on NetworkError {
        yield MoviesError("Failed to fetch data. There is problem in your network.");
      }
    }
  }

}
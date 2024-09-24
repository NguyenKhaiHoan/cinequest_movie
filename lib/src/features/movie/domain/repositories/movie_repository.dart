import 'package:cinequest/src/core/generics/type_def.dart';

import '../entities/movie.dart';
import '../entities/params/movie_lists_params.dart';

abstract class MovieRepository {
  FutureEither<List<Movie>> getNowPlayingMovies(MovieListsParams params);
  FutureEither<List<Movie>> getPopularMovies(MovieListsParams params);
}

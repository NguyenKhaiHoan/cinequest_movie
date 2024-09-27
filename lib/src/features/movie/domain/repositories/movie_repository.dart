import 'package:cinequest/src/core/generics/type_def.dart';

import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/delete_movie_local_params.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/is_favorite_local_params.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/movie_lists_params.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/save_movie_local_params.dart';

/// Movie repository
abstract class MovieRepository {
  ///
  FutureEither<List<Movie>> getNowPlayingMovies(MovieListsParams params);

  ///
  FutureEither<List<Movie>> getPopularMovies(MovieListsParams params);

  ///
  FutureEither<void> saveMovieLocal(SaveMovieLocalParams params);

  ///
  FutureEither<List<Movie>> getMoviesLocal();

  ///
  FutureEither<void> deleteMovieLocal(DeleteMovieLocalParams params);

  ///
  FutureEither<bool> isFavoriteLocal(IsFavoriteLocalParams params);

  ///
  Stream<List<Movie>> favoriteMoviesStateChanges();
}

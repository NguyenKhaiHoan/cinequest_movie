import 'package:cinequest/src/common/constants/app_keys.dart';
import 'package:cinequest/src/core/errors/exceptions/data_local_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/external/services/storage/local/sqlite_service.dart';
import 'package:cinequest/src/features/movie/data/data_sources/_mapper/movie_mapper.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/delete_movie_local_params.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/is_favorite_local_params.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/save_movie_local_params.dart';

/// Sử dụng GetStorageService, Shared Preferences, Hive, Sqlite, ...
abstract class MovieLocalDataSource {
  ///
  Future<List<Movie>> saveMovieLocal(SaveMovieLocalParams params);

  ///
  Future<List<Movie>> getMoviesLocal();

  ///
  Future<List<Movie>> deleteMovieLocal(DeleteMovieLocalParams params);

  ///
  Future<bool> isFavoriteLocal(IsFavoriteLocalParams params);
}

/// Implementation của MovieLocalDataSource sử dụng Sqlite
class MovieSqliteServiceDataSourceImpl implements MovieLocalDataSource {
  /// Constructor
  MovieSqliteServiceDataSourceImpl({required SqliteService sqliteService})
      : _sqliteService = sqliteService;

  final SqliteService _sqliteService;
  final _movieMapper = MovieMapper();

  @override
  Future<List<Movie>> saveMovieLocal(SaveMovieLocalParams params) async {
    try {
      final movie = params.movie;
      final object = _movieMapper.entityToObject(movie);
      await _sqliteService.insertData(
        favouriteMoviesTableKey,
        object,
      );
      final movies = await getMoviesLocal();
      return movies;
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException(e).message,
      );
    }
  }

  @override
  Future<List<Movie>> getMoviesLocal() async {
    try {
      final data = await _sqliteService.queryData(favouriteMoviesTableKey);
      if (data.isNotEmpty) {
        return data.map(_movieMapper.objectToEntity).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException(e).message,
      );
    }
  }

  @override
  Future<List<Movie>> deleteMovieLocal(DeleteMovieLocalParams params) async {
    try {
      final movieId = params.movieId;
      await _sqliteService.deleteData(
        favouriteMoviesTableKey,
        'id = ?',
        [movieId],
      );
      final movies = await getMoviesLocal();
      return movies;
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException(e).message,
      );
    }
  }

  @override
  Future<bool> isFavoriteLocal(IsFavoriteLocalParams params) async {
    try {
      final movieId = params.movieId;
      final movies = await getMoviesLocal();
      return movies.any((movie) => movie.id == movieId);
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException(e).message,
      );
    }
  }
}

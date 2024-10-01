import 'package:cinequest/src/common/constants/app_keys.dart';
import 'package:cinequest/src/core/errors/exceptions/data_local_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/external/services/storage/local/sqlite_service.dart';
import 'package:cinequest/src/features/movie/data/data_sources/_mapper/movie_mapper.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/usecases/params/movie_params.dart';

/// Sử dụng GetStorageService, Shared Preferences, Hive, Sqlite, ...
abstract class MovieLocalDataSource {
  Future<void> saveMovieLocal(MovieParams params);
  Future<List<Movie>> getMoviesLocal();
  Future<void> deleteMovieLocal(MovieParams params);
}

/// Implementation của MovieLocalDataSource sử dụng Sqlite
class MovieSqliteServiceDataSourceImpl implements MovieLocalDataSource {
  /// Constructor
  MovieSqliteServiceDataSourceImpl({required SqliteService sqliteService})
      : _sqliteService = sqliteService;

  final SqliteService _sqliteService;
  final _movieMapper = MovieMapper();

  @override
  Future<void> saveMovieLocal(MovieParams params) async {
    try {
      final movie = params.movie;
      final object = _movieMapper.entityToObject(movie);
      await _sqliteService.insertData(
        favouriteMoviesTableKey,
        object,
      );
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException().message,
      );
    }
  }

  @override
  Future<List<Movie>> getMoviesLocal() async {
    try {
      final data = await _sqliteService.queryData(favouriteMoviesTableKey);
      return data.map(_movieMapper.objectToEntity).toList();
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException().message,
      );
    }
  }

  @override
  Future<void> deleteMovieLocal(MovieParams params) async {
    try {
      final movieId = params.movie.id;
      await _sqliteService.deleteData(
        favouriteMoviesTableKey,
        'id = ?',
        [movieId],
      );
    } catch (e) {
      throw Failure(
        message: DataLocalException.fromException().message,
      );
    }
  }
}

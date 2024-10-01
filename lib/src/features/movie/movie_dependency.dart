import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:cinequest/src/external/services/storage/local/sqlite_service.dart';
import 'package:cinequest/src/features/movie/data/data_sources/movie_local_data_source.dart';
import 'package:cinequest/src/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:cinequest/src/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';
import 'package:cinequest/src/features/movie/domain/usecases/delete_movie_local_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/get_movies_local_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/get_popular_movie_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/save_movie_local_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/stream_favorite_movie_usecase.dart';

class MovieDependency {
  MovieDependency._();

  static void init() {
    sl
      // Data Sources: registerLazySingleton
      ..registerLazySingleton<MovieRemoteDataSource>(
        () => MovieRemoteDataSourceImpl(tmdbApi: sl<TMDBApi>()),
      )
      ..registerLazySingleton<MovieLocalDataSource>(
        () => MovieSqliteServiceDataSourceImpl(
          sqliteService: sl<SqliteService>(),
        ),
      )

      // Repositories: registerLazySingleton
      ..registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
          movieRemoteDataSource: sl<MovieRemoteDataSource>(),
          movieLocalDataSource: sl<MovieLocalDataSource>(),
        ),
      )

      // Use Cases: registerLazySingleton
      ..registerLazySingleton<DeleteMovieLocalUseCase>(
        () => DeleteMovieLocalUseCase(sl<MovieRepository>()),
      )
      ..registerLazySingleton<GetMovieLocalUseCase>(
        () => GetMovieLocalUseCase(sl<MovieRepository>()),
      )
      ..registerLazySingleton<GetNowPlayingMoviesUseCase>(
        () => GetNowPlayingMoviesUseCase(sl<MovieRepository>()),
      )
      ..registerLazySingleton<GetPopularMoviesUseCase>(
        () => GetPopularMoviesUseCase(sl<MovieRepository>()),
      )
      ..registerLazySingleton<SaveMovieLocalUseCase>(
        () => SaveMovieLocalUseCase(sl<MovieRepository>()),
      )
      ..registerLazySingleton<StreamFavoriteMovieUsecase>(
        () => StreamFavoriteMovieUsecase(sl<MovieRepository>()),
      );
  }
}

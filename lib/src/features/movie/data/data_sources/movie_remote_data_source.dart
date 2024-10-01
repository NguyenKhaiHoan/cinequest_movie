import 'package:cinequest/src/core/env/env.dart';
import 'package:cinequest/src/core/errors/exceptions/no_internet_exception.dart';
import 'package:cinequest/src/core/errors/exceptions/tmdb_network_exception.dart';
import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/utils/connectivity_util.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:cinequest/src/features/movie/data/data_sources/_mapper/movie_mapper.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/usecases/params/get_movie_api_params.dart';
import 'package:dio/dio.dart';

/// Sử dụng TheMovieDb
abstract class MovieRemoteDataSource {
  Future<List<Movie>> getNowPlayingMovies(GetMoviesApiParams params);
  Future<List<Movie>> getPopularMovies(GetMoviesApiParams params);
}

/// Implementation của MovieRemoteDataSource
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  /// Constructor
  MovieRemoteDataSourceImpl({
    required TMDBApi tmdbApi,
  }) : _tmdbApi = tmdbApi;
  final TMDBApi _tmdbApi;

  final _movieMapper = MovieMapper();

  @override
  Future<List<Movie>> getNowPlayingMovies(GetMoviesApiParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final response = await _tmdbApi.getNowPlayingMovies(
          language: params.language,
          page: params.page,
          apiKey: Env.theMovieDbApiKey,
        );
        return (response.results ?? [])
            .map(_movieMapper.modelToEntity)
            .toList();
      } on DioException catch (e) {
        throw Failure(
          message: TMDBNetworkException.fromDioException(e).message,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }

  @override
  Future<List<Movie>> getPopularMovies(GetMoviesApiParams params) async {
    if (await ConnectivityUtil.checkConnectivity()) {
      try {
        final response = await _tmdbApi.getPopularMovies(
          language: params.language,
          page: params.page,
          apiKey: Env.theMovieDbApiKey,
        );
        return (response.results ?? [])
            .map(_movieMapper.modelToEntity)
            .toList();
      } on DioException catch (e) {
        throw Failure(
          message: TMDBNetworkException.fromDioException(e).message,
        );
      }
    } else {
      throw Failure(message: NoInternetException.fromException().message);
    }
  }
}

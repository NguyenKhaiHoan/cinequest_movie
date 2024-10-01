import 'dart:async';

import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/features/movie/data/data_sources/movie_local_data_source.dart';
import 'package:cinequest/src/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';
import 'package:cinequest/src/features/movie/domain/usecases/params/get_movie_api_params.dart';
import 'package:cinequest/src/features/movie/domain/usecases/params/movie_params.dart';
import 'package:dartz/dartz.dart';

/// Implementation của MovieRepository
class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl({
    required MovieRemoteDataSource movieRemoteDataSource,
    required MovieLocalDataSource movieLocalDataSource,
  })  : _movieRemoteDataSource = movieRemoteDataSource,
        _movieLocalDataSource = movieLocalDataSource;
  final MovieRemoteDataSource _movieRemoteDataSource;
  final MovieLocalDataSource _movieLocalDataSource;

  @override
  FutureEither<List<Movie>> getNowPlayingMovies(
    GetMoviesApiParams params,
  ) async {
    try {
      final result = await _movieRemoteDataSource.getNowPlayingMovies(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<List<Movie>> getPopularMovies(GetMoviesApiParams params) async {
    try {
      final result = await _movieRemoteDataSource.getPopularMovies(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> saveMovieLocal(MovieParams params) async {
    try {
      await _movieLocalDataSource.saveMovieLocal(params);
      _saveMovie(params.movies, params.movie);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<List<Movie>> getMoviesLocal() async {
    try {
      final result = await _movieLocalDataSource.getMoviesLocal();
      _setMovies(result);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<void> deleteMovieLocal(MovieParams params) async {
    try {
      await _movieLocalDataSource.deleteMovieLocal(params);
      _deleteMovie(params.movies, params.movie);
      return const Right(null);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  final StreamController<List<Movie>> _moviesController =
      StreamController<List<Movie>>.broadcast();
  @override
  Stream<List<Movie>> favoriteMovies() => _moviesController.stream;

  void _setMovies(List<Movie> movies) {
    // Tạo bản sao mutable trước khi thực hiện với list để tránh
    // lỗi: Cannot add to an unmodifiable list
    _moviesController.add(List.from(movies));
  }

  void _saveMovie(List<Movie>? movies, Movie movie) {
    // Tạo bản sao mutable trước khi thực hiện với list để tránh
    // lỗi: Cannot add to an unmodifiable list
    final newMovies = List<Movie>.from(movies ?? [])..add(movie);
    _setMovies(newMovies);
  }

  void _deleteMovie(List<Movie>? movies, Movie movie) {
    final movieId = movie.id;
    // Tạo bản sao mutable trước khi thực hiện với list để tránh
    // lỗi: Cannot add to an unmodifiable list
    final newMovies = List<Movie>.from(movies ?? [])
      ..removeWhere((m) => m.id == movieId);
    _setMovies(newMovies);
  }
}

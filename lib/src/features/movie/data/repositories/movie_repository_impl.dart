// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/movie_lists_params.dart';
import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/generics/type_def.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _movieRemoteDataSource;

  MovieRepositoryImpl({
    required MovieRemoteDataSource movieRemoteDataSource,
  }) : _movieRemoteDataSource = movieRemoteDataSource;

  @override
  FutureEither<List<Movie>> getNowPlayingMovies(MovieListsParams params) async {
    try {
      final result = await _movieRemoteDataSource.getNowPlayingMovies(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureEither<List<Movie>> getPopularMovies(MovieListsParams params) async {
    try {
      final result = await _movieRemoteDataSource.getPopularMovies(params);
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}

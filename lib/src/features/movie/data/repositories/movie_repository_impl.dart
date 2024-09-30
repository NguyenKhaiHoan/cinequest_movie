// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cinequest/src/core/errors/failure.dart';
// import 'package:cinequest/src/core/generics/type_def.dart';
// import 'package:cinequest/src/external/services/storage/cache/in_memory_store_service.dart';
// import 'package:cinequest/src/features/movie/data/data_sources/movie_api_network_data_source.dart';
// import 'package:cinequest/src/features/movie/data/data_sources/movie_local_data_source.dart';
// import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
// import 'package:cinequest/src/features/movie/domain/entities/params/delete_movie_local_params.dart';
// import 'package:cinequest/src/features/movie/domain/entities/params/is_favorite_local_params.dart';
// import 'package:cinequest/src/features/movie/domain/entities/params/movie_lists_params.dart';
// import 'package:cinequest/src/features/movie/domain/entities/params/save_movie_local_params.dart';
// import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';
// import 'package:dartz/dartz.dart';

// /// Implementation của MovieRepository
// class MovieRepositoryImpl implements MovieRepository {
//   final MovieApiNetworkDataSource _movieApiNetworkDataSource;
//   final MovieLocalDataSource _movieLocalDataSource;

//   MovieRepositoryImpl({
//     required MovieApiNetworkDataSource movieApiNetworkDataSource,
//     required MovieLocalDataSource movieLocalDataSource,
//   })  : _movieApiNetworkDataSource = movieApiNetworkDataSource,
//         _movieLocalDataSource = movieLocalDataSource;

//   @override
//   FutureEither<List<Movie>> getNowPlayingMovies(MovieListsParams params) async {
//     try {
//       final result =
//           await _movieApiNetworkDataSource.getNowPlayingMovies(params);
//       return Right(result);
//     } on Failure catch (e) {
//       return Left(e);
//     }
//   }

//   @override
//   FutureEither<List<Movie>> getPopularMovies(MovieListsParams params) async {
//     try {
//       final result = await _movieApiNetworkDataSource.getPopularMovies(params);
//       return Right(result);
//     } on Failure catch (e) {
//       return Left(e);
//     }
//   }

//   @override
//   FutureEither<void> saveMovieLocal(SaveMovieLocalParams params) async {
//     try {
//       final result = await _movieLocalDataSource.saveMovieLocal(params);
//       favoriteMovies = result;
//       return const Right(null);
//     } on Failure catch (e) {
//       return Left(e);
//     }
//   }

//   @override
//   FutureEither<List<Movie>> getMoviesLocal() async {
//     try {
//       final result = await _movieLocalDataSource.getMoviesLocal();
//       favoriteMovies = result;
//       return Right(result);
//     } on Failure catch (e) {
//       return Left(e);
//     }
//   }

//   @override
//   FutureEither<void> deleteMovieLocal(DeleteMovieLocalParams params) async {
//     try {
//       final result = await _movieLocalDataSource.deleteMovieLocal(params);
//       favoriteMovies = result;
//       return const Right(null);
//     } on Failure catch (e) {
//       return Left(e);
//     }
//   }

//   @override
//   FutureEither<bool> isFavoriteLocal(IsFavoriteLocalParams params) async {
//     try {
//       final result = await _movieLocalDataSource.isFavoriteLocal(params);
//       return Right(result);
//     } on Failure catch (e) {
//       return Left(e);
//     }
//   }

//   final _favoriteMoviesState = InMemoryStoreService<List<Movie>>([]);

//   @override
//   Stream<List<Movie>> favoriteMoviesStateChanges() =>
//       _favoriteMoviesState.stream;

// // Getter cho _favoriteMoviesState.value
//   List<Movie> get favoriteMovies => _favoriteMoviesState.value;

// // Setter cho _favoriteMoviesState.value
//   set favoriteMovies(List<Movie> movies) {
//     _favoriteMoviesState.value = movies;
//   }
// }

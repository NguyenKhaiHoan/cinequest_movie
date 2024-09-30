// import 'package:cinequest/src/core/env/env.dart';
// import 'package:cinequest/src/core/errors/exceptions/no_internet_exception.dart';
// import 'package:cinequest/src/core/errors/exceptions/tmdb_network_exception.dart';
// import 'package:cinequest/src/core/errors/failure.dart';
// import 'package:cinequest/src/core/utils/connectivity_util.dart';
// import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
// import 'package:cinequest/src/features/movie/data/data_sources/_mapper/movie_mapper.dart';
// import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
// import 'package:cinequest/src/features/movie/domain/entities/params/movie_lists_params.dart';
// import 'package:dio/dio.dart';

// /// Sử dụng TheMovieDb
// abstract class MovieApiNetworkDataSource {
//   Future<List<Movie>> getNowPlayingMovies(MovieListsParams params);

//   Future<List<Movie>> getPopularMovies(MovieListsParams params);
// }

// /// Implementation của MovieApiNetworkDataSource
// class MovieApiNetworkDataSourceImpl implements MovieApiNetworkDataSource {
//   /// Constructor
//   MovieApiNetworkDataSourceImpl({
//     required TMDBApi tmdbApi,
//   }) : _tmdbApi = tmdbApi;
//   final TMDBApi _tmdbApi;

//   final _movieMapper = MovieMapper();

//   @override
//   Future<List<Movie>> getNowPlayingMovies(MovieListsParams params) async {
//     if (await ConnectivityUtil.checkConnectivity()) {
//       try {
//         final response = await _tmdbApi.getNowPlayingMovies(
//           language: params.language,
//           page: params.page,
//           apiKey: Env.theMovieDbApiKey,
//         );
//         return (response.results ?? []).map(_movieMapper.).toList();
//       } on DioException catch (e) {
//         throw Failure(
//           message: TMDBNetworkException.fromDioException(e).message,
//         );
//       }
//     } else {
//       throw Failure(message: NoInternetException.fromException().message);
//     }
//   }

//   @override
//   Future<List<Movie>> getPopularMovies(MovieListsParams params) async {
//     if (await ConnectivityUtil.checkConnectivity()) {
//       try {
//         final response = await _tmdbApi.getPopularMovies(
//           language: params.language,
//           page: params.page,
//           apiKey: Env.theMovieDbApiKey,
//         );
//         return (response.results ?? []).map(_movieMapper.).toList();
//       } on DioException catch (e) {
//         throw Failure(
//           message: TMDBNetworkException.fromDioException(e).message,
//         );
//       }
//     } else {
//       throw Failure(message: NoInternetException.fromException().message);
//     }
//   }
// }

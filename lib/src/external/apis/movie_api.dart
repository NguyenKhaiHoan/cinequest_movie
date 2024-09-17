// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';

// import 'app_api.dart';

// part 'movie_api_service.g.dart';

// @RestApi(baseUrl: AppAPI.movieBaseUrl)
// abstract class MovieApi {
//   factory MovieApi(Dio dio) = _MovieApi;

//   @GET('/movie/now_playing')
//   Future<HttpResponse<MoviesResponse>> getNowPlayingMovies({
//     @Query('api_key') required String apiKey,
//     @Query('language') required String language,
//     @Query('page') required int page,
//   });

//   @GET('/movie/popular')
//   Future<HttpResponse<MoviesResponse>> getPopularMovies({
//     @Query('api_key') required String apiKey,
//     @Query('language') required String language,
//     @Query('page') required int page,
//   });

//   @GET('/movie/top_rated')
//   Future<HttpResponse<MoviesResponse>> getTopRatedMovies({
//     @Query('api_key') required String apiKey,
//     @Query('language') required String language,
//     @Query('page') required int page,
//   });

//   @GET('/movie/upcoming')
//   Future<HttpResponse<MoviesResponse>> getUpcomingMovies({
//     @Query('api_key') required String apiKey,
//     @Query('language') required String language,
//     @Query('page') required int page,
//   });

//   @GET('/movie/{movie_id}/similar')
//   Future<HttpResponse<MoviesResponse>> getSimilarMovies(
//       {@Path('movie_id') required int movieId,
//       @Query('api_key') required String apiKey,
//       @Query('language') required String language,
//       @Query('page') required int page});

//   @GET('/movie/{movie_id}')
//   Future<HttpResponse<MovieDetail>> getDetailMovie(
//       {@Path('movie_id') required int movieId,
//       @Query('api_key') required String apiKey,
//       @Query('language') required String language});

//   @GET('/movie/{movie_id}/credits')
//   Future<HttpResponse<CreditResponse>> getCreditsMovie(
//       {@Path('movie_id') required int movieId,
//       @Query('api_key') required String apiKey,
//       @Query('language') required String language});

//   @GET('/movie/{movie_id}/videos')
//   Future<HttpResponse<VideosResponse>> getVideosMovie(
//       {@Path('movie_id') required int movieId,
//       @Query('api_key') required String apiKey,
//       @Query('language') required String language});

//   @GET('/person/{person_id}/images')
//   Future<HttpResponse<ImagesPersonResponse>> getImagesPerson({
//     @Path('person_id') required int personId,
//     @Query('api_key') required String apiKey,
//   });

//   @GET('/person/{person_id}/movie_credits')
//   Future<HttpResponse<MovieCreditsPersonResponse>> getMovieCreditsPerson(
//       {@Path('person_id') required int personId,
//       @Query('api_key') required String apiKey,
//       @Query('language') required String language});

//   @GET('/person/{person_id}')
//   Future<HttpResponse<PersonDetail>> getDetailPerson(
//       {@Path('person_id') required int personId,
//       @Query('api_key') required String apiKey,
//       @Query('language') required String language});

//   @GET('/search/movie')
//   Future<HttpResponse<SearchMovieResponse>> searchMovie({
//     @Query('api_key') required String apiKey,
//     @Query('query') required String query,
//     @Query('include_adult') required bool includeAdult,
//     @Query('language') required String language,
//     @Query('primary_release_year') String? primaryReleaseYear,
//     @Query('page') required int page,
//     @Query('region') String? region,
//     @Query('year') String? year,
//   });

//   @GET('/search/person')
//   Future<HttpResponse<SearchPersonResponse>> searchPerson({
//     @Query('api_key') required String apiKey,
//     @Query('query') required String query,
//     @Query('include_adult') required bool includeAdult,
//     @Query('language') required String language,
//     @Query('page') required int page,
//   });
// }

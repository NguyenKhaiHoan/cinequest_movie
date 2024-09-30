/// Params của các use case GetNowPlayingMovie, GetPopularMovie, ...
class MovieListsParams {
  /// Constructor
  MovieListsParams({
    this.page = 1,
    this.language = 'en',
  });

  final int page;

  final String language;
}

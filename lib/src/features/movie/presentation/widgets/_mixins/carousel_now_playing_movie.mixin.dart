part of '../carousel_now_playing_movie.dart';

/// Mixin của CarouselNowPlayingMovie xử lý logic UI
mixin CarouselNowPlayingMovieMixin on State<CarouselNowPlayingMovie> {
  void _toggleFavorite(
    BuildContext context,
    List<Movie> favoriteMovies,
    Movie movie,
    bool isFavorite,
  ) {
    if (isFavorite) {
      context.read<ButtonBloc>().add(
            ButtonEvent.execute(
              useCase: sl<DeleteMovieLocalUseCase>(),
              params: MovieParams(
                movie: movie,
                movies: favoriteMovies,
              ),
            ),
          );
    } else {
      context.read<ButtonBloc>().add(
            ButtonEvent.execute(
              useCase: sl<SaveMovieLocalUseCase>(),
              params: MovieParams(movie: movie, movies: favoriteMovies),
            ),
          );
    }
  }

  void _listener(
    BuildContext context,
    ButtonState state,
  ) {
    state.whenOrNull(
      failure: (failure) => context.showSnackbar(context, failure.message),
    );
  }
}

part of '../carousel_now_playing_movie.dart';

/// Mixin của CarouselNowPlayingMovie xử lý logic UI
mixin CarouselNowPlayingMovieMixin on State<CarouselNowPlayingMovie> {
  void _saveMovieLocal(BuildContext context, Movie movie) {
    context.read<ButtonBloc>().add(
          ButtonEvent.execute(
            useCase: sl<SaveMovieLocalUseCase>(),
            params: SaveMovieLocalParams(
              movie: movie,
            ),
          ),
        );
  }

  void _listener(
    BuildContext context,
    ButtonState state,
    bool isFavorite,
  ) {
    state.whenOrNull(
      failure: (failure) => context.showSnackbar(context, failure.message),
      success: () => context
          .read<MovieLocalBloc>()
          .add(MovieLocalEvent.toggleFavorite(isFavorite: isFavorite)),
    );
  }
}

part of '../carousel_now_playing_movie.dart';

/// Mixin của CarouselNowPlayingMovie xử lý logic UI
mixin CarouselNowPlayingMovieMixin on State<CarouselNowPlayingMovie> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<GetMovieLocalUseCase>().call();
    });
  }

  void _toggleFavorite(BuildContext context, Movie movie, bool isFavorite) {
    if (isFavorite) {
      context.read<ButtonBloc>().add(
            ButtonEvent.execute(
              useCase: sl<DeleteMovieLocalUseCase>(),
              params: DeleteMovieLocalParams(
                movieId: movie.id!,
              ),
            ),
          );
    } else {
      context.read<ButtonBloc>().add(
            ButtonEvent.execute(
              useCase: sl<SaveMovieLocalUseCase>(),
              params: SaveMovieLocalParams(
                movie: movie,
              ),
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

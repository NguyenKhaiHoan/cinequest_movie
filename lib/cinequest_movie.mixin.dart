part of 'cinequest_movie.dart';

mixin CineQuestMovieMixin on State<CineQuestMovie> {
  void _listenerConnectivity(BuildContext context, ConnectivityState state) {
    state.whenOrNull(
        failure: () =>
            context.showSnackbar(NoInternetException.fromException().message));
  }

  void _listenerAppAuth(BuildContext context, AppAuthState state) {
    state.whenOrNull(
      unAuthenticated: (failure) {
        if (failure != null) {
          context.showSnackbar(failure.message);
        }
      },
    );
  }
}

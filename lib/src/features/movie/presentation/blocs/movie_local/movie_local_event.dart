part of 'movie_local_bloc.dart';

/// Các sự kiện
@freezed
class MovieLocalEvent with _$MovieLocalEvent {
  /// Sự kiện bật tắt yêu thích phim
  const factory MovieLocalEvent.toggleFavorite({required bool isFavorite}) =
      EventToggleFavoriteLocal;
}

part of 'movie_local_bloc.dart';

/// Trạng thái
@freezed
class MovieLocalState with _$MovieLocalState {
  /// Trạng thái
  const factory MovieLocalState({
    required bool isFavorite,
  }) = _MovieLocalState;

  /// Trang thái ban đầu
  factory MovieLocalState.initial() => const MovieLocalState(
        isFavorite: false,
      );
}

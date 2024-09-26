part of 'now_playing_movie_bloc.dart';

/// Các sự kiện
@freezed
class NowPlayingMovieState with _$NowPlayingMovieState {
  /// Trạng thái đang tải
  const factory NowPlayingMovieState.loading() = InitialNowPlayingMovieState;

  /// Trạng thái thành công
  const factory NowPlayingMovieState.success({required List<Movie> movies}) =
      SuccessNowPlayingMovieState;

  /// Trạng thái lỗi
  const factory NowPlayingMovieState.failure({required Failure failure}) =
      FailureNowPlayingMovieState;
}

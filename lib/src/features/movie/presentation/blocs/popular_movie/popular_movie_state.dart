part of 'popular_movie_bloc.dart';

/// Các tạng thái
@freezed
class PopularMovieState with _$PopularMovieState {
  /// Trạng thái đang tải
  const factory PopularMovieState.loading() = InitialPopularMovieState;

  /// Trạng thái thành công
  const factory PopularMovieState.success({required List<Movie> movies}) =
      SuccessPopularMovieState;

  /// Trạng thái lỗi
  const factory PopularMovieState.failure({required Failure failure}) =
      FailurePopularMovieState;
}

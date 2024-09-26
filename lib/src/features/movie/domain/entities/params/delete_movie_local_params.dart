import 'package:equatable/equatable.dart';

/// Params của DeleteMovieLocalUseCase
class DeleteMovieLocalParams extends Equatable {
  /// Constructor
  const DeleteMovieLocalParams({
    required this.movieId,
  });

  ///
  final int movieId;

  @override
  List<Object?> get props => [movieId];
}

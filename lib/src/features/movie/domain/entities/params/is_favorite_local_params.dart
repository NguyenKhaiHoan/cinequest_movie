import 'package:equatable/equatable.dart';

/// Params của DeleteMovieLocalUseCase
class IsFavoriteLocalParams extends Equatable {
  /// Constructor
  const IsFavoriteLocalParams({
    required this.movieId,
  });

  final int movieId;

  @override
  List<Object?> get props => [movieId];
}

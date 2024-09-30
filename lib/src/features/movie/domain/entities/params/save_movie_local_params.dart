import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

/// Params của SaveMovieLocalUseCase
class SaveMovieLocalParams extends Equatable {
  /// Constructor
  const SaveMovieLocalParams({
    required this.movie,
  });

  final Movie movie;

  @override
  List<Object?> get props => [movie];
}

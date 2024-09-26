import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/save_movie_local_params.dart';
import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';

/// Use case lưu movie vào local database
class SaveMovieLocalUseCase extends UseCase<void, SaveMovieLocalParams> {
  /// Constructor
  SaveMovieLocalUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<void> call({SaveMovieLocalParams? params}) {
    return _movieRepository.saveMovieLocal(params!);
  }
}

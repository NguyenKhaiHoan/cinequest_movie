import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/delete_movie_local_params.dart';
import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';

/// Use case xóa movie trong local database
class DeleteMovieLocalUseCase extends UseCase<void, DeleteMovieLocalParams> {
  /// Constructor
  DeleteMovieLocalUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<void> call({DeleteMovieLocalParams? params}) {
    return _movieRepository.deleteMovieLocal(params!);
  }
}

import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/is_favorite_local_params.dart';
import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';

/// Use case xem movie có trong favorite movie hay không
class IsFavoriteLocalUseCase extends UseCase<bool, IsFavoriteLocalParams> {
  /// Constructor
  IsFavoriteLocalUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<bool> call({IsFavoriteLocalParams? params}) {
    return _movieRepository.isFavoriteLocal(params!);
  }
}

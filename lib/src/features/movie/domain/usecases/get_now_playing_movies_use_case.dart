import 'package:cinequest/src/core/generics/type_def.dart';
import 'package:cinequest/src/core/generics/usecase.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/entities/params/movie_lists_params.dart';
import 'package:cinequest/src/features/movie/domain/repositories/movie_repository.dart';

/// Use case lấy dữ liệu danh sách movie đang được công chiếu
class GetNowPlayingMoviesUseCase
    extends UseCase<List<Movie>, MovieListsParams> {
  /// Constructor
  GetNowPlayingMoviesUseCase(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  FutureEither<List<Movie>> call({MovieListsParams? params}) {
    return _movieRepository.getNowPlayingMovies(params!);
  }
}

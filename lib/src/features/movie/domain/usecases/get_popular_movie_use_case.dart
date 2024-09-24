import '../../../../core/generics/type_def.dart';
import '../../../../core/generics/usecase.dart';
import '../entities/movie.dart';
import '../entities/params/movie_lists_params.dart';
import '../repositories/movie_repository.dart';

class GetPopularMoviesUseCase
    implements UseCase<List<Movie>, MovieListsParams> {
  final MovieRepository _movieRepository;

  GetPopularMoviesUseCase(this._movieRepository);

  @override
  FutureEither<List<Movie>> call({MovieListsParams? params}) {
    return _movieRepository.getPopularMovies(params!);
  }
}

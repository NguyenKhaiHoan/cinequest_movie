import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/usecases/get_popular_movie_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/params/get_movie_api_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'popular_movie_bloc.freezed.dart';
part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

/// Quản lý trạng thái lấy dữ liệu danh sách movie phổ biến
class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  /// Constructor
  PopularMovieBloc(this._useCase) : super(const PopularMovieState.loading()) {
    on<PopularMovieEvent>((events, emit) async {
      await events.map(get: (event) => _onGet(event, emit));
    });
  }

  final GetPopularMoviesUseCase _useCase;

  Future<void> _onGet(
    EventGetPopularMovie event,
    Emitter<PopularMovieState> emit,
  ) async {
    final result = await _useCase.call(params: GetMoviesApiParams());

    result.fold((failure) {
      emit(PopularMovieState.failure(failure: failure));
    }, (data) {
      emit(PopularMovieState.success(movies: data));
    });
  }
}

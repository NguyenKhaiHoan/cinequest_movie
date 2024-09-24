import 'package:cinequest/src/features/movie/domain/entities/params/movie_lists_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movie_use_case.dart';

part 'popular_movie_bloc.freezed.dart';
part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  PopularMovieBloc(this._useCase) : super(const PopularMovieState.loading()) {
    on<PopularMovieEvent>((events, emit) async {
      await events.map(get: (event) => _onGet(event, emit));
    });
  }

  final GetPopularMoviesUseCase _useCase;

  Future<void> _onGet(
      EventGetPopularMovie event, Emitter<PopularMovieState> emit) async {
    final result = await _useCase.call(params: MovieListsParams());

    result.fold((failure) {
      emit(PopularMovieState.failure(failure: failure));
    }, (data) {
      emit(PopularMovieState.success(movies: data));
    });
  }
}

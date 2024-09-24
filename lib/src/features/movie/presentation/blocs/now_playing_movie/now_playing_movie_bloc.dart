import 'package:cinequest/src/features/movie/domain/entities/params/movie_lists_params.dart';
import 'package:cinequest/src/features/movie/domain/usecases/get_now_playing_movies_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/movie.dart';

part 'now_playing_movie_bloc.freezed.dart';
part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  NowPlayingMovieBloc(this._useCase)
      : super(const NowPlayingMovieState.loading()) {
    on<NowPlayingMovieEvent>((events, emit) async {
      await events.map(get: (event) => _onGet(event, emit));
    });
  }

  final GetNowPlayingMoviesUseCase _useCase;

  Future<void> _onGet(
      EventGetNowPlayingMovie event, Emitter<NowPlayingMovieState> emit) async {
    final result = await _useCase.call(params: MovieListsParams());

    result.fold((failure) {
      emit(NowPlayingMovieState.failure(failure: failure));
    }, (data) {
      emit(NowPlayingMovieState.success(movies: data));
    });
  }
}

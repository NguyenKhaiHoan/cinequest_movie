import 'package:cinequest/src/core/errors/failure.dart';
import 'package:cinequest/src/features/movie/domain/entities/movie.dart';
import 'package:cinequest/src/features/movie/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:cinequest/src/features/movie/domain/usecases/params/get_movie_api_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'now_playing_movie_bloc.freezed.dart';
part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

/// Quản lý trạng thái lấy dữ liệu danh sách movie đang được công chiểu
class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  /// Constructor
  NowPlayingMovieBloc(this._useCase)
      : super(const NowPlayingMovieState.loading()) {
    on<NowPlayingMovieEvent>((events, emit) async {
      await events.map(get: (event) => _onGet(event, emit));
    });
  }

  final GetNowPlayingMoviesUseCase _useCase;

  Future<void> _onGet(
    EventGetNowPlayingMovie event,
    Emitter<NowPlayingMovieState> emit,
  ) async {
    final result = await _useCase.call(params: GetMoviesApiParams());

    result.fold((failure) {
      emit(NowPlayingMovieState.failure(failure: failure));
    }, (data) {
      emit(NowPlayingMovieState.success(movies: data));
    });
  }
}

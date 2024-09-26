import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_local_bloc.freezed.dart';
part 'movie_local_event.dart';
part 'movie_local_state.dart';

/// Quản lý trạng thái movie trong local database
class MovieLocalBloc extends Bloc<MovieLocalEvent, MovieLocalState> {
  /// Constructor
  MovieLocalBloc() : super(MovieLocalState.initial()) {
    on<MovieLocalEvent>((events, emit) async {
      await events.map(
        toggleFavorite: (event) => _onToggleFavorite(event, emit),
      );
    });
  }

  Future<void> _onToggleFavorite(
    EventToggleFavoriteLocal event,
    Emitter<MovieLocalState> emit,
  ) async {
    emit(state.copyWith(isFavorite: !event.isFavorite));
  }
}

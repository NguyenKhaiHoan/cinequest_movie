import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';
part 'bottom_nav_bloc.freezed.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState.initial()) {
    on<BottomNavEvent>((events, emit) {
      events.map(
        selectedIndex: (event) => onSelectedIndex(emit, event),
      );
    });
  }

  void onSelectedIndex(
          Emitter<BottomNavState> emit, EventBottomNavIndexSelected event) =>
      emit(BottomNavState(currentIndex: event.index));
}

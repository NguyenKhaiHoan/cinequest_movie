import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';
part 'bottom_nav_bloc.freezed.dart';

/// Quản lý trạng thái điều hướng của trang dành cho điều hướng
class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  /// Constructor
  BottomNavBloc() : super(BottomNavState.initial()) {
    on<BottomNavEvent>((events, emit) {
      events.map(
        selectedIndex: (event) => _onSelectedIndex(emit, event),
      );
    });
  }

  void _onSelectedIndex(
    Emitter<BottomNavState> emit,
    EventBottomNavIndexSelected event,
  ) =>
      emit(BottomNavState(currentIndex: event.index));
}

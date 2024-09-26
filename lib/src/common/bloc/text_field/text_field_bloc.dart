import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_field_event.dart';
part 'text_field_state.dart';
part 'text_field_bloc.freezed.dart';

/// Quản lý trạng thái của TextField
class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  /// Constructor
  TextFieldBloc() : super(const TextFieldState.obscure()) {
    on<TextFieldEvent>((events, emit) async {
      events.map(
        toggleVisibility: (event) => _onToggleVisibility(event, emit),
      );
    });
  }

  void _onToggleVisibility(
    EventTextFieldToggleVisibility event,
    Emitter<TextFieldState> emit,
  ) {
    emit(TextFieldState.obscure(obscure: !state.obscure));
  }
}

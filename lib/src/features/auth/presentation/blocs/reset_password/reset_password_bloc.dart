import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';
part 'reset_password_bloc.freezed.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordState.initial()) {
    on<ResetPasswordEvent>((events, emit) async {
      events.map(
        emailChanged: (event) => _onEmailChanged(event, emit),
      );
    });
  }

  void _onEmailChanged(
      EventResetPasswordEmailChanged event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(
      email: event.email,
      isFormValid: _isFormValid(event.email),
    ));
  }

  bool _isFormValid(String email) {
    return email.isNotEmpty;
  }
}

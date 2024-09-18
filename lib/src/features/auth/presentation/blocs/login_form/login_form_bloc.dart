import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';
part 'login_form_bloc.freezed.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormState.initial()) {
    on<LoginFormEvent>((events, emit) async {
      events.map(
        emailChanged: (event) => _onEmailChanged(event, emit),
        setPasswordChanged: (event) => _onSetPasswordChanged(event, emit),
      );
    });
  }

  void _onEmailChanged(
      EventLoginFormEmailChanged event, Emitter<LoginFormState> emit) {
    emit(state.copyWith(
      email: event.email,
      isFormValid: _isFormValid(event.email, state.password),
    ));
  }

  void _onSetPasswordChanged(
      EventLoginFormSetPasswordChanged event, Emitter<LoginFormState> emit) {
    emit(state.copyWith(
      password: event.password,
      isFormValid: _isFormValid(state.email, event.password),
    ));
  }

  bool _isFormValid(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }
}

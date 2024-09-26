import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

/// Quản lý trạng thái của LoginPage
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// Constructor
  LoginBloc() : super(LoginState.initial()) {
    on<LoginEvent>((events, emit) async {
      events.map(
        emailChanged: (event) => _onEmailChanged(event, emit),
        setPasswordChanged: (event) => _onSetPasswordChanged(event, emit),
      );
    });
  }

  void _onEmailChanged(EventLoginEmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
        isFormValid: _isFormValid(event.email, state.password),
      ),
    );
  }

  void _onSetPasswordChanged(
    EventLoginSetPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        isFormValid: _isFormValid(state.email, event.password),
      ),
    );
  }

  bool _isFormValid(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }
}

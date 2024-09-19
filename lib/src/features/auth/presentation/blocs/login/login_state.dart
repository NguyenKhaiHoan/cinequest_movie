part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String email,
    required String password,
    required bool isFormValid,
  }) = _LoginState;

  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
        isFormValid: false,
      );
}

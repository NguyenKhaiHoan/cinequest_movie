part of 'login_bloc.dart';

/// Trạng thái
@freezed
class LoginState with _$LoginState {
  /// Trạng thái
  const factory LoginState({
    required String email,
    required String password,
    required bool isFormValided,
  }) = _LoginState;

  /// Trạng thái ban đầu
  factory LoginState.initial() => const LoginState(
        email: '',
        password: '',
        isFormValided: false,
      );
}

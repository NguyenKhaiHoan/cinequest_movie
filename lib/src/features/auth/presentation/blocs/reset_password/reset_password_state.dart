part of 'reset_password_bloc.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({
    required String email,
    required bool isFormValid,
  }) = _ResetPasswordState;

  factory ResetPasswordState.initial() => const ResetPasswordState(
        email: '',
        isFormValid: false,
      );
}

part of 'reset_password_bloc.dart';

/// Trạng thái
@freezed
class ResetPasswordState with _$ResetPasswordState {
  /// Trạng thái
  const factory ResetPasswordState({
    required String email,
    required bool isFormValid,
  }) = _ResetPasswordState;

  /// Trạng thái ban đầu
  factory ResetPasswordState.initial() => const ResetPasswordState(
        email: '',
        isFormValid: false,
      );
}

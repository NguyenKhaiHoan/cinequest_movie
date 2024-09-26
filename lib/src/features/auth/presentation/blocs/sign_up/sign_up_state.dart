part of 'sign_up_bloc.dart';

/// Trạng thái
@freezed
class SignUpState with _$SignUpState {
  /// Trạng thái
  const factory SignUpState({
    required String email,
    required String password,
    required String confirmPassword,
    required String verificationCode,
    required bool isSignUpFormValid,
    required bool isVerificationCodeFormValid,
  }) = _SignUpState;

  /// Trạng thái ban đầu
  factory SignUpState.initial() => const SignUpState(
        email: '',
        password: '',
        confirmPassword: '',
        verificationCode: '',
        isSignUpFormValid: false,
        isVerificationCodeFormValid: true,
      );
}

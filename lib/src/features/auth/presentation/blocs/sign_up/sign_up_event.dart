part of 'sign_up_bloc.dart';

/// Các sự kiện
@freezed
class SignUpEvent with _$SignUpEvent {
  /// Sự kiện thay đổi email
  const factory SignUpEvent.emailChanged(String email) =
      EventSignUpEmailChanged;

  /// Sự kiện thay đổi password
  const factory SignUpEvent.setPasswordChanged(String password) =
      EventSignUpSetPasswordChanged;

  /// Sự kiện thay đổi confirm password
  const factory SignUpEvent.confirmPasswordChanged(String confirmPassword) =
      EventSignUpConfirmPasswordChanged;

  /// Sự kiện thay đổi vefication code
  const factory SignUpEvent.verificationCodeChanged(String verificationCode) =
      EventSignUpVerificationCodeChanged;
}

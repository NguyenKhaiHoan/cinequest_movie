part of 'sign_up_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.emailChanged(String email) =
      EventSignUpEmailChanged;
  const factory SignUpEvent.setPasswordChanged(String password) =
      EventSignUpSetPasswordChanged;
  const factory SignUpEvent.confirmPasswordChanged(String confirmPassword) =
      EventSignUpConfirmPasswordChanged;
  const factory SignUpEvent.verificationCodeChanged(String verificationCode) =
      EventSignUpVerificationCodeChanged;
}

part of 'sign_up_form_bloc.dart';

@freezed
class SignUpFormEvent with _$SignUpFormEvent {
  const factory SignUpFormEvent.emailChanged(String email) =
      EventSignUpFormEmailChanged;
  const factory SignUpFormEvent.setPasswordChanged(String password) =
      EventSignUpFormSetPasswordChanged;
  const factory SignUpFormEvent.confirmPasswordChanged(String confirmPassword) =
      EventSignUpFormConfirmPasswordChanged;
}

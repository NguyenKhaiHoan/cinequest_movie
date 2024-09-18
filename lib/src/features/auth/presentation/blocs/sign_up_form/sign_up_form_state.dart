part of 'sign_up_form_bloc.dart';

@freezed
class SignUpFormState with _$SignUpFormState {
  const factory SignUpFormState({
    required String email,
    required String password,
    required String confirmPassword,
    required bool isFormValid,
  }) = _SignUpFormState;

  factory SignUpFormState.initial() => const SignUpFormState(
        email: '',
        password: '',
        confirmPassword: '',
        isFormValid: false,
      );
}

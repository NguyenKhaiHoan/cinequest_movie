part of 'verification_code_form_bloc.dart';

@freezed
class VerificationCodeFormState with _$VerificationCodeFormState {
  const factory VerificationCodeFormState({
    required String verificationCode,
    required bool isFormValid,
  }) = _VerificationCodeFormState;

  factory VerificationCodeFormState.initial() =>
      const VerificationCodeFormState(
        verificationCode: '',
        isFormValid: true,
      );
}

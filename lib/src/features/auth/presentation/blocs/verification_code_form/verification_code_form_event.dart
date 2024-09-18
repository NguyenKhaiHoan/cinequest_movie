part of 'verification_code_form_bloc.dart';

@freezed
class VerificationCodeFormEvent with _$VerificationCodeFormEvent {
  const factory VerificationCodeFormEvent.verificationCodeChanged(
      String verificationCode) = EventVerificationCodeChanged;
}

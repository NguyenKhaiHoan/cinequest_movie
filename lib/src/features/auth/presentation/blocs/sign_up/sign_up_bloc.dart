import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
part 'sign_up_bloc.freezed.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState.initial()) {
    on<SignUpEvent>((events, emit) async {
      events.map(
          emailChanged: (event) => _onEmailChanged(event, emit),
          setPasswordChanged: (event) => _onSetPasswordChanged(event, emit),
          confirmPasswordChanged: (event) =>
              _onConfirmPasswordChanged(event, emit),
          verificationCodeChanged: (event) =>
              _onVerificationCodeChanged(event, emit));
    });
  }

  void _onEmailChanged(
      EventSignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      email: event.email,
      isSignUpFormValid: _isSignUpFormValid(
          event.email, state.password, state.confirmPassword),
    ));
  }

  void _onSetPasswordChanged(
      EventSignUpSetPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      password: event.password,
      isSignUpFormValid: _isSignUpFormValid(
          state.email, event.password, state.confirmPassword),
    ));
  }

  void _onConfirmPasswordChanged(
      EventSignUpConfirmPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      isSignUpFormValid: _isSignUpFormValid(
          state.email, state.password, event.confirmPassword),
    ));
  }

  void _onVerificationCodeChanged(
      EventSignUpVerificationCodeChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(
      verificationCode: event.verificationCode,
      isVerificationCodeFormValid:
          _isVerificationCodeFormValid(event.verificationCode),
    ));
  }

  bool _isSignUpFormValid(
      String email, String password, String confirmPassword) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }

  bool _isVerificationCodeFormValid(String verificationCode) {
    return verificationCode.isNotEmpty;
  }
}

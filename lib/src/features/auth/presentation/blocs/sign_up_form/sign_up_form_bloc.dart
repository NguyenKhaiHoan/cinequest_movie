import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';
part 'sign_up_form_bloc.freezed.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc() : super(SignUpFormState.initial()) {
    on<SignUpFormEvent>((events, emit) async {
      events.map(
        emailChanged: (event) => _onEmailChanged(event, emit),
        setPasswordChanged: (event) => _onSetPasswordChanged(event, emit),
        confirmPasswordChanged: (event) =>
            _onConfirmPasswordChanged(event, emit),
      );
    });
  }

  void _onEmailChanged(
      EventSignUpFormEmailChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      email: event.email,
      isFormValid:
          _isFormValid(event.email, state.password, state.confirmPassword),
    ));
  }

  void _onSetPasswordChanged(
      EventSignUpFormSetPasswordChanged event, Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      password: event.password,
      isFormValid:
          _isFormValid(state.email, event.password, state.confirmPassword),
    ));
  }

  void _onConfirmPasswordChanged(EventSignUpFormConfirmPasswordChanged event,
      Emitter<SignUpFormState> emit) {
    emit(state.copyWith(
      confirmPassword: event.confirmPassword,
      isFormValid:
          _isFormValid(state.email, state.password, event.confirmPassword),
    ));
  }

  bool _isFormValid(String email, String password, String confirmPassword) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }
}

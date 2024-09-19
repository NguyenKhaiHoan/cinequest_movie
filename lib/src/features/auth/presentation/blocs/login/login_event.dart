part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.emailChanged(String email) = EventLoginEmailChanged;
  const factory LoginEvent.setPasswordChanged(String password) =
      EventLoginSetPasswordChanged;
}

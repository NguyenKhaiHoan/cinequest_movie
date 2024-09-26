part of 'login_bloc.dart';

/// Các sự kiện
@freezed
class LoginEvent with _$LoginEvent {
  /// Sự kiện thay đổi email
  const factory LoginEvent.emailChanged(String email) = EventLoginEmailChanged;

  /// Sự kiện thay đổi password
  const factory LoginEvent.setPasswordChanged(String password) =
      EventLoginSetPasswordChanged;
}

part of 'login_bloc.dart';

/// Các sự kiện
@freezed
class LoginEvent with _$LoginEvent {
  /// Sự kiện thay đổi email
  const factory LoginEvent.emailChanged({required String email}) =
      _LoginEmailChangedEvent;

  /// Sự kiện thay đổi password
  const factory LoginEvent.setPasswordChanged({required String password}) =
      _LoginSetPasswordChangedEvent;
}

part of 'reset_password_bloc.dart';

/// Các sự kiện
@freezed
class ResetPasswordEvent with _$ResetPasswordEvent {
  /// Sự kiện thay đổi email
  const factory ResetPasswordEvent.emailChanged({required String email}) =
      _ResetPasswordEmailChangedEvent;
}

part of 'account_setup_bloc.dart';

/// Các sự kiến
@freezed
class AccountSetupEvent with _$AccountSetupEvent {
  /// Sự kiện thay đổi page
  const factory AccountSetupEvent.pageChanged({required int index}) =
      _AccountSetupPageChangedEvent;

  /// Sự kiện thay đổi username
  const factory AccountSetupEvent.usernameChanged({required String username}) =
      _AccountSetupUsenameChangedEvent;

  /// Sự kiện thay đổi name
  const factory AccountSetupEvent.nameChanged({required String name}) =
      _AccountSetupNameChangedEvent;

  /// Sự kiện thay đổi surname
  const factory AccountSetupEvent.surnameChanged({required String surname}) =
      _AccountSetupSurnameChangedEvent;

  /// Sự kiện thay đổi bioname
  const factory AccountSetupEvent.bioChanged({required String bio}) =
      _AccountSetupBioChangedEvent;

  /// Sự kiện thay đổi profile photo
  const factory AccountSetupEvent.profilePhotoChanged({
    required File? profilePhoto,
  }) = _AccountSetupProfilePhotoChangedEvent;
}

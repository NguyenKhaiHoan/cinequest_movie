part of 'account_setup_bloc.dart';

/// Các sự kiến
@freezed
class AccountSetupEvent with _$AccountSetupEvent {
  /// Sự kiện thay đổi page
  const factory AccountSetupEvent.pageChanged(int index) =
      EventAccountSetupPageChanged;

  /// Sự kiện thay đổi username
  const factory AccountSetupEvent.usernameChanged(String username) =
      EventAccountSetupUsenameChanged;

  /// Sự kiện thay đổi name
  const factory AccountSetupEvent.nameChanged(String name) =
      EventAccountSetupNameChanged;

  /// Sự kiện thay đổi surname
  const factory AccountSetupEvent.surnameChanged(String surname) =
      EventAccountSetupSurnameChanged;

  /// Sự kiện thay đổi bioname
  const factory AccountSetupEvent.bioChanged(String bio) =
      EventAccountSetupBioChanged;

  /// Sự kiện thay đổi profile photo
  const factory AccountSetupEvent.profilePhotoChanged(File? profilePhoto) =
      EventAccountSetupProfilePhotoChanged;
}

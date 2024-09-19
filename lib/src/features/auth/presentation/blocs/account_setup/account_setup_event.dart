part of 'account_setup_bloc.dart';

@freezed
class AccountSetupEvent with _$AccountSetupEvent {
  const factory AccountSetupEvent.pageChanged(int index) =
      EventAccountSetupPageChanged;
  const factory AccountSetupEvent.usernameChanged(String username) =
      EventAccountSetupUsenameChanged;
  const factory AccountSetupEvent.nameChanged(String name) =
      EventAccountSetupNameChanged;
  const factory AccountSetupEvent.surnameChanged(String surname) =
      EventAccountSetupSurnameChanged;
  const factory AccountSetupEvent.bioChanged(String bio) =
      EventAccountSetupBioChanged;
  const factory AccountSetupEvent.profilePhotoChanged(File? profilePhoto) =
      EventAccountSetupProfilePhotoChanged;
}

part of 'account_setup_bloc.dart';

/// Trạng thái
@freezed
class AccountSetupState with _$AccountSetupState {
  /// Trạng thái
  const factory AccountSetupState({
    required int currentPage,
    required String username,
    required bool isFirstFormValid,
    required String name,
    required String surname,
    required bool isSecondFormValid,
    required String bio,
    required bool isThirdFormValid,
    required File? profilePhoto,
    required bool isProfilePhotoValid,
  }) = _AccountSetupState;

  /// Trang thái ban đầu
  factory AccountSetupState.initial() => const AccountSetupState(
        currentPage: 0,
        username: '',
        isFirstFormValid: false,
        name: '',
        surname: '',
        isSecondFormValid: false,
        bio: '',
        isThirdFormValid: false,
        profilePhoto: null,
        isProfilePhotoValid: false,
      );
}

import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_setup_bloc.freezed.dart';
part 'account_setup_event.dart';
part 'account_setup_state.dart';

/// Quản lý trạng thái của AccountSetupPage
class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  /// Constructor
  AccountSetupBloc() : super(AccountSetupState.initial()) {
    on<AccountSetupEvent>((events, emit) async {
      events.map(
        pageChanged: (event) => _onPageChanged(event, emit),
        usernameChanged: (event) => _onUsernameChanged(event, emit),
        nameChanged: (event) => _onNameChanged(event, emit),
        surnameChanged: (event) => _onSurnameChanged(event, emit),
        bioChanged: (event) => _onBioChanged(event, emit),
        profilePhotoChanged: (event) => _onProfilePhotoChanged(event, emit),
      );
    });
  }

  void _onPageChanged(
    EventAccountSetupPageChanged event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(state.copyWith(currentPage: event.index));
  }

  void _onUsernameChanged(
    EventAccountSetupUsenameChanged event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        username: event.username,
        isFirstFormValid: _isFormValided(event.username, ''),
      ),
    );
  }

  void _onNameChanged(
    EventAccountSetupNameChanged event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        name: event.name,
        isFirstFormValid: _isFormValided(event.name, state.surname),
      ),
    );
  }

  void _onSurnameChanged(
    EventAccountSetupSurnameChanged event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        surname: event.surname,
        isSecondFormValid: _isFormValided(state.name, event.surname),
      ),
    );
  }

  void _onBioChanged(
    EventAccountSetupBioChanged event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        bio: event.bio,
        isThirdFormValid: _isFormValided(event.bio, ''),
      ),
    );
  }

  void _onProfilePhotoChanged(
    EventAccountSetupProfilePhotoChanged event,
    Emitter<AccountSetupState> emit,
  ) {
    emit(
      state.copyWith(
        profilePhoto: event.profilePhoto,
        isProfilePhotoValid: _isProfilePhotoValided(event.profilePhoto),
      ),
    );
  }

  bool _isFormValided(String text1, String text2) {
    if (text2.isNotEmpty) {
      return text1.isNotEmpty && text2.isNotEmpty;
    }
    return text1.isNotEmpty;
  }

  bool _isProfilePhotoValided(File? profilePhoto) {
    return profilePhoto != null;
  }
}

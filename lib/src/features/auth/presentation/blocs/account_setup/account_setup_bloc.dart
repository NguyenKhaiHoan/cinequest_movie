import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_setup_event.dart';
part 'account_setup_state.dart';
part 'account_setup_bloc.freezed.dart';

class AccountSetupBloc extends Bloc<AccountSetupEvent, AccountSetupState> {
  AccountSetupBloc() : super(AccountSetupState.initial()) {
    on<AccountSetupEvent>((events, emit) async {
      events.map(
        pageChanged: (event) => onPageChanged(event, emit),
        usernameChanged: (event) => onUsernameChanged(event, emit),
        nameChanged: (event) => onNameChanged(event, emit),
        surnameChanged: (event) => onSurnameChanged(event, emit),
        bioChanged: (event) => onBioChanged(event, emit),
        profilePhotoChanged: (event) => onProfilePhotoChanged(event, emit),
      );
    });
  }

  void onPageChanged(
      EventAccountSetupPageChanged event, Emitter<AccountSetupState> emit) {
    emit(state.copyWith(currentPage: event.index));
  }

  void onUsernameChanged(
      EventAccountSetupUsenameChanged event, Emitter<AccountSetupState> emit) {
    emit(state.copyWith(
      username: event.username,
      isFirstFormValid: _isFormValided(event.username, ''),
    ));
  }

  void onNameChanged(
      EventAccountSetupNameChanged event, Emitter<AccountSetupState> emit) {
    emit(state.copyWith(
      name: event.name,
      isFirstFormValid: _isFormValided(event.name, state.surname),
    ));
  }

  void onSurnameChanged(
      EventAccountSetupSurnameChanged event, Emitter<AccountSetupState> emit) {
    emit(state.copyWith(
      surname: event.surname,
      isSecondFormValid: _isFormValided(state.name, event.surname),
    ));
  }

  void onBioChanged(
      EventAccountSetupBioChanged event, Emitter<AccountSetupState> emit) {
    emit(state.copyWith(
      bio: event.bio,
      isThirdFormValid: _isFormValided(event.bio, ''),
    ));
  }

  void onProfilePhotoChanged(EventAccountSetupProfilePhotoChanged event,
      Emitter<AccountSetupState> emit) {
    emit(state.copyWith(
      profilePhoto: event.profilePhoto,
      isProfilePhotoValid: _isProfilePhotoValided(event.profilePhoto),
    ));
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

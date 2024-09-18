part of 'account_setup_bloc.dart';

@freezed
class AccountSetupState with _$AccountSetupState {
  const factory AccountSetupState({required int currentPage}) =
      _AccountSetupState;

  factory AccountSetupState.initial() => const AccountSetupState(
        currentPage: 0,
      );
}

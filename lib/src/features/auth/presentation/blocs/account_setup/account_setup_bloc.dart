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
      );
    });
  }

  void onPageChanged(
      EventAccountSetupPageChanged event, Emitter<AccountSetupState> emit) {
    emit(state.copyWith(currentPage: event.index));
  }
}

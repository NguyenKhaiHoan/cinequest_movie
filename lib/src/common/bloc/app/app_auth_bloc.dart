import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_auth_bloc.freezed.dart';
part 'app_auth_event.dart';
part 'app_auth_state.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  AppAuthBloc() : super(const AppInitialState()) {
    on<AppAuthEvent>((events, emit) async {
      await events.map(
        started: (event) async => await onStarted(event, emit),
      );
    });
  }

  Future<void> onStarted(
      EventAppAuthStarted event, Emitter<AppAuthState> emit) async {
    var isLoggedIn = Random().nextBool();
    await Future.delayed(const Duration(seconds: 3));
    if (isLoggedIn) {
      emit(const AppAuthState.authenticated());
    } else {
      emit(const AppAuthState.unAuthenticated());
    }
  }
}

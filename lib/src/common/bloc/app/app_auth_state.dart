part of 'app_auth_bloc.dart';

@freezed
class AppAuthState with _$AppAuthState {
  const factory AppAuthState.initial() = AppInitialState;
  const factory AppAuthState.authenticated() = AppAuthenticatedState;
  const factory AppAuthState.unAuthenticated() = AppUnAuthenticatedState;
}

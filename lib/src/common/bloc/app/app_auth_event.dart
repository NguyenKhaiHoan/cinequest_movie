part of 'app_auth_bloc.dart';

@freezed
class AppAuthEvent with _$AppAuthEvent {
  const factory AppAuthEvent.started() = EventAppAuthStarted;
}

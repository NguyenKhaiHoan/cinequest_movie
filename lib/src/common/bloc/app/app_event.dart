part of 'app_bloc.dart';

/// Các sự kiện của App
@freezed
class AppEvent with _$AppEvent {
  /// Sự kiện chạy các logic khi app bắt đầu
  const factory AppEvent.started() = EventAppStarted;
}

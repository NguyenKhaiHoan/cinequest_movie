part of 'app_bloc.dart';

/// Các trạng thái của App
@freezed
class AppState with _$AppState {
  /// Trạng thái ban đầu
  const factory AppState.initial() = _AppInitialState;

  /// Trạng thái đã được xác thực
  const factory AppState.authenticated() = _AppAuthenticatedState;

  /// Trạng thái đã chưa setup account
  const factory AppState.accountNotSetup() = _AppAccountNotSetupState;

  /// Trạng thái chưa được xác thực và đưa ra lỗi nếu có nhận tham số
  ///
  /// - [failure] : lỗi không lấy được dữ liệu người dùng từ Firestore
  const factory AppState.unauthenticated({Failure? failure}) =
      _AppUnauthenticatedState;
}

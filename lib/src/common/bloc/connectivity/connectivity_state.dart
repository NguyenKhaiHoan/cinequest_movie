part of 'connectivity_bloc.dart';

/// Các trạng thái
@freezed
class ConnectivityState with _$ConnectivityState {
  /// Trạng thái ban đầu
  const factory ConnectivityState.initial() = _ConnectivityInitialState;

  /// Trạng thái kết nối thành công
  const factory ConnectivityState.success() = _ConnectivitySuccessState;

  /// Trạng thái kết nối lỗi
  const factory ConnectivityState.failure({required Failure failure}) =
      _ConnectivityFailureState;
}

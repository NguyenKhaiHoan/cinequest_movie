part of 'connectivity_bloc.dart';

/// Các sự kiện
@freezed
class ConnectivityEvent with _$ConnectivityEvent {
  /// Sự kiện trạng trạng kết nối mạng bị thay đổi nhận tham số
  ///
  /// - [isConnected] (bool) : Tình trạng kết nối
  const factory ConnectivityEvent.connectivityChanged({
    required bool isConnected,
  }) = EventConnectivityChanged;
}
